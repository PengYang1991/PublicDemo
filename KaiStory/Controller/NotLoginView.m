//
//  NotLoginView.m
//  KaiStory
//
//  Created by yanzehua on 15/4/18.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "NotLoginView.h"
#import "Tools.h"
#import "UIColor+HexStringToColor.h"


@implementation NotLoginView


-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self setBackgroundColor:[UIColor ColorWithHexString:@"4EB19B"]];
        int const headViewMarginTop =18;
        int const headViewMarginLeft = 28;
        int const headViewSize = 186;
        
        UIImageView* headView = [[UIImageView alloc] initWithFrame:CGRectMake(headViewMarginLeft*RESIZE_RATIO, headViewMarginTop*RESIZE_RATIO, headViewSize*RESIZE_RATIO,headViewSize*RESIZE_RATIO)];
 
        NSUserDefaults *userDeFaults = [NSUserDefaults standardUserDefaults];
        NSInteger babySex = [Tools getBabySex];
        if(1 == babySex)
        {
            [headView setImage:[UIImage imageNamed:@"男生头像.png"]];
        }
        else
        {
            [headView setImage:[UIImage imageNamed:@"女生头像.png"]];
        }
        [self addSubview: headView];
        
        int const labelMarginTop = 100;
        int const lableMarginLeft = headViewMarginLeft + headViewSize + 46;
        int const labelWidth = 100;
        int const labelHeight = 24;
        
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(lableMarginLeft*RESIZE_RATIO, labelMarginTop*RESIZE_RATIO, labelWidth*RESIZE_RATIO, labelHeight*RESIZE_RATIO)];
        label.font = [UIFont systemFontOfSize:labelHeight*RESIZE_RATIO];
        label.textColor = [UIColor ColorWithHexString:@"ffffff"];
        label.text = @"未登录";
        [self addSubview: label];
        
        int const btnMarginTop = 86;
        int const btnMarginRight = 72;
        int const btnWidth = 177;
        int const btnHeight = 50;
        self.loginBtn = [[UIButton alloc] initWithFrame:CGRectMake( FRAME_WIDTH-(btnMarginRight+btnWidth)*RESIZE_RATIO, btnMarginTop*RESIZE_RATIO, btnWidth*RESIZE_RATIO, btnHeight*RESIZE_RATIO)];
        [self.loginBtn setBackgroundImage:[UIImage imageNamed:@"未登录按钮"] forState:UIControlStateNormal];
        [self addSubview: self.loginBtn];
        
    }
    return self;
}



@end
