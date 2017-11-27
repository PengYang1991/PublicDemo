//
//  DownloadItem.m
//  KaiStory
//
//  Created by yanzehua on 15/5/4.
//  Copyright (c) 2015年 kaishu. All rights reserved.
//

#import "DownloadItem.h"
#import "StoryModel.h"


@implementation DownloadItem

-(id)initWithBaseInfo:(NSString*) inputID  withSrcUrl:(NSString*) inputSrcUrl withMd5sum:(NSString*)inputMd5sum
{
    self = [super init];
    self.itemID = inputID;
    self.srcUrl = inputSrcUrl;
    self.md5sum = inputMd5sum;
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentDirectory = [paths objectAtIndex:0];
    self.localPath = [NSString stringWithFormat:@"%@.mp3", self.itemID];
    self.localPath = [documentDirectory stringByAppendingPathComponent:self.localPath];
    
    //默认为等待状态
    self.downloadState = KS_WAITING;
    self.totalBytes = -1;
    self.finishedBytes = -1;
    
    return self;
}


-(id)initWithCoder:(NSCoder *)coder
{
    if ((self =[super init])) {
        self.itemID = [coder decodeObjectForKey:@"itemID"];
        self.srcUrl = [coder decodeObjectForKey:@"srcUrl"];
        self.md5sum = [coder decodeObjectForKey:@"md5sum"];
        self.localPath = [coder decodeObjectForKey:@"localPath"];
        self.downloadState = [coder decodeIntegerForKey:@"downloadState"];
        self.totalBytes = [coder decodeIntegerForKey:@"totalBytes"];
        self.finishedBytes = [coder decodeIntegerForKey:@"finishedBytes"];
    }
    return self;
}
-(void)encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject:self.itemID forKey:@"itemID"];
    [coder encodeObject:self.srcUrl forKey:@"srcUrl"];
    [coder encodeObject:self.md5sum forKey:@"md5sum"];
    [coder encodeObject:self.localPath forKey:@"localPath"];
    [coder encodeInteger:self.downloadState forKey:@"downloadState"];
    [coder encodeInteger:self.totalBytes forKey:@"totalBytes"];
    [coder encodeInteger:self.finishedBytes forKey:@"finishedBytes"];
}

@end
