//
//  TodayDaily.h
//  KaiStory
//
//  Created by mac on 15/4/9.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DailyModel.h"

@interface TodayDaily : UIView{
    int PADDING;
    int PADDING_TOP;
    int TITLE_FONT_SIZE;
    NSString* TITLE_FONT_COLOR;
    int DATE_FONT_SIZE;
    NSString* DATE_FONT_COLOR;
}
@property ( nonatomic) IBOutlet UILabel *todayName;
@property ( nonatomic) IBOutlet UILabel *todayTime;
@property ( nonatomic) IBOutlet UIImageView *todayImage;
@property ( nonatomic) IBOutlet UILabel *read_count;
@property ( nonatomic) IBOutlet UILabel *comment_count;
@property ( nonatomic) IBOutlet UILabel *share_count;
@property ( nonatomic) IBOutlet UILabel *favor_count;


-(void)setTodayInfo:(DailyModel*) todayModel;
- (void) initLayoutConst;

@end
