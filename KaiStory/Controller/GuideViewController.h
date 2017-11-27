//
//  GuideViewController.h
//  KaiStory
//
//  Created by mac on 15/3/23.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "BaseViewContr.h"
#import "pageController.h"
#import "BabyCardView.h"

@interface GuideViewController : BaseViewContr<UIScrollViewDelegate>

@property(strong,nonatomic)UIScrollView *m_ScrollView;
@property(strong,nonatomic)pageController *m_pageControl;
@property(strong,nonatomic)BabyCardView *babyNameView;
@end
