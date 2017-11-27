//
//  ClassModel.m
//  KaiStory
//
//  Created by mac on 15/4/14.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "ClassModel.h"
#import "Tools.h"

@implementation ClassModel
-(id)initWithDict:(NSDictionary *)dict{
    if (self = [super initWithDict:dict]) {
        self.open_params = [dict valueForKey:@"open_params"];
        self.open_type = [dict valueForKey:@"open_type"];
        self.property_value_list = [dict valueForKey:@"property_value_list"];
        self.show_category_id = [dict valueForKey:@"show_category_id"];
        self.show_category_name = [dict valueForKey:@"show_category_name"];
        self.propertyList = [NSMutableArray array];

        
    }
    return self;
}
@end
@implementation PropertyModel

- (id)initWithDict:(NSDictionary *)dict{
    
    if (self = [super initWithDict:dict]) {
        self.open_method = [dict valueForKey:@"open_method"];
        self.open_params = [dict valueForKey:@"open_params"];
        self.open_type = [dict valueForKey:@"open_type"];
        self.open_url = [dict valueForKey:@"open_url"];
        self.property_id = [dict valueForKey:@"property_id"];
        self.property_value_id = [dict valueForKey:@"property_value_id"];
        self.property_vaule_name = [dict valueForKey:@"property_value_name"];
        
        NSLog(@"dict========%@",dict);
        NSLog(@"%@",self.open_params);
        
        NSDictionary *tt=[Tools dictionaryWithJsonString:self.open_params];
         NSLog(@"%@",tt);
        self.pid = [tt valueForKey:@"pid"];
        NSInteger mm = [tt valueForKey:@"pid"];
        self.value = [tt valueForKey:@"value"];
        

        
    }
    return self;
}
@end