//
//  ClassPropertyView.m
//  KaiStory
//
//  Created by mac on 15/4/15.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "ClassPropertyView.h"
#import "Tools.h"
#import "UIColor+HexStringToColor.h"

@implementation ClassPropertyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrameRect:(CGRect)frame dataSource:(ClassModel *)data :(NSInteger)i
{
     if (self = [super initWithFrame:frame])
     {
         
         
         
         NSString *color1=@"#d1eae2";
         NSString *color2=@"#eef6f4";
         UIColor *Color1 = [UIColor ColorWithHexString:color1];
         UIColor *Color2 = [UIColor ColorWithHexString:color2];
         
         
         if (i%2) {
             [self setBackgroundColor:Color1];
         }else{
             [self setBackgroundColor:Color2];
         }
         
         
         
         self.model = data;
         int number = data.propertyList.count;
         int row = number/3;
         int tt = number%3;
         if (row == 0 ) {
             row = 1;
         }else if (tt > 0)
         {
             row = row +1;
         }
        
         
         CGFloat width = 179;
         CGFloat height = 82;
         
         CGFloat gapWidth = 36;
         CGFloat gapHeight = 20;
         
         
         for (NSInteger i=0; i< 3; i++)
         {
             for (NSInteger j=0; j< row; j++)
             {
                 int jj = (j)*3+i+1;
                 int leftwidth =(gapWidth+width)*i*RESIZE_RATIO+(20*RESIZE_RATIO);
                 int topheight = height*j*RESIZE_RATIO+(j+1)*gapHeight*RESIZE_RATIO;
                 UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(leftwidth,topheight, width*RESIZE_RATIO, height*RESIZE_RATIO)];
                 [view setImage:[UIImage imageNamed:@"分类背景块.png"]];
                 
                 UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(leftwidth,topheight, width*RESIZE_RATIO, height*RESIZE_RATIO)];
                 label.textAlignment = NSTextAlignmentCenter;
                 NSString *colorstr =@"ffffff";
                 label.font = [UIFont systemFontOfSize:24*RESIZE_RATIO];
                 UIColor *colorLabel = [UIColor ColorWithHexString:colorstr];
                 [label setTextColor:colorLabel];
               
                 UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(leftwidth,topheight, width*RESIZE_RATIO, height*RESIZE_RATIO)];
                 button.tag = jj;
                 [button addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
                 
                 
                 
                 if (jj < number+1) {
                    [self addSubview:view];
                     [self addSubview:label];
                     [self addSubview:button];
                     PropertyModel *proper =[data.propertyList objectAtIndex:jj-1];
                     label.text = proper.property_vaule_name;
                 }
                 
                 
             }
         }
     }
    
    return self;
}

-(void)BtnClick:(id)sender
{
    NSLog(@"点击的按钮为");
    UIButton *btn =(UIButton *)sender;
     PropertyModel *proper =[self.model.propertyList objectAtIndex:btn.tag-1];
    
    
    [self.EnterClassDetailDelegate EnterStoryDetail:proper];
    
    
   
}
@end
