//
//  AlbumeModel.m
//  KaiStory
//
//  Created by yangpeng on 15/4/17.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "AlbumeModel.h"
#import "Tools.h"

@implementation AlbumeModel
- (id)initWithDict:(NSDictionary *)dict{
    
    if (self=[super initWithDict:dict])
    {
        self.author = [dict objectForKey:@"author"];
        self.banner_url = [dict objectForKey:@"banner_url"];
        self.icon_url = [dict objectForKey:@"icon_url"];
        self.m_id = [dict objectForKey:@"id"];
        self.media_count = [dict objectForKey:@"media_count"];
        self.name = [dict objectForKey:@"name"];
        self.open_method =[dict objectForKey:@"open_method"];
        self.open_params = [dict objectForKey:@"open_params"];
        self.open_type = [dict objectForKey:@"open_type"];
        self.open_url = [dict objectForKey:@"open_url"];
        self.publisher = [dict objectForKey:@"publisher"];
        self.release_time = [dict objectForKey:@"release_time"];
        self.summary = [dict objectForKey:@"summary"];
        NSDictionary *tt=[Tools dictionaryWithJsonString:self.open_params];
        NSLog(@"%@",tt);
        self.aid = [tt valueForKey:@"aid"];
    }
    
    return self;
}

@end
