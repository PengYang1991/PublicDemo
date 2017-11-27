//
//  LoginView.m
//  KaiStory
//
//  Created by yanzehua on 15/4/20.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "LoginView.h"
#import "Tools.h"
#import "UIColor+HexStringToColor.h"

@implementation LoginView
-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self setBackgroundColor:[UIColor ColorWithHexString:@"e2f2ee"]];
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
        
        int const nameLabelMarginTop = 38;
        int const nameLabelMarginLeft = headViewMarginLeft + headViewSize + 46;
        int const nameLabelWidth = 200;
        int const nameLabelHeight = 30;
        
        NSString *babyName = [userDeFaults objectForKey:@"babyName"];
        UILabel* nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabelMarginLeft*RESIZE_RATIO, nameLabelMarginTop*RESIZE_RATIO, nameLabelWidth*RESIZE_RATIO, nameLabelHeight*RESIZE_RATIO)];
        nameLabel.font = [UIFont systemFontOfSize:nameLabelHeight*RESIZE_RATIO];
        nameLabel.textColor = [UIColor ColorWithHexString:@"41b99a"];
        nameLabel.text = babyName;
        [self addSubview: nameLabel];
        
        int const sexLabelMarginTop = 90;
        int const sexLabelMarginLeft = nameLabelMarginLeft;
        int const sexLabelWidth = 24;
        int const sexLabelHeight = 24;
        UILabel* sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(sexLabelMarginLeft*RESIZE_RATIO, sexLabelMarginTop*RESIZE_RATIO, sexLabelWidth*RESIZE_RATIO, sexLabelHeight*RESIZE_RATIO)];
        sexLabel.font = [UIFont systemFontOfSize:sexLabelHeight*RESIZE_RATIO];
        sexLabel.textColor = [UIColor ColorWithHexString:@"9d9e9e"];
        if(1 == babySex)
        {
            sexLabel.text = @"男";
        }else
        {
            sexLabel.text = @"女";
        }
        [self addSubview: sexLabel];
        
        int const ageLabelMarginTop = 90;
        int const ageLabelMarginLeft = nameLabelMarginLeft+75;
        int const ageLabelWidth = 48;
        int const ageLabelHeight = 24;
        NSString *babyAge = [userDeFaults objectForKey:@"babyAge"];
        UILabel* ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(ageLabelMarginLeft*RESIZE_RATIO, ageLabelMarginTop*RESIZE_RATIO, ageLabelWidth*RESIZE_RATIO, ageLabelHeight*RESIZE_RATIO)];
        ageLabel.font = [UIFont systemFontOfSize:ageLabelHeight*RESIZE_RATIO];
        ageLabel.textColor = [UIColor ColorWithHexString:@"9d9e9e"];
        ageLabel.text = [NSString stringWithFormat:@"%@岁",babyAge ];
        [self addSubview: ageLabel];
        
        int const mobelLabelMarginTop = 140;
        int const mobelLabelMarginLeft = nameLabelMarginLeft;
        int const mobelLabelWidth = 300;
        int const mobelLabelHeight = 24;
        NSString *mobile = [userDeFaults objectForKey:@"mobile"];
        
        UILabel* mobelLabel = [[UILabel alloc] initWithFrame:CGRectMake(mobelLabelMarginLeft*RESIZE_RATIO, mobelLabelMarginTop*RESIZE_RATIO, mobelLabelWidth*RESIZE_RATIO, mobelLabelHeight*RESIZE_RATIO)];
        mobelLabel.font = [UIFont systemFontOfSize:mobelLabelHeight*RESIZE_RATIO];
        mobelLabel.textColor = [UIColor ColorWithHexString:@"9d9e9e"];
        mobelLabel.text = mobile;
        [self addSubview: mobelLabel];
        
    }
    return self;
}

@end
