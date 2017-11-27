//  BaseModel.m
//  KaiStory
//
//  Created by mac on 15/2/9.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

//@property (strong,nonatomic)NSString *resCode;
//@property (strong,nonatomic)NSString *resMsg;

#import "BaseModel.h"

@implementation BaseModel
-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.resCode = [dict valueForKey:@"resCode"];
        self.resMsg = [dict valueForKey:@"resMsg"];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)coder
{
    if ((self =[super init])) {
        self.resCode = (NSString *)[coder decodeObjectForKey:@"resCode"];
        self.resMsg = [coder decodeObjectForKey:@"resMsg"];
    }
    return self;
}
-(void)encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject:self.resCode forKey:@"resCode"];
    [coder encodeObject:self.resMsg forKey:@"resMsg"];
}

@end
