//
//  PlayerBtnView.h
//  KaiStory
//
//  Created by yanzehua on 15/4/27.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerBtnView : UIView

@property(strong,nonatomic)UILabel* currentTimeLabel;
@property(strong,nonatomic)UILabel* totalTimeLabel;
@property(nonatomic,strong)UISlider *timeSlider;
@property BOOL isChaningSlider;
@property(strong,nonatomic)UIButton *preButton;
@property(strong,nonatomic)UIButton *playButton;
@property(strong,nonatomic)UIButton *nextButton;
@property float totalTime;

-(void) regObserver;
-(void) unRegObserver;
-(void) updatePlayerBtnViewState;
@end
