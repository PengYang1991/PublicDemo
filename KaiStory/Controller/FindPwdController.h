//
//  FindPwdController.h
//  KaiStory
//
//  Created by yanzehua on 15/4/18.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewContr.h"

@interface FindPwdController : BaseViewContr<UITextFieldDelegate>
@property (strong,nonatomic) UITextField* phoneTxt;
@property (strong,nonatomic) UITextField* captchaTxt;
@property (strong,nonatomic) UITextField* pwdTxt;

@property (strong,nonatomic) UIButton* captchaBtn;
@property (strong,nonatomic) NSTimer *captchaTimer;
@property (nonatomic) NSInteger captchaCount;

@end
