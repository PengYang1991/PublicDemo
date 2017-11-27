//
//  TodayDaily.m
//  KaiStory
//
//  Created by mac on 15/4/9.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "TodayDaily.h"
#import "Tools.h"
#import "UIColor+HexStringToColor.h"
#import "Tools.h"
#import "UIImageView+AFNetworking.h"
#import "UIImageView+WebCache.h"

@implementation TodayDaily

- (void) initLayoutConst
{
    PADDING = 20/2 * RESIZE_RATIO;
    PADDING_TOP = 26/2 * RESIZE_RATIO;
    TITLE_FONT_SIZE = 30/2 * RESIZE_RATIO;
    TITLE_FONT_COLOR = @"808080";
    DATE_FONT_SIZE = 20/2*RESIZE_RATIO;
    DATE_FONT_COLOR = @"4ab19a";
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self initLayoutConst];
    [self setBackgroundColor:[UIColor whiteColor]];
    self.userInteractionEnabled = YES;
    
    int WIDTH = frame.size.width;
    int HEIGHT = frame.size.height;
    
    if (self) {
        
        self.todayName =[[UILabel alloc]initWithFrame:CGRectMake(PADDING, PADDING_TOP, WIDTH-PADDING, TITLE_FONT_SIZE)];
        self.todayName.font =  [UIFont boldSystemFontOfSize:TITLE_FONT_SIZE];
        UIColor *todayNameColor = [UIColor ColorWithHexString:TITLE_FONT_COLOR];
        self.todayName.textColor = todayNameColor;
        [self addSubview:self.todayName];
        
        self.todayTime = [[UILabel alloc]initWithFrame:CGRectMake(16, 32, WIDTH-32, DATE_FONT_SIZE)];
        self.todayTime.font =  [UIFont boldSystemFontOfSize:DATE_FONT_SIZE];
        UIColor *todayTimeColor = [UIColor ColorWithHexString:DATE_FONT_COLOR];
        self.todayTime.textColor = todayTimeColor;
        [self addSubview:self.todayTime];
        
        self.todayImage =[[UIImageView alloc]initWithFrame:CGRectMake(16, 60, WIDTH-32, 185)];
        [self addSubview:self.todayImage];
        

        self.read_count =[[UILabel alloc]initWithFrame:CGRectMake(40, 250, 40, 15)];
        [self addSubview:self.read_count];
        
    }
    return self;
}


-(void)setTodayInfo:(DailyModel*) todayModel{

}

@end
