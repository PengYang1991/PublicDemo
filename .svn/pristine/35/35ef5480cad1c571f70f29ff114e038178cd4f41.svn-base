//
//  KSDownloader.m
//  KaiStory
//
//  Created by yanzehua on 15/5/5.
//  Copyright (c) 2015年 kaishu. All rights reserved.
//

#import "KSDownloader.h"
#import "Tools.h"

@implementation KSDownloader

static KSDownloader *instance = NULL;

+(KSDownloader*)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[KSDownloader  alloc]init];
        instance.isDownloading = NO;
        [instance  loadDownloadArray];
        instance.opArray = [[NSMutableArray alloc]initWithCapacity:3];
    });
    return instance;
}


-(NSInteger) itemIndexOf:(NSInteger) itemID
{
    for(NSUInteger i = 0; i<[self.downloadArray count]; i++)
    {
        DownloadItem* item = [self.downloadArray objectAtIndex:i];
        if( [item.itemID integerValue] == itemID )
        {
            return i;
        }
    }
    return -1;
}

-(void)addADownloadItem:(DownloadItem*) item
{
    @synchronized(self)
    {
        NSString* itemID= item.itemID;
        NSInteger indexOfItem = [self itemIndexOf:[itemID integerValue]];
        //如果不包含该key值，那么添加进入下载队列
        if( -1 == indexOfItem )
        {
            //把该内容插入队列的最前端
            [self.downloadArray insertObject:item atIndex:0];
            //存储该数据
            [KSDownloader saveDownloadItem:item];
            [self saveDownloadArray];
            //开始下载
            [self startDownloadQueue];
        }else
        {
            //如果文件已经被包含在列表中，如果该下载任务被暂停，则需要恢复该任务
            DownloadItem* existItem = [self.downloadArray objectAtIndex:indexOfItem];
            if(KS_PAUSING == existItem.downloadState)
            {
                existItem.downloadState = KS_WAITING;
            }
            [self startDownloadQueue];
            
            //TODO 同样的ID但是MD5不一致的情况
        }
    }
}

-(BOOL) needDownload
{
    for(NSUInteger i = 0; i<[self.downloadArray count]; i++)
    {
        DownloadItem* item = [self.downloadArray objectAtIndex:i];
        if(KS_WAITING == item.downloadState)
            return YES;
    }
    return NO;
}

//开始单线程下载，
-(void)startDownloadQueue
{
    @synchronized(self)
    {
        if(self.isDownloading)
        {
            return;
        }
        for(NSUInteger i = 0; i<[self.downloadArray count]; i++)
        {
            DownloadItem* item = [self.downloadArray objectAtIndex:i];
            if(KS_WAITING == item.downloadState){
                [self download:item];
                break;
            }
        }
    }
}

//工具方法，用来获取指定路径上文件的大小
-(long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

-(void)download:(DownloadItem*) item
{
    //更新待下载项目的状态 和 下载进行状态
    item.downloadState = KS_DOWNLOADING;
    self.isDownloading = YES;
    
    NSURL *url = [NSURL URLWithString:item.srcUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    item.finishedBytes = [self fileSizeAtPath:item.localPath];
    //如果已经存在一定字节，说明需要采用续传
    if(item.finishedBytes > 0)
    {
        long long finishedBytes = item.finishedBytes;
        NSString *requestRange = [NSString stringWithFormat:@"bytes=%lld-", finishedBytes];
        [request setValue:requestRange forHTTPHeaderField:@"RANGE"];
    }
    KSDownloaderOperation *op  = [[KSDownloaderOperation alloc]initWithRequest:request];
    [op setItem:item];
    
    NSLog(@"Item's LocalPath %@",item.localPath);
    
    if(item.finishedBytes > 0){
        op.outputStream = [[NSOutputStream alloc]initToFileAtPath:item.localPath append:YES];
    }else
    {
        op.outputStream = [[NSOutputStream alloc]initToFileAtPath:item.localPath append:NO];
    }
    [[NSURLCache sharedURLCache] removeCachedResponseForRequest:request];
    
    long long finishedBytes = item.finishedBytes;
    __block KSDownloaderOperation *blockOp = op;
    [op setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        
        CGFloat progress = ((float) totalBytesRead+finishedBytes)/(totalBytesExpectedToRead+finishedBytes);
        NSLog(@"progress==%f,%lld,%lld",progress,totalBytesRead+finishedBytes, totalBytesExpectedToRead+finishedBytes);
        //创建进度的通知
        NSString *progre = [NSString stringWithFormat:@"%.2f%%",progress*100];
        NSString* readBytes = [NSString stringWithFormat:@"%lld",totalBytesRead];
        NSString* totalBytes = [NSString stringWithFormat:@"%lld",totalBytesExpectedToRead];
        blockOp.item.totalBytes = totalBytesExpectedToRead;
        blockOp.item.finishedBytes = totalBytesRead;
        NSDictionary *dic = @{@"progress":progre,@"itemId":item.itemID,@"readBytes":readBytes,@"totalBytes":totalBytes};
        [[NSNotificationCenter defaultCenter]postNotificationName:@"DOWNLOAD_PROGRESS" object:self userInfo:dic ];
        NSLog(@"bytes==%lld",totalBytesRead);
    }];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"下载成功");
        //将该数据转成File的对象
        self.isDownloading = NO;
        blockOp.item.downloadState = KS_FINISH;
        [KSDownloader saveDownloadItem:blockOp.item];
        NSLog(@"Finished %lld, expected %lld",[self fileSizeAtPath:item.localPath],blockOp.item.totalBytes);
        //TODO
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"已停止");
        blockOp.item.downloadState = KS_WAITING;
        NSLog(@"Error !: %@", [error localizedDescription]);
        self.isDownloading = NO;
    }];
    
    self.currentOp = op;
    [op start];
}


-(void)stopDownloadAItem:(DownloadItem*) item
{
    if(self.isDownloading && KS_DOWNLOADING == item.downloadState)
    {
        //更新当前状态
        [self.currentOp pause];
        [self.currentOp.outputStream close];
        [self.currentOp cancel];
        self.currentOp.item = nil;
        
        //存储对应item
        self.isDownloading = NO;
        item.downloadState = KS_PAUSING;
        item.finishedBytes = [self fileSizeAtPath:item.localPath];
        [KSDownloader saveDownloadItem:item];
    }
}

-(void)startDownloadAItem:(DownloadItem*) item
{
    NSString* itemID= item.itemID;
    NSInteger indexOfItem = [self itemIndexOf:[itemID integerValue]];
    //如果不包含该key值，说明此操作出现异常
    if( -1 == indexOfItem )
    {
        // ByPass
        return;
    }
    
    if(nil!= self.currentOp && nil != self.currentOp.item)
    {
        if(self.isDownloading)
        {
            NSInteger currentID = [self.currentOp.item.itemID integerValue];
            //判断当前正在下载的内容是否一致
            if( currentID == [itemID integerValue] )
            {
                //ByPass
            }
        }
        [self stopDownloadAItem:self.currentOp.item];
    }
    
    [self download:item];
}


- (void)loadDownloadArray
{
    NSMutableArray* downloadIDList = [[NSMutableArray alloc]init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSData *userData = [prefs objectForKey:@"DOWNLOAD_STORY"];
    if (userData != nil)
    {
        NSArray* array = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        [downloadIDList addObjectsFromArray:array];
    }
    self.downloadArray = [[NSMutableArray alloc]init];
    for(NSString* itemID in downloadIDList)
    {
        DownloadItem* item = [KSDownloader getDownloadItem:itemID];
        [self.downloadArray addObject:item];
    }
}
- (void)saveDownloadArray
{
    NSMutableArray* downloadIDList = [[NSMutableArray alloc]init];
    for(DownloadItem* item in self.downloadArray)
    {
        [downloadIDList addObject:item.itemID];
    }
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:[NSKeyedArchiver archivedDataWithRootObject:downloadIDList] forKey:@"DOWNLOAD_STORY"];
    [prefs synchronize];
}

+(void) saveDownloadItem:(DownloadItem*) downloadItem
{
    NSString *modelStr = [[NSKeyedArchiver archivedDataWithRootObject:downloadItem] base64Encoding];
    NSString *modelKey = [NSString stringWithFormat:@"DOWNLOADINFO_%@",downloadItem.itemID ];
    [Tools setCacheJson:modelStr forKey:modelKey];
}
+(DownloadItem*) getDownloadItem:(NSString*) itemID
{
    NSString* modelKey = [NSString stringWithFormat:@"DOWNLOADINFO_%@",itemID];
    NSString* modelStr = [Tools getCacheJson:modelKey];
    NSData* modelData = [[NSData alloc]initWithBase64Encoding:modelStr];
    DownloadItem *model = [NSKeyedUnarchiver unarchiveObjectWithData:modelData];
    return model;
}

-(NSString*)getFinishedFile:(NSString*) itemIDStr
{
    NSInteger destID = [itemIDStr integerValue];
    for(NSUInteger i = 0; i<[self.downloadArray count]; i++)
    {
        DownloadItem* item = [self.downloadArray objectAtIndex:i];
        NSInteger itemID = [item.itemID integerValue];
        if(itemID == destID && KS_FINISH == item.downloadState)
        {
            if(item.totalBytes == [self fileSizeAtPath:item.localPath])
            {
                return item.localPath;
            }
            else
            {
                //TODO 移除文件
            }
        }
    }
    return nil;
}

- (void)removeFromDownloadList:(NSUInteger)indexInList
{

}

@end
