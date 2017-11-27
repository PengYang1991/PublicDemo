//
//  DailyModel.m
//  KaiStory
//
//  Created by mac on 15/3/13.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "DailyModel.h"

@implementation DailyModel

-(id)initWithDict:(NSDictionary *)dict{
    if (self = [super initWithDict:dict]) {
        self.m_id = [dict valueForKey:@"id"];
        NSString *ID = [dict valueForKey:@"id"];
        self.m_id = ID;
        
        self.title = [dict valueForKey:@"title"];
        NSString *titele = [dict valueForKey:@"title"];
        self.title = titele;
        self.summary = [dict valueForKey:@"summary"];
        self.open_type = [dict valueForKey:@"open_type"];
        self.open_url = [dict valueForKey:@"open_url"];
        self.open_param = [dict valueForKey:@"open_param"];
        self.open_method = [dict valueForKey:@"open_method"];
        self.img_url = [dict valueForKey:@"img_url"];
        self.release_date = [dict valueForKey:@"release_date"];
        self.read_count = [dict valueForKey:@"read_count"];
        self.comment_count = [dict valueForKey:@"comment_count"];
        self.share_count = [dict valueForKey:@"share_count"];
        self.favor_count = [dict valueForKey:@"favor_count"];
        
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)coder{
    
    if (self = [super initWithCoder:coder]) {
        self.m_id = [coder decodeObjectForKey:@"id"];
        self.title = [coder decodeObjectForKey:@"title"];
        self.summary = [coder decodeObjectForKey:@"summary"];
        self.open_type = [coder decodeObjectForKey:@"open_type"];
        self.open_url = [coder decodeObjectForKey:@"open_url"];
        self.open_param = [coder decodeObjectForKey:@"open_param"];
        self.open_method = [coder decodeObjectForKey:@"open_method"];
        self.img_url = [coder decodeObjectForKey:@"img_url"];
        self.release_date = [coder decodeObjectForKey:@"release_date"];
        self.read_count = [coder decodeObjectForKey:@"read_count"];
        self.comment_count = [coder decodeObjectForKey:@"comment_count"];
        self.share_count = [coder decodeObjectForKey:@"share_count"];
        self.favor_count = [coder decodeObjectForKey:@"favor_count"];
    }
    return self;
    
}
-(void)encodeWithCoder:(NSCoder *)coder{
    [super encodeWithCoder:coder];
    [coder encodeObject:self.m_id forKey:@"id"];
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.summary forKey:@"summmary"];
    [coder encodeObject:self.open_type forKey:@"open_type"];
    [coder encodeObject:self.open_url forKey:@"open_url"];
    [coder encodeObject:self.open_param forKey:@"open_param"];
    [coder encodeObject:self.open_method forKey:@"open_method"];
    [coder encodeObject:self.img_url forKey:@"img_url"];
    [coder encodeObject:self.release_date forKey:@"release_date"];
    [coder encodeObject:self.read_count forKey:@"read_count"];
    [coder encodeObject:self.comment_count forKey:@"comment_count"];
    [coder encodeObject:self.share_count forKey:@"share_count"];
    [coder encodeObject:self.favor_count forKey:@"favor_count"];
}

@end
