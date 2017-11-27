//
//  datePicker.h
//  KaiStory
//
//  Created by mac on 15/2/11.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DatePickerViewDelegate <NSObject>

- (void)birthdayFinishChoose:(NSString *)date;

@end

@interface datePicker : UIView
@property (nonatomic, strong)UIDatePicker *datePicker;

@property (nonatomic, assign) id<DatePickerViewDelegate>delegate;


@end
