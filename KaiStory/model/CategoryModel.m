//
//  CategoryModel.m
//  KaiStory
//
//  Created by mac on 15/3/31.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "CategoryModel.h"

@implementation CategoryModel

-(id)initWithDict:(NSDictionary *)dict{
    if (self = [super initWithDict:dict]) {
        self.m_id = [dict valueForKey:@"id"];
        self.name = [dict valueForKey:@"name"];
        self.text = [dict valueForKey:@"text"];
        self.icon_url = [dict valueForKey:@"icon_url"];
        self.banner_url = [dict valueForKey:@"banner_url"];
        self.open_type = [dict valueForKey:@"open_type"];
        self.open_url = [dict valueForKey:@"open_url"];
        self.open_params = [dict valueForKey:@"open_params"];
        self.open_method = [dict valueForKey:@"open_method"];
        self.create_time = [dict valueForKey:@"create_time"];
    }
    return self;
}
@end
