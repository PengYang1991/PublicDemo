//
//  DailyModel.h
//  KaiStory
//
//  Created by mac on 15/3/13.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "BaseModel.h"

@interface DailyModel : BaseModel

@property(strong,nonatomic)NSString *m_id;
@property(strong,nonatomic)NSString *title;
@property(strong,nonatomic)NSString *summary;
@property(strong,nonatomic)NSString *open_type;
@property(strong,nonatomic)NSString *open_url;
@property(strong,nonatomic)NSString *open_param;
@property(strong,nonatomic)NSString *open_method;
@property(strong,nonatomic)NSString *img_url;
@property(strong,nonatomic)NSString *release_date;
@property(strong,nonatomic)NSString *read_count;
@property(strong,nonatomic)NSString *comment_count;
@property(strong,nonatomic)NSString *share_count;
@property(strong,nonatomic)NSString *favor_count;

@end
