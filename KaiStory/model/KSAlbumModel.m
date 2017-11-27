//
//  KSAlbumModel.m
//  KaiStory
//
//  Created by yanzehua on 15/5/11.
//  Copyright (c) 2015年 kaishu. All rights reserved.
//

#import "KSAlbumModel.h"

@implementation KSAlbumModel


-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.modelName = [dict valueForKey:@"modelName"];
        self.modelID = [dict valueForKey:@"modelID"];
        self.modelPic = [dict valueForKey:@"modelPic"];
        self.requestUrl = [dict valueForKey:@"requestUrl"];
        self.requestParams = [dict valueForKey:@"requestParams"];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)coder
{
    if ((self =[super init])) {
        self.modelName = [coder decodeObjectForKey:@"modelName"];
        self.modelID = [coder decodeObjectForKey:@"modelID"];
        self.modelPic = [coder decodeObjectForKey:@"modelPic"];
        self.requestUrl = [coder decodeObjectForKey:@"requestUrl"];
        self.requestParams = [coder decodeObjectForKey:@"requestParams"];
    }
    return self;
}
-(void)encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject:self.modelName forKey:@"modelName"];
    [coder encodeObject:self.modelID forKey:@"modelID"];
    [coder encodeObject:self.modelPic forKey:@"modelPic"];
    [coder encodeObject:self.requestUrl forKey:@"requestUrl"];
    [coder encodeObject:self.requestParams forKey:@"requestParams"];
}


@end
