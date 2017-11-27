//
//  StoryGridView.h
//  KaiStory
//
//  Created by yanzehua on 15/4/16.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoryGridView : UIView

@property (strong, nonatomic)  UIImageView *leftImgView;
@property (strong, nonatomic)  UILabel *leftLabel;
@property (strong, nonatomic)  UIImageView *rightImgView;
@property (strong, nonatomic)  UILabel *rightLabel;

@property (strong, nonatomic)  NSMutableArray *coverViewArray;
@property (strong, nonatomic)  NSMutableArray *titleViewArray;
@property (strong, nonatomic)  NSMutableArray *playCountViewArray;
@property (strong, nonatomic)  NSMutableArray *playCountLabelArray;

@property(assign, nonatomic) NSInteger currentIndex;

@property(strong,nonatomic)NSMutableArray *m_sortArray;
@property(strong,nonatomic)UIButton *rightBtn;

@property(strong,nonatomic)NSMutableArray* storyGridCellArray;

@property(strong,nonatomic)NSString* bgColorStr;

-(id)initWithFrameRect:(CGRect)frame color:(NSString*)color story:(NSMutableArray *)arr sort:(NSMutableArray*)sortArray;
-(void)updateState;
-(void)regObserver;
-(void)unRegObserver;
@end
