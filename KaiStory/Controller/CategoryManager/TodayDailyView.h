//
//  TodayDailyView.h
//  KaiStory
//
//  Created by yanzehua on 15/4/13.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DailyModel.h"

@interface TodayDailyView : UIView
{
    NSString* readPrefix;
    NSString* commentPrefix;
    NSString* sharePrefix;
    NSString* favorPrefix;
}

@property(nonatomic,strong)DailyModel* todayModel;

@property(nonatomic,strong)UILabel *todayName;
@property(nonatomic,strong)UILabel *todayTime;

@property(nonatomic,strong)UIImageView *todayImage;

@property(nonatomic,strong)UIImageView *readIcon;
@property(nonatomic,strong)UILabel *read_count;

@property(nonatomic,strong)UIImageView *commentIcon;
@property(nonatomic,strong)UILabel *comment_count;

@property(nonatomic,strong)UIImageView *shareIcon;
@property(nonatomic,strong)UILabel *share_count;

@property(nonatomic,strong)UIImageView *favorIcon;
@property(nonatomic,strong)UILabel *favor_count;

@property(nonatomic,strong)UIButton *ClickBtn;


-(void)setTodayInfo:(DailyModel*) todayModel;
- (void) initConst;
@end
