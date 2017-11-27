//
//  ContextMenuView.h
//  KaiStory
//
//  Created by yanzehua on 15/5/4.
//  Copyright (c) 2015年 kaishu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContextMenuView : UIView

//分别对应灰色区域、按钮区域 和 取消按钮的背景图
@property(strong,nonatomic) UIView* restRegionView;
@property(strong,nonatomic) UIImageView* btnRegionView;

@property(strong,nonatomic) UIImageView* btnRegionImgView;
@property(strong,nonatomic) UIImageView* cancelRegionImgView;

@property(strong,nonatomic) NSMutableArray* btnArray;
@property(strong,nonatomic) UIButton* cancelBtn;
@property(nonatomic) NSInteger index;

-(id) initWithFrameRect:(CGRect)frame withLabelArray:(NSArray*) labelArray;
-(void) setItemIndex:(NSInteger)inputIndex;
@end
