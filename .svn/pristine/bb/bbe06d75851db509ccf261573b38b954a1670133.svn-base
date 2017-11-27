//
//  KSDownloader.h
//  KaiStory
//
//  Created by yanzehua on 15/5/5.
//  Copyright (c) 2015年 kaishu. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"
#import "DownloadItem.h"
#import "KSDownloaderOperation.h"

@interface KSDownloader : NSObject

@property(strong,nonatomic)NSMutableArray *opArray;
@property(strong,nonatomic)NSMutableArray* downloadArray;
@property(strong,nonatomic)KSDownloaderOperation* currentOp;
@property BOOL isDownloading;


- (void)removeFromDownloadList:(NSUInteger)indexInList;
- (void)loadDownloadArray;
- (void)saveDownloadArray;

-(void)startDownloadQueue;
-(void)addADownloadItem:(DownloadItem*) item;
-(void)stopDownloadAItem:(DownloadItem*) item;
-(void)startDownloadAItem:(DownloadItem*) item;

+(KSDownloader*)shareInstance;
-(NSString*)getFinishedFile:(NSString*) itemID;
-(NSInteger) itemIndexOf:(NSInteger) itemID;
@end

