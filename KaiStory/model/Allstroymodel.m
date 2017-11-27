//
//  Allstroymodel.m
//  KaiStory
//
//  Created by yangpeng on 15/5/9.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "Allstroymodel.h"

@implementation Allstroymodel
- (id)initWithDict:(NSDictionary *)dict{
    
    if (self=[super initWithDict:dict])
    {
        self.m_id = [dict objectForKey:@"id"];
        self.name = [dict objectForKey:@"name"];
        self.duration = [[dict objectForKey:@"duration"]integerValue];
        self.time_text = [dict objectForKey:@"time_text"];
        self.author = [dict objectForKey:@"author"];
        self.translater = [dict objectForKey:@"translater"];
        self.publisher = [dict objectForKey:@"translater"];
        self.icon_url = [dict objectForKey:@"icon_url"];
        self.media_url = [dict objectForKey:@"media_url"];
        self.cover_url = [dict objectForKey:@"cover_url"];
        self.play_count = [dict objectForKey:@"play_count"];
        self.download_count = [dict objectForKey:@"download_count"];
        self.favor_count = [dict objectForKey:@"favor_count"];
        self.image_provider = [dict objectForKey:@"image_provider"];
        self.category_id = [dict objectForKey:@"category_id"];
        self.release_date = [dict objectForKey:@"release_date"];
        self.kaishu_say = [dict objectForKey:@"kaishu_say"];
        self.counts =1;
    }
    
    return self;
}

@end
