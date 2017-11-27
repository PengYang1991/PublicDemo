//
//  NoticeView.m
//  KaiStory
//
//  Created by mac on 15/4/10.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "NoticeView.h"

@implementation NoticeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//+ (NoticeView *)sharedSingleton{
//    static dispatch_once_t pred;
//    
//    static NoticeView *sharedSingleton;
//    
//    dispatch_once(&pred,^{
//        sharedSingleton=[[self alloc] init];
//       
//    } );
//
//    return sharedSingleton;
//}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}


-(void)SetStringAlert:(NSString *)str{
    [self createView];
    self.titleLabel.text = str;
    [self.window addSubview:self];
}


-(void)createView{
//    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"alert_bg.png"]];
    self.backgroundColor = [UIColor blackColor];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width - 150) / 2, (self.frame.size.height - 40) / 2, 150, 40)];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.textColor  = [UIColor redColor];
    self.titleLabel.font  = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
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
