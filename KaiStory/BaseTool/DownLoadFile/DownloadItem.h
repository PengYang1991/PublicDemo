//
//  DownloadItem.h
//  KaiStory
//
//  Created by yanzehua on 15/5/4.
//  Copyright (c) 2015年 kaishu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    KS_WAITING = 1,     //排队中
    KS_DOWNLOADING = 2, //下载中
    KS_PAUSING = 3,     //已暂停
    KS_FINISH = 4       //下载完成
}DownloadItemState;

@interface DownloadItem : NSObject

@property(strong,nonatomic)NSString* itemID;
@property(strong,nonatomic)NSString* srcUrl;
@property(strong,nonatomic)NSString* md5sum;
@property(strong,nonatomic)NSString* localPath;

//描述下载状态
@property(nonatomic)DownloadItemState downloadState;

@property(nonatomic)NSInteger totalBytes;
@property(nonatomic)NSInteger finishedBytes;

-(id)initWithBaseInfo:(NSString*) inputID  withSrcUrl:(NSString*) inputSrcUrl withMd5sum:(NSString*)inputMd5sum;
@end
