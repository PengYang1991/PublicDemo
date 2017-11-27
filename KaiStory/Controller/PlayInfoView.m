//
//  PlayInfoView.m
//  KaiStory
//
//  Created by yanzehua on 15/4/19.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "PlayInfoView.h"
#import "Tools.h"
#import "UIColor+HexStringToColor.h"

@implementation PlayInfoView

-(void) setPlayInfo:(int)storyNum dayNum:(int)dayNum hourNum:(int)hourNum
{
    self.storyLabel.text = [NSString stringWithFormat:@"%d",storyNum];
    self.dayLabel.text = [NSString stringWithFormat:@"%d",dayNum];
    self.hourLabel.text = [NSString stringWithFormat:@"%d",hourNum];
}

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor ColorWithHexString:@"e2f2ee"];
        int marginTop = 26;
        int marginLeft = 62;
        int marginGap = 78;
        int imgSize = 120;
        
        int labelMarginTop = 55;
        int labelMarginLeft = 2;
        int labelWidth = 120;
        int labelHeight = 44;
        int labelFontSize = 44;
        NSString* fontColorStr = @"6d686a";
        
        UIImageView*  storyView = [[UIImageView alloc] initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO,marginTop*RESIZE_RATIO,imgSize*RESIZE_RATIO, imgSize*RESIZE_RATIO)];
        [storyView setImage:[UIImage imageNamed:@"收听故事.png"]];
        self.storyLabel = [[UILabel alloc] initWithFrame:CGRectMake((marginLeft+labelMarginLeft)*RESIZE_RATIO, labelMarginTop*RESIZE_RATIO,labelWidth*RESIZE_RATIO, labelHeight*RESIZE_RATIO)];
        self.storyLabel.textAlignment = NSTextAlignmentCenter;
        self.storyLabel.font = [UIFont systemFontOfSize:labelFontSize*RESIZE_RATIO];
        self.storyLabel.textColor = [UIColor ColorWithHexString:fontColorStr];
        
        UIImageView*  dayView = [[UIImageView alloc] initWithFrame:CGRectMake((marginLeft+marginGap+imgSize)*RESIZE_RATIO,marginTop*RESIZE_RATIO,imgSize*RESIZE_RATIO, imgSize*RESIZE_RATIO)];
        [dayView setImage:[UIImage imageNamed:@"连续收听.png"]];
        self.dayLabel = [[UILabel alloc] initWithFrame:CGRectMake((marginLeft+marginGap+imgSize+labelMarginLeft)*RESIZE_RATIO, labelMarginTop*RESIZE_RATIO,labelWidth*RESIZE_RATIO, labelHeight*RESIZE_RATIO)];
        self.dayLabel.textAlignment = NSTextAlignmentCenter;
        self.dayLabel.font = [UIFont systemFontOfSize:labelFontSize*RESIZE_RATIO];
        self.dayLabel.textColor = [UIColor ColorWithHexString:fontColorStr];
        
        
        UIImageView*  hourView = [[UIImageView alloc] initWithFrame:CGRectMake((marginLeft+marginGap*2+imgSize*2)*RESIZE_RATIO,marginTop*RESIZE_RATIO,imgSize*RESIZE_RATIO, imgSize*RESIZE_RATIO)];
        [hourView setImage:[UIImage imageNamed:@"收听时长.png"]];
        self.hourLabel = [[UILabel alloc] initWithFrame:CGRectMake((marginLeft+marginGap*2+imgSize*2+labelMarginLeft)*RESIZE_RATIO, labelMarginTop*RESIZE_RATIO,labelWidth*RESIZE_RATIO, labelHeight*RESIZE_RATIO)];
        self.hourLabel.textAlignment = NSTextAlignmentCenter;
        self.hourLabel.font = [UIFont systemFontOfSize:labelFontSize*RESIZE_RATIO];
        self.hourLabel.textColor = [UIColor ColorWithHexString:fontColorStr];
        

        [self addSubview:storyView];
        [self addSubview:self.storyLabel];
        [self addSubview:dayView];
        [self addSubview:self.dayLabel];
        [self addSubview:hourView];
        [self addSubview:self.hourLabel];
    }
    
    return self;
}
@end
