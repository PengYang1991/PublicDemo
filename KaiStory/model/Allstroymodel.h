//
//  Allstroymodel.h
//  KaiStory
//
//  Created by yangpeng on 15/5/9.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "BaseModel.h"

@interface Allstroymodel : BaseModel

@property(nonatomic,strong)NSString *m_id;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,assign)NSInteger duration;
@property(nonatomic,strong)NSString *time_text;
@property(nonatomic,strong)NSString *author;
@property(nonatomic,strong)NSString *translater;
@property(nonatomic,strong)NSString *publisher;
@property(nonatomic,strong)NSString *icon_url;
@property(nonatomic,strong)NSString *cover_url;
@property(nonatomic,strong)NSString *media_url;
@property(nonatomic,strong)NSString *play_count;
@property(nonatomic,strong)NSString *download_count;
@property(nonatomic,strong)NSString *favor_count;
@property(nonatomic,strong)NSString *image_provider;
@property(nonatomic,strong)NSString *category_id;
@property(nonatomic,strong)NSString *release_date;
@property(nonatomic,strong)NSString *kaishu_say;
@property (nonatomic,assign)NSInteger counts;


@end
