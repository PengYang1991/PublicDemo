//
//  StoryDetailAbstractView.h
//  KaiStory
//
//  Created by yanzehua on 15/5/2.
//  Copyright (c) 2015年 kaishu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoryDetailAbstractView : UIView

@property(strong,nonatomic) UIImageView* barImgView;
@property(strong,nonatomic) UILabel* barLabel;
@property(strong,nonatomic) UILabel* abstractLabel;

-(void)setAbstract:(NSString*) inputAbstract;

@end
