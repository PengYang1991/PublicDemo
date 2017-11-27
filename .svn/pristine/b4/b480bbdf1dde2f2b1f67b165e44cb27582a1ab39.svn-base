//
//  tabbarView.m
//  KaiStory
//
//  Created by mac on 15/2/7.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "tabbarView.h"
#import "Tools.h"

@implementation tabbarView

-(id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self layoutView];
    }
    return self;
    
}

-(void)layoutView
{
    self.tabbarView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"footer.png"]];
    self.tabbarView.frame =CGRectMake(0,0, self.bounds.size.width, self.bounds.size.height);
    [self.tabbarView setUserInteractionEnabled:YES];
    
    [self addSubview:self.tabbarView];
    [self bringSubviewToFront:self.tabbarView];
    [self layoutBt];
    
    NSLog(@"");
}
-(void)layoutBt
{
    int const iconMarginTop = 16 ;
    self.m_MainBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.m_MainBt setFrame:CGRectMake(0, iconMarginTop* RESIZE_RATIO, self.frame.size.width/5, self.frame.size.height)];
    [self.m_MainBt setImage:[UIImage imageNamed:@"discover.png"] forState:UIControlStateNormal];
    [self.m_MainBt setImage:[UIImage imageNamed:@"discoverSelected.png"] forState:UIControlStateSelected];
    [self.m_MainBt setImage:[UIImage imageNamed:@"discoverSelected.png"] forState:UIControlStateHighlighted];
    [self.m_MainBt addTarget:self action:@selector(SelectBt:) forControlEvents:UIControlEventTouchUpInside];
    [self.m_MainBt setTag:1];
    [self addSubview:self.m_MainBt];
    
    self.m_CustomBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.m_CustomBt setFrame:CGRectMake(self.frame.size.width/5, iconMarginTop* RESIZE_RATIO , self.frame.size.width/5, self.frame.size.height)];
    [self.m_CustomBt setImage:[UIImage imageNamed:@"sleep.png"] forState:UIControlStateNormal];
    [self.m_CustomBt setImage:[UIImage imageNamed:@"sleepSelected.png"] forState:UIControlStateSelected];
     [self.m_CustomBt setImage:[UIImage imageNamed:@"sleepSelected.png"] forState:UIControlStateHighlighted];
    [self.m_CustomBt addTarget:self action:@selector(SelectBt:) forControlEvents:UIControlEventTouchUpInside];
    [self.m_CustomBt setTag:2];
    [self addSubview:self.m_CustomBt];
    
    self.m_PlayerBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.m_PlayerBt setFrame:CGRectMake((self.frame.size.width*2)/5, iconMarginTop/4* RESIZE_RATIO , 130*RESIZE_RATIO, 119*RESIZE_RATIO)];
    [self.m_PlayerBt setBackgroundImage:[UIImage imageNamed:@"player.png"] forState:UIControlStateNormal];
    [self.m_PlayerBt addTarget:self action:@selector(SelectBt:) forControlEvents:UIControlEventTouchUpInside];
    [self.m_PlayerBt setTag:3];
    [self addSubview:self.m_PlayerBt];
    
    self.m_ShopBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.m_ShopBt setFrame:CGRectMake((self.frame.size.width*3)/5, iconMarginTop* RESIZE_RATIO, self.frame.size.width/5, self.frame.size.height)];
    [self.m_ShopBt setImage:[UIImage imageNamed:@"daily.png"] forState:UIControlStateNormal];
    [self.m_ShopBt setImage:[UIImage imageNamed:@"dailySelected.png"] forState:UIControlStateSelected];
    [self.m_ShopBt setImage:[UIImage imageNamed:@"dailySelected.png"] forState:UIControlStateHighlighted];
    [self.m_ShopBt addTarget:self action:@selector(SelectBt:) forControlEvents:UIControlEventTouchUpInside];
    [self.m_ShopBt setTag:4];
    [self addSubview:self.m_ShopBt];
    
    self.MyBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.MyBt setFrame:CGRectMake((self.frame.size.width*4)/5, iconMarginTop* RESIZE_RATIO, self.frame.size.width/5, self.frame.size.height)];
    [self.MyBt setImage:[UIImage imageNamed:@"baby.png"] forState:UIControlStateNormal];
    [self.MyBt setImage:[UIImage imageNamed:@"babySelected.png"] forState:UIControlStateSelected];
     [self.MyBt setImage:[UIImage imageNamed:@"babySelected.png"] forState:UIControlStateHighlighted];
    [self.MyBt addTarget:self action:@selector(SelectBt:) forControlEvents:UIControlEventTouchUpInside];
    [self.MyBt setTag:5];
    [self addSubview:self.MyBt];
    
}

-(void) deSelectAll
{
    self.m_MainBt.selected = NO;
    self.m_CustomBt.selected = NO;
    self.m_PlayerBt.selected = NO;
    self.m_ShopBt.selected = NO;
    self.MyBt.selected = NO;
}

-(void)SelectBt:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 1:
        {
            //[_tabbarView setImage:[UIImage imageNamed:@"tabbar_0"]];
            [self.delegate touchBtnAtIndex:1];
            [self deSelectAll];
             self.m_MainBt.selected = YES;
            break;
        }
        case 2:
        {
            //[_tabbarView setImage:[UIImage imageNamed:@"tabbar_1"]];
            [self.delegate touchBtnAtIndex:2];
             [self deSelectAll];
            self.m_CustomBt.selected = YES;
            break;
        }
        case 3:
            //[_tabbarView setImage:[UIImage imageNamed:@"tabbar_3"]];
            [self.delegate touchBtnAtIndex:3];
          
            break;
        case 4:
            //[_tabbarView setImage:[UIImage imageNamed:@"tabbar_4"]];
            [self.delegate touchBtnAtIndex:4];
             [self deSelectAll];
            self.m_ShopBt.selected = YES;
            break;
        default:
            [self.delegate touchBtnAtIndex:5];
             [self deSelectAll];
            self.MyBt.selected = YES;
            break;
    }
}

@end
