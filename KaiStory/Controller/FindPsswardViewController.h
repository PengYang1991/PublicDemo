//
//  FindPsswardViewController.h
//  KaiStory
//
//  Created by yangpeng on 15/2/10.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindPsswardViewController : UIViewController<UITextFieldDelegate>{

    NSInteger mCountDown;




}
@property (weak, nonatomic) IBOutlet UIImageView *titleView;


@property (weak, nonatomic) IBOutlet UIView *inputView;



@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;

@property (weak, nonatomic) IBOutlet UITextField *codeMessage;

@property (weak, nonatomic) IBOutlet UIButton *sendCode;

@property (weak, nonatomic) IBOutlet UITextField *resetPassword;


- (IBAction)backButton:(id)sender;

- (IBAction)sendCode:(id)sender;

- (IBAction)cerTainButton:(id)sender;

@end
