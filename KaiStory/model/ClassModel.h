//
//  ClassModel.h
//  KaiStory
//
//  Created by mac on 15/4/14.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "BaseModel.h"

@interface ClassModel : BaseModel


@property(strong,nonatomic)NSString *open_params;
@property(strong,nonatomic)NSString *open_type;
@property(strong,nonatomic)NSDictionary *property_value_list;
@property(strong,nonatomic)NSString *show_category_id;
@property(strong,nonatomic)NSString *show_category_name;
@property(strong,nonatomic)NSMutableArray *propertyList;
@property(assign,nonatomic)NSInteger m_Index;


@end
@interface PropertyModel : BaseModel
@property(strong,nonatomic)NSString *open_method;
@property(strong,nonatomic)NSString *open_params;
@property(strong,nonatomic)NSString *open_type;
@property(strong,nonatomic)NSString *open_url;
@property(strong,nonatomic)NSString *property_id;
@property(strong,nonatomic)NSString *property_value_id;
@property(strong,nonatomic)NSString *property_vaule_name;
@property(strong,nonatomic)NSString *pid;
@property(strong,nonatomic)NSString *value;

@end