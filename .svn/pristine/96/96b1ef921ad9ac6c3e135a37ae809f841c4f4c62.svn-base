//
//  datePicker.m
//  KaiStory
//
//  Created by mac on 15/2/11.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "datePicker.h"

@implementation datePicker
{
    NSString *finishDate;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.98];
        float oneYearTime = 60*60*24*365;
        NSDate *select = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        NSString *dateAndTime =  [dateFormatter stringFromDate:select];
        finishDate = dateAndTime;
        
        self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, 10, 80)];
        //        datePicker.backgroundColor = [UIColor redColor];
        self.datePicker.datePickerMode=UIDatePickerModeDate;
        NSDate *currentDate = [NSDate date];
        
        NSDate *oneYearFromToday = [currentDate dateByAddingTimeInterval:oneYearTime];
        NSDate *twoYearFromToday = [currentDate dateByAddingTimeInterval:10*oneYearTime];
        self.datePicker.minimumDate = twoYearFromToday;
        self.datePicker.maximumDate = oneYearFromToday;
        self.datePicker.date = currentDate;
        [self.datePicker addTarget:self action:@selector(datePickerDateChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.datePicker];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(200, 5, 50, 30)];
        [button setBackgroundImage:[UIImage imageNamed:@"StoryClass_DownloadButton"] forState:UIControlStateNormal];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(birthdayFinishChoose:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    return self;
}

-(void)datePickerDateChanged:(UIDatePicker *)paramDatePicker{
    NSLog(@"Selected date = %@",[paramDatePicker date]);
    
}

- (void)birthdayFinishChoose:(UIButton *)button{
    NSDate *now = [NSDate date];
    NSDate *select = [self.datePicker date];
    if ([select isEqualToDate:[select earlierDate:now]]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSString *dateAndTime =  [dateFormatter stringFromDate:select];
        finishDate = dateAndTime;
        if ([self.delegate respondsToSelector:@selector(birthdayFinishChoose:)]) {
            [self.delegate birthdayFinishChoose:finishDate];
        }
    }else{
//        [SVProgressHUD showErrorWithStatus:@"请选择正确的时间"];
    }
    
    
}


@end
