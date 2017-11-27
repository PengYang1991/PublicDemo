//
//  pageController.m
//  Pagecontroller
//
//  Created by mac on 15/3/26.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "pageController.h"

@implementation pageController

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    _activeImage = [UIImage imageNamed:@"翻页用绿色点.png"];
    _inactiveImage = [UIImage imageNamed:@"翻页用灰色点.png"];
    return self;
}
-(void)updateDots{
    for (int i=0; i<[self.subviews count]; i++) {
        
        
       
        UIView * dot =[self.subviews objectAtIndex:i];
        
        CGSize size;
        
        size.height = 10;     //自定义圆点的大小
        
        size.width = 10;      //自定义圆点的大小
        
        [dot setFrame:CGRectMake(dot.frame.origin.x, dot.frame.origin.y, size.width, size.width)];
        
        
      
         NSLog(@"subviews======%@",dot);
        if (i==self.currentPage) {
//            [dot setImage:_activeImage];
            [dot setBackgroundColor:[UIColor colorWithPatternImage:_activeImage]];
        }else{
             [dot setBackgroundColor:[UIColor colorWithPatternImage:_inactiveImage]];
        }
    }
}
//- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount{
////    return size1;
//}

-(void)setCurrentPage:(NSInteger)currentPage{
    [super setCurrentPage:currentPage];
    [self updateDots];
}
@end
