//
//  KSDownloaderOperation.h
//  KaiStory
//
//  Created by yanzehua on 15/5/5.
//  Copyright (c) 2015年 kaishu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"
#import "DownloadItem.h"
@interface KSDownloaderOperation : AFHTTPRequestOperation
@property (nonatomic, strong) DownloadItem* item;
@property (nonatomic) long long recievedBytes;
@property (nonatomic) long long totalBytes;
@end