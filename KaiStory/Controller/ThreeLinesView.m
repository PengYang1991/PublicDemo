//
//  ThreeLinesView.m
//  KaiStory
//
//  Created by yanzehua on 15/4/19.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "ThreeLinesView.h"
#import "Tools.h"
#import "UIColor+HexStringToColor.h"

@implementation ThreeLinesView
-(id) initWithFrameRect:(CGRect)frame withLabelArray:(NSArray*) labelArray withIconArray:(NSArray*)iconArray withTailIcon:(NSString*) tailIconName
{
    self = [super initWithFrame:frame];
    if(self)
    {
        int const iconMarignLeft =  40;
        int const iconSize = 24;
        
        int const labelMarginLeft =  80;
        int const labelWidth = 150;
        int const labelHeight = 26;
        NSString* labelFontColor = @"656565";
        
        int const infoWidth = 547;
        int const infoHeight = 267;
        int const baseMarginTop = 36;
        int const gapMarginTop = 84;
        
        UIImageView* backImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) ];
        [backImgView setImage:[UIImage imageNamed:@"信息框3排"]];
        [self addSubview:backImgView];
        
        self.btnArray = [NSMutableArray array];
        
        for(int i=0; i<3;i++)
        {
            int marginTop = baseMarginTop + i*gapMarginTop;
        
            UIImageView* babyLoveImgView = [[UIImageView alloc] initWithFrame:CGRectMake(iconMarignLeft*RESIZE_RATIO, marginTop*RESIZE_RATIO, iconSize*RESIZE_RATIO, iconSize*RESIZE_RATIO) ];
            [babyLoveImgView setImage:[UIImage imageNamed:[iconArray objectAtIndex:i]]];
            [self addSubview:babyLoveImgView];
            
            UILabel* babyLoveLabelView = [[UILabel alloc] initWithFrame:CGRectMake(labelMarginLeft*RESIZE_RATIO, marginTop *RESIZE_RATIO, labelWidth*RESIZE_RATIO, labelHeight*RESIZE_RATIO) ];
            babyLoveLabelView.text = [labelArray objectAtIndex:i];
            babyLoveLabelView.font = [UIFont systemFontOfSize:labelHeight*RESIZE_RATIO];
            babyLoveLabelView.textColor = [UIColor ColorWithHexString:labelFontColor];
            [self addSubview:babyLoveLabelView];
            
            int btnHeight = 89;
            UIButton* coverBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, btnHeight*i*RESIZE_RATIO, self.frame.size.width, btnHeight*RESIZE_RATIO)];
            //[coverBtn setBackgroundColor:[UIColor redColor]];
            [self addSubview:coverBtn];
            [self.btnArray addObject:coverBtn];
        }
    }
    
    return self;
}
@end
