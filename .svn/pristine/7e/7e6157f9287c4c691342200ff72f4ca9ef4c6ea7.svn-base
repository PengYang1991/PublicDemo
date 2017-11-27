//
//  UserInfo.m
//  KaiStory
//
//  Created by mac on 15/3/25.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo
-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.user_id = [dict valueForKey:@"user_id"];
        self.baby_name = [dict valueForKey:@"baby_name"];
        self.user_name = [dict valueForKey:@"user_name"];
        self.mobile = [dict valueForKey:@"mobile"];
        self.sex = [dict valueForKey:@"sex"];
        self.age = [dict valueForKey:@"age"];
        self.birthday = [dict valueForKey:@"birthday"];
        self.listen_count = [dict valueForKey:@"listen_count"];
        self.continue_listen_day = [dict valueForKey:@"continue_listen_day"];
        self.listen_total_time = [dict valueForKey:@"listen_total_time"];
        self.favor_count = [dict valueForKey:@"favor_count"];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)coder
{
    if ((self =[super init])) {

        self.user_id = [coder decodeObjectForKey:@"user_id"];
        self.user_name = [coder decodeObjectForKey:@"user_name"];
        self.baby_name = [coder decodeObjectForKey:@"baby_name"];
        self.mobile = [coder decodeObjectForKey:@"mobile"];
        self.sex = [coder decodeObjectForKey:@"sex"];
        self.age = [coder decodeObjectForKey:@"age"];
        self.birthday = [coder decodeObjectForKey:@"birthday"];
        self.listen_count = [coder decodeObjectForKey:@"listen_count"];
        self.listen_total_time = [coder decodeObjectForKey:@"listen_total_time"];
        self.favor_count = [coder decodeObjectForKey:@"favor_count"];
        self.logStatus = [coder decodeObjectForKey:@"logStatus"];
        
    }
    return self;
}
-(void)encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject:self.user_id forKey:@"user_id"];
    [coder encodeObject:self.baby_name forKey:@"baby_name"];
    [coder encodeObject:self.user_name forKey:@"user_name"];
    [coder encodeObject:self.mobile forKey:@"mobile"];
    [coder encodeObject:self.sex forKey:@"sex"];
    [coder encodeObject:self.age forKey:@"age"];
    [coder encodeObject:self.birthday forKey:@"birthday"];
    [coder encodeObject:self.listen_count forKey:@"listen_count"];
    [coder encodeObject:self.listen_total_time forKey:@"listen_total_time"];
    [coder encodeObject:self.favor_count forKey:@"favor_count"];
    [coder encodeObject:self.logStatus forKey:@"logStatus"];
   
}

@end
