//
//  MainViewController.h
//  KaiStory
//
//  Created by mac on 15/2/7.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "BaseViewContr.h"
@class FirstController;
@class CustomController;
@class BabyPlayerController;
@class ShopController;
@class BabyController;
@class BabyPlayerController;

@protocol tabbarDelegate <NSObject>
-(void)touchBtnAtIndex:(NSInteger)index;
@end



@protocol GuideDelegate <NSObject>
-(void)EnterApp;
@end


@class tabbarView;
@interface MainViewController : UITabBarController<tabbarDelegate>
@property (strong,nonatomic)NSArray *m_ViewControllers;
@property (strong, nonatomic)tabbarView *m_tabbarView;
@property (strong,nonatomic)FirstController *firstController;
@property (strong,nonatomic)CustomController *CustomContr;
@property (strong,nonatomic)BabyPlayerController *PlayerContr;
@property (strong,nonatomic)ShopController *ShopContr;
@property (strong,nonatomic)BabyController *MyContr;
@property (nonatomic,assign)id<GuideDelegate>m_GuideDelegate;

@end






