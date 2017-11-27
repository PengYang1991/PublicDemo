//
//  ShareView.h
//  KaiStory
//
//  Created by mac on 15/4/28.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShareDelegate <NSObject>

-(void)SelectShare : (NSInteger)index;

@end
@interface ShareView : UIView

@property(strong,nonatomic)UIView *blackview;

@property(assign,nonatomic)id<ShareDelegate> m_shareDelegate;
@property(strong,nonatomic)UIImageView *backview;


-(id)initWithFrameRect:(CGRect)frame;

@end
