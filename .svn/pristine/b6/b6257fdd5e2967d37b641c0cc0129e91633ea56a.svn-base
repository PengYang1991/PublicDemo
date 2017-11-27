//
//  StoryModel.m
//  KaiStory
//
//  Created by mac on 15/3/26.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "StoryModel.h"

@implementation StoryModel

-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.m_id = [dict valueForKey:@"id"];
//        self.product_id = [dict valueForKey:@"product_id"];
        self.m_id = [dict valueForKey:@"id"];
        self.name = [dict valueForKey:@"name"];
        self.source= [dict valueForKey:@"source"];
        self.price = [dict valueForKey:@"price"];
        NSString *Price =[dict valueForKey:@"price"];
        NSLog(@"Price=====%@",Price);
        self.duration = [dict valueForKey:@"duration"];
        self.is_buy= [dict valueForKey:@"is_buy"];
        self.author = [dict valueForKey:@"author"];
        self.translater = [dict valueForKey:@"translater"];
        self.publisher = [dict valueForKey:@"publisher"];
        self.open_type = [dict valueForKey:@"open_type"];
        self.open_url = [dict valueForKey:@"open_url"];
        self.open_params = [dict valueForKey:@"open_params"];
        self.open_method = [dict valueForKey:@"open_method"];
        self.icon_url = [dict valueForKey:@"icon_url"];
        self.cover_url = [dict valueForKey:@"cover_url"];
        self.banner_url = [dict valueForKey:@"banner_url"];
        self.media_url = [dict valueForKey:@"media_url"];
        self.play_count = [dict valueForKey:@"play_count"];
        self.download_count = [dict valueForKey:@"download_count"];
        self.favor_count = [dict valueForKey:@"favor_count"];
        self.release_time = [dict valueForKey:@"release_time"];
        self.is_pay = [dict valueForKey:@"is_pay"];
        self.buy_url = [dict valueForKey:@"buy_url"];
        self.image_provider = [dict valueForKey:@"image_provider"];
        self.summary = [dict valueForKey:@"summary"];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)coder
{
    if ((self =[super init])) {
        self.m_id = [coder decodeObjectForKey:@"id"];
        self.m_id = [coder decodeObjectForKey:@"product_id"];
        self.name = [coder decodeObjectForKey:@"name"];
        self.source = [coder decodeObjectForKey:@"source"];
        self.price = [coder decodeObjectForKey:@"price"];
        self.duration = [coder decodeObjectForKey:@"duration"];
        self.is_buy = [coder decodeObjectForKey:@"is_buy"];
        self.author = [coder decodeObjectForKey:@"autor"];
        self.translater = [coder decodeObjectForKey:@"translater"];
        self.publisher = [coder decodeObjectForKey:@"publisher"];
        self.open_type = [coder decodeObjectForKey:@"open_type"];
        self.open_url = [coder decodeObjectForKey:@"open_url"];
        self.open_params = [coder decodeObjectForKey:@"open_params"];
        self.open_method = [coder decodeObjectForKey:@"open_method"];
        self.icon_url = [coder decodeObjectForKey:@"icon_url"];
        self.cover_url = [coder decodeObjectForKey:@"cover_url"];
        self.banner_url = [coder decodeObjectForKey:@"banner_url"];
        self.media_url = [coder decodeObjectForKey:@"media_url"];
        self.play_count = [coder decodeObjectForKey:@"play_count"];
        self.download_count = [coder decodeObjectForKey:@"download_count"];
        self.favor_count = [coder decodeObjectForKey:@"favor_count"];
        self.release_time = [coder decodeObjectForKey:@"release_time"];
        self.is_pay = [coder decodeObjectForKey:@"is_pay"];
        self.buy_url = [coder decodeObjectForKey:@"buy_url"];
        self.image_provider = [coder decodeObjectForKey:@"image_provider"];
        self.summary = [coder decodeObjectForKey:@"summary"];
    }
    return self;
}
-(void)encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject:self.m_id forKey:@"id"];
    [coder encodeObject:self.m_id forKey:@"product_id"];
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.source forKey:@"source"];
    [coder encodeObject:self.price forKey:@"price"];
    [coder encodeObject:self.duration forKey:@"duration"];
    [coder encodeObject:self.is_buy forKey:@"is_buy"];
    [coder encodeObject:self.author forKey:@"author"];
    [coder encodeObject:self.translater forKey:@"translater"];
    [coder encodeObject:self.publisher forKey:@"publisher"];
    [coder encodeObject:self.open_type forKey:@"open_type"];
    [coder encodeObject:self.open_url forKey:@"open_url"];
    [coder encodeObject:self.open_params forKey:@"open_params"];
    [coder encodeObject:self.open_method forKey:@"open_method"];
    [coder encodeObject:self.icon_url forKey:@"icon_url"];
    [coder encodeObject:self.cover_url forKey:@"cover_url"];
    [coder encodeObject:self.banner_url forKey:@"banner_url"];
    [coder encodeObject:self.media_url forKey:@"media_url"];
    [coder encodeObject:self.play_count forKey:@"play_count"];
    [coder encodeObject:self.download_count forKey:@"download_count"];
    [coder encodeObject:self.favor_count forKey:@"favor_count"];
    [coder encodeObject:self.release_time  forKey:@"release_time"];
    [coder encodeObject:self.is_pay forKey:@"is_pay"];
    [coder encodeObject:self.buy_url forKey:@"buy_url"];
    [coder encodeObject:self.image_provider forKey:@"image_provider"];
    [coder encodeObject:self.summary forKey:@"summary"];
}

@end
