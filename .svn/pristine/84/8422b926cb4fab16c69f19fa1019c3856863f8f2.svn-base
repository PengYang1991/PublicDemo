//
//  ContextMenuView.m
//  KaiStory
//
//  Created by yanzehua on 15/5/4.
//  Copyright (c) 2015年 kaishu. All rights reserved.
//

#import "ContextMenuView.h"
#import "Tools.h"
#import "UIImageView+WebCache.h"
#import "UIColor+HexStringToColor.h"


@implementation ContextMenuView

-(id) initWithFrameRect:(CGRect)frame withLabelArray:(NSArray*) labelArray
{
    self = [super initWithFrame:frame];
    int btnRegionHeight = 572;
    int restRegionHeight = FRAME_HEIGHT - btnRegionHeight*RESIZE_RATIO;
    
    self.restRegionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, FRAME_WIDTH, restRegionHeight)];
    [self.restRegionView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissMenu:)];
    [self.restRegionView addGestureRecognizer:tapGesture];
    [self addSubview:self.restRegionView];
    
    self.btnRegionView =  [[UIImageView alloc]initWithFrame:CGRectMake(0, restRegionHeight, FRAME_WIDTH, btnRegionHeight*RESIZE_RATIO)];
    [self.btnRegionView setImage:[UIImage imageNamed:@"BG"]];
    [self addSubview:self.btnRegionView];
    
    int imgWidth = 540;
    int imgHeight= 180;
    int marginTop = 131;
    self.btnRegionImgView = [[UIImageView alloc]initWithFrame:CGRectMake((FRAME_WIDTH-imgWidth*RESIZE_RATIO)/2, restRegionHeight + marginTop*RESIZE_RATIO, imgWidth*RESIZE_RATIO, imgHeight*RESIZE_RATIO)];
    [self.btnRegionImgView setImage:[UIImage imageNamed:@"菜单2栏"]];
    [self addSubview:self.btnRegionImgView];
    
    
    
    imgHeight = 90;
    marginTop = 131+180+24;
    self.cancelRegionImgView = [[UIImageView alloc]initWithFrame:CGRectMake((FRAME_WIDTH-imgWidth*RESIZE_RATIO)/2, restRegionHeight + marginTop*RESIZE_RATIO, imgWidth*RESIZE_RATIO, imgHeight*RESIZE_RATIO)];
    [self.cancelRegionImgView setImage:[UIImage imageNamed:@"菜单1栏"]];
    [self addSubview:self.cancelRegionImgView];
    
    self.cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake((FRAME_WIDTH-imgWidth*RESIZE_RATIO)/2, restRegionHeight+marginTop*RESIZE_RATIO, imgWidth*RESIZE_RATIO, imgHeight*RESIZE_RATIO)];
    [self.cancelBtn setBackgroundImage:[UIImage imageNamed:@"菜单栏1栏"] forState:UIControlStateNormal];
    self.cancelBtn.titleLabel.font  = [UIFont systemFontOfSize:26*RESIZE_RATIO];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:[UIColor ColorWithHexString:@"4ab19a"] forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(dismissMenu:) forControlEvents:UIControlEventTouchUpInside];
    self.cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self addSubview:self.cancelBtn];
    
    
    self.btnArray = [[NSMutableArray alloc]initWithCapacity:4];
    //部署Button
    for(NSUInteger i =0 ; i< 2; i++)
    {
        int btnWidth = 540;
        int btnHeight = 90;
        int btnMarginTop = restRegionHeight + 131*RESIZE_RATIO + (btnHeight)*i*RESIZE_RATIO;
        int btnMarginLeft = (FRAME_WIDTH-imgWidth*RESIZE_RATIO)/2;
        //NSString* labelText = [labelArray objectAtIndex:i];
        UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(btnMarginLeft, btnMarginTop, btnWidth*RESIZE_RATIO, btnHeight*RESIZE_RATIO)];
        btn.titleLabel.font  = [UIFont systemFontOfSize:26*RESIZE_RATIO];
        NSString* btnLabel = [labelArray objectAtIndex:i];
        [btn setTitle:btnLabel forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor ColorWithHexString:@"4ab19a"] forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        /*
        if(i%2 == 0)
        [btn setBackgroundColor:[UIColor blackColor]];
        else
            [btn setBackgroundColor:[UIColor redColor]];*/
        [self addSubview: btn];
        [self.btnArray addObject:btn];
    }
    
    
    return self;
}

-(void) setItemIndex:(NSInteger)inputIndex
{
    self.index = inputIndex;
}


-(void)dismissMenu:(id)sender
{
    [self removeFromSuperview];
}

@end
