//
//  ClassListVIew.h
//  KaiStory
//
//  Created by mac on 15/4/14.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassModel.h"
#import "ClassPropertyView.h"

//@protocol isDisplayViewDelegate <NSObject>
//-(void)ISDisplay:(NSInteger)index;
//@end

@interface ClassListVIew : UIView
{
    UIView *propertyView;
    
}

//-(void)DisplayListView;
-(id)initWithFrameRect:(CGRect)frame dataSource:(ClassModel *)data :(NSInteger)Index;
@property(strong,nonatomic)UILabel *lefBtn;

@property(nonatomic,assign)NSInteger isDisplay;

@property(strong,nonatomic)UIButton *rightBtn;
@property(nonatomic,assign)CGFloat location;


@property(strong,nonatomic)UIButton *selectBtn;

@property(strong,nonatomic)ClassPropertyView *propertyview;

@property(strong,nonatomic)NSMutableArray *RightBtnArray;


@property(strong,nonatomic)UIImageView *rightBtnView;


@end
