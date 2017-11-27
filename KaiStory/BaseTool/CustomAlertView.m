//
//  CustomAlertView.m
//  KaiStory
//
//  Created by mac on 15/2/9.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "CustomAlertView.h"

@implementation CustomAlertView
-(id)initWithFrame:(CGRect)frame
{
    if (self) {
        self = [super initWithFrame:frame];
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"alert_bg.png"]];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width - 150) / 2, (self.frame.size.height - 40) / 2, 150, 40)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.textColor  = [UIColor whiteColor];
        self.titleLabel.font  = [UIFont boldSystemFontOfSize:14];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
    }
    return self;
}

-(void)didMoveToSuperview{
    [self performSelectorOnMainThread:@selector(hideView) withObject:nil waitUntilDone:NO];
}
-(void)viewDidHidden
{
    [self performSelectorOnMainThread:@selector(removeFromSuperview) withObject:nil waitUntilDone:NO];
}
-(void)hideView{
    [UIView beginAnimations:@"alert" context:nil];
    [UIView setAnimationDelay:1.0f];
    [UIView setAnimationDuration:1.5f];
    self.alpha = 0;
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(viewDidHidden)];
    [UIView commitAnimations];
}
@end
