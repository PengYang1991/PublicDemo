//
//  BaseViewContr.h
//  KaiStory
//
//  Created by mac on 15/2/10.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerFootBar.h"

@interface BaseViewContr : UIViewController

@property (strong, nonatomic) NSString* titleStr;
@property (strong, nonatomic) UILabel* titleLabel;
@property (strong, nonatomic) UIView* titleView;
@property (nonatomic) BOOL hasBackBtn;
@property (strong, nonatomic) UIButton* backBtn;
@property (strong, nonatomic) UIButton* backExtBtn;
@property (nonatomic) BOOL hasFootBar;
@property (strong, nonatomic) PlayerFootBar* footBar;
@property (strong, nonatomic) UIView* baseContentView;

- (id)initWithConfig : (NSString*) inputTitleStr withBackBtn:(BOOL) inputHasBackBtn;
- (id)initWithConfig : (NSString*) inputTitleStr withBackBtn:(BOOL) inputHasBackBtn withFootBar:(BOOL) hasFootBar;
- (void) initBaseLayout;
- (NSInteger) getContentHeight;

- (void) setTitleLabelText:(NSString*) titleValue;
@end
