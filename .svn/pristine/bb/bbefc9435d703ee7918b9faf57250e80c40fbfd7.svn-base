//
//  FindModel.m
//  KaiStory
//
//  Created by yangpeng on 15/3/16.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "FindModel.h"
#import "albumViewController.h"
@implementation FindModel

- (id)initWithDict:(NSDictionary *)dict{

    if (self = [super initWithDict:dict]) {
        
        self.m_id = [dict valueForKey:@"id"];
        self.name = [dict valueForKey:@"name"];
        self.text = [dict valueForKey:@"text"];
        self.open_type = [dict valueForKey:@"open_type"];
        self.open_url = [dict valueForKey:@"open_url"];
        self.open_params = [dict valueForKey:@"open_params"];
        self.open_method = [dict valueForKey:@"open_method"];
        self.icon_url = [dict valueForKey:@"icon_url"];
        self.banner_url = [dict valueForKey:@"banner_url"];
        self.create_time = [dict valueForKey:@"create_time"];

        
    }



    return self;
    
}
@end
@implementation LunBoModel

- (id)initWithDict:(NSDictionary *)dict{

    if (self = [super initWithDict:dict]) {
        
        self.M_id = [dict valueForKey:@"id"];
        self.img = [dict valueForKey:@"img"];
        self.opentype = [dict valueForKey:@"open_type"];
        self.open_url = [dict valueForKey:@"open_url"];
        self.open_params = [dict valueForKey:@"open_params"];
        self.open_method = [dict valueForKey:@"open_method"];
        self.text = [dict valueForKey:@"text"];

    }
   
    return self;
}
@end

@implementation StoryItem

- (id)initWithDict:(NSDictionary *)dict{

    if (self=[super initWithDict:dict]) {
//        self.open_method = [dict valueForKey:@"open_method"];
//        self.open_type = [dict valueForKey:@"open_type"];
//        self.open_url = [dict valueForKey:@"open_url"];
//        self.open_params = [dict valueForKey:@"open_params"];
//        self.text = [dict valueForKey:@"text"];
//         self.show_type = [dict valueForKey:@"show_type"];
        self.left_item = [dict objectForKey:@"left_item_view"];
        self.right_item = [dict objectForKey:@"right_item_view"];
        self.media_list = [dict objectForKey:@"media_list"];
//        albumViewController *album = [[albumViewController alloc]init];
//        [album setaldume:self.sort_media_list];
    }
    
   return self;
}

@end
@implementation SortItem

- (id)initWithDict:(NSDictionary *)dict{
    
    if (self=[super initWithDict:dict]) {
        
        self.author = [dict valueForKey:@"author"];
        self.banner_url = [dict valueForKey:@"banner_url"];
        self.buy_url = [dict valueForKey:@"buy_url"];
        self.cover_url = [dict valueForKey:@"cover_url"];
        self.download_count = [dict valueForKey:@"download_count"];
        self.duration = [dict valueForKey:@"duration"];
        self.favor_count = [dict valueForKey:@"favor_count"];
        self.icon_url = [dict valueForKey:@"icon_url"];
        self.m_id = [dict valueForKey:@"id"];
        self.image_provider = [dict valueForKey:@"image_provider"];
        self.is_buy = [dict valueForKey:@"is_buy"];
        self.is_pay = [dict valueForKey:@"is_pay"];
        self.media_url = [dict valueForKey:@"media_url"];
        self.name = [dict valueForKey:@"name"];
        self.open_method = [dict valueForKey:@"open_method"];
        self.open_params = [dict valueForKey:@"open_params"];
        self.open_type = [dict valueForKey:@"open_type"];
        self.open_url = [dict valueForKey:@"open_url"];
        self.play_count = [dict valueForKey:@"play_count"];
        self.price = [dict valueForKey:@"price"];
//        self.product_id = [dict valueForKey:@"product_id"];
        self.m_id = [dict valueForKey:@"id"];
        self.publisher = [dict valueForKey:@"publisher"];
        self.release_time = [dict valueForKey:@"release_time"];
        self.source = [dict valueForKey:@"source"];
        self.translater = [dict valueForKey:@"translater"];

        
    }
    
    return self;
}

@end






