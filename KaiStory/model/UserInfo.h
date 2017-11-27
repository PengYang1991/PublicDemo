//
//  UserInfo.h
//  KaiStory
//
//  Created by mac on 15/3/25.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "BaseModel.h"

@interface UserInfo : BaseModel
@property(nonatomic,strong)NSString *user_id;
@property(nonatomic,strong)NSString *user_name;
@property(nonatomic,strong)NSString *baby_name;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *sex;
@property(nonatomic,strong)NSString *age;
@property(nonatomic,strong)NSString *birthday;
@property(nonatomic,strong)NSString *listen_count;
@property(nonatomic,strong)NSString *continue_listen_day;
@property(nonatomic,strong)NSString *listen_total_time;
@property(nonatomic,strong)NSString *favor_count;
//@property(nonatomic,strong)NSString *ListenStoryTimes;

@property(nonatomic,strong)NSString *logStatus;


@end
