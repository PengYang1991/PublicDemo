//
//  ImageScrollerView.h
//  Bistone
//
//  Created by Apple on 15/1/13.
//  Copyright (c) 2015年 yangpeng  Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageScrollerView.h"
@protocol ImageScrollerViewDelegate <NSObject>
@optional
-(void)EScrollerViewDidClicked:(NSUInteger)index;
-(void)EScrollerViewDidClicked:(NSUInteger)index andPages:(NSInteger)pages;
-(void)BeginAction;
@end
@interface ImageScrollerView : UIView<UIScrollViewDelegate>
{
    CGRect viewSize;
    UIScrollView *scrollView;
    NSArray *imageArray;
    NSArray *titleArray;
    UIPageControl *pageControl;
    id<ImageScrollerViewDelegate> delegate;
    int currentPageIndex;
    UILabel *noteTitle;
}
@property (nonatomic,assign) BOOL isTimeUp;
@property (nonatomic) NSTimer * moveTime;
@property(nonatomic,assign)BOOL firstView;
@property(nonatomic,retain)id<ImageScrollerViewDelegate> delegate;
-(id)initWithFrameRect:(CGRect)rect ImageArray:(NSArray *)imgArr TitleArray:(NSArray *)titArr;

-(void)stopScrollView;
-(void)startScrollView;
//-(id)initWithFrameRect:(CGRect)rect ImageArray:(NSArray *)imgArr;
 
@end
