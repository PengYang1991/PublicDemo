//
//  BabyCardView.m
//  KaiStory
//
//  Created by yanzehua on 15/5/11.
//  Copyright (c) 2015年 kaishu. All rights reserved.
//

#import "BabyCardView.h"
#import "Tools.h"
#import "UIColor+HexStringToColor.h"
#import "UIImageView+WebCache.h"

@implementation BabyCardView

-(void)initBtn
{
    int marginLeft = 84;
    int marginTop = 140;
    int btnWidth = 276;
    int btnHeight = 188;
    self.maleBtn = [[UIButton alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO, self.baseHeight+marginTop*RESIZE_RATIO, btnWidth*RESIZE_RATIO, btnHeight*RESIZE_RATIO)];
    //[self.maleBtn setBackgroundColor:[UIColor blackColor]];
    [self.maleBtn addTarget:self action:@selector(maleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    marginLeft = 84+276+118;
    marginTop = 114+126;
    btnWidth = 154;
    btnHeight = 242;
    self.femaleBtn = [[UIButton alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO, self.baseHeight+marginTop*RESIZE_RATIO, btnWidth*RESIZE_RATIO, btnHeight*RESIZE_RATIO)];
    //[self.femaleBtn setBackgroundColor:[UIColor blackColor]];
    [self.femaleBtn addTarget:self action:@selector(femaleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    marginLeft = 122;
    marginTop = 140+188+22;
    btnWidth = 120;
    btnHeight = 296;
    self.delBtn = [[UIButton alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO, self.baseHeight+marginTop*RESIZE_RATIO, btnWidth*RESIZE_RATIO, btnHeight*RESIZE_RATIO)];
    //[self.delBtn setBackgroundColor:[UIColor blackColor]];
    [self.delBtn addTarget:self action:@selector(delBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    marginLeft = 640-162-108;
    marginTop = 140+188+22;
    btnWidth = 120;
    btnHeight = 296;
    self.addBtn = [[UIButton alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO, self.baseHeight+marginTop*RESIZE_RATIO, btnWidth*RESIZE_RATIO, btnHeight*RESIZE_RATIO)];
    //[self.addBtn setBackgroundColor:[UIColor blackColor]];
    [self.addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.maleBtn];
    [self addSubview:self.femaleBtn];
    [self addSubview:self.addBtn];
    [self addSubview:self.delBtn];
}

-(void)maleBtnClick:(id)sender
{
    [self.sexImgView setImage:[UIImage imageNamed:@"名片男"]];
    self.sex = 1;
}

-(void)femaleBtnClick:(id)sender
{
    [self.sexImgView setImage:[UIImage imageNamed:@"名片女"]];
    self.sex = 0;
}

-(void)delBtnClick:(id)sender
{
    if(self.age > 1)
    {
        self.age -= 1;
        self.ageLabel.text = [NSString stringWithFormat:@"%ld",self.age];
    }
}

-(void)addBtnClick:(id)sender
{
    if(self.age<15)
    {
        self.age += 1;
        self.ageLabel.text = [NSString stringWithFormat:@"%ld",self.age];
    }
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.baseHeight = (FRAME_HEIGHT - 900*RESIZE_RATIO)/2;
    if(self.baseHeight < 0)
    {
        self.baseHeight = 0;
    }
    
    int marginTop = 60;
    int fontSize = 40;
    UILabel* firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, marginTop*RESIZE_RATIO, FRAME_WIDTH, fontSize*RESIZE_RATIO)];
    firstLabel.text = @"请选择宝宝性别与年龄";
    firstLabel.font = [UIFont systemFontOfSize: fontSize*RESIZE_RATIO];
    firstLabel.textAlignment = NSTextAlignmentCenter;
    firstLabel.textColor = [UIColor ColorWithHexString:@"41b19a"];
    [self addSubview:firstLabel];
    
    marginTop = 120;
    fontSize = 32;
    UILabel* secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, marginTop*RESIZE_RATIO, FRAME_WIDTH, fontSize*RESIZE_RATIO)];
    secondLabel.text = @"让我们为您挑选合适的故事";
    secondLabel.font = [UIFont systemFontOfSize: fontSize*RESIZE_RATIO];
    secondLabel.textAlignment = NSTextAlignmentCenter;
    secondLabel.textColor = [UIColor ColorWithHexString:@"41b19a"];
    [self addSubview:secondLabel];
    
    int marginLeft = 140;
    marginTop = 700;
    int btnWidth = 362;
    int btnHeight = 80;
    self.enterBtn = [[UIButton alloc]initWithFrame:CGRectMake((FRAME_WIDTH-btnWidth*RESIZE_RATIO)/2, self.baseHeight+ marginTop*RESIZE_RATIO, btnWidth*RESIZE_RATIO, btnHeight*RESIZE_RATIO)];
    [self.enterBtn setImage:[UIImage imageNamed:@"名片按钮"] forState:UIControlStateNormal];
    [self addSubview:self.enterBtn];
    
    UILabel* btnLabel = [[UILabel alloc]initWithFrame:CGRectMake((FRAME_WIDTH-btnWidth*RESIZE_RATIO)/2, self.baseHeight+marginTop*RESIZE_RATIO, btnWidth*RESIZE_RATIO, btnHeight*RESIZE_RATIO)];
    btnLabel.text = @"开始听故事";
    btnLabel.font = [UIFont systemFontOfSize: 30*RESIZE_RATIO];
    btnLabel.textAlignment = NSTextAlignmentCenter;
    btnLabel.textColor = [UIColor whiteColor];
    [self addSubview:btnLabel];
   
    marginTop = 114+26+288+20;
    marginLeft = 122+120;
    int labelWidth = 128;
    int labelHeight = 60;
    self.age = 4;
    self.ageLabel = [[UILabel alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO,self.baseHeight+marginTop*RESIZE_RATIO,labelWidth*RESIZE_RATIO,labelHeight*RESIZE_RATIO)];
    self.ageLabel.text = [NSString stringWithFormat:@"%ld",self.age];
    self.ageLabel.font = [UIFont systemFontOfSize: 60*RESIZE_RATIO];
    self.ageLabel.textAlignment = NSTextAlignmentCenter;
    self.ageLabel.textColor = [UIColor ColorWithHexString:@"41b19a"];
 
    
    marginTop =114+26+288+80;
    self.ageTag = [[UILabel alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO,self.baseHeight+marginTop*RESIZE_RATIO,labelWidth*RESIZE_RATIO,labelHeight*RESIZE_RATIO)];
    self.ageTag.text = @"周岁";
    self.ageTag.font = [UIFont systemFontOfSize: 30*RESIZE_RATIO];
    self.ageTag.textAlignment = NSTextAlignmentCenter;
    self.ageTag.textColor = [UIColor  ColorWithHexString:@"41b19a"];
   
    
    marginTop = 114;
    int imgWidth = 640;
    int imgHeight = 600;
    self.sexImgView = [[UIImageView alloc]initWithFrame:CGRectMake((FRAME_WIDTH-imgWidth*RESIZE_RATIO)/2, self.baseHeight+marginTop*RESIZE_RATIO, imgWidth*RESIZE_RATIO, imgHeight*RESIZE_RATIO)];
    [self.sexImgView setImage:[UIImage imageNamed:@"名片男"]];
    [self addSubview:self.sexImgView];
    self.sex = 1;
    
    [self addSubview:self.self.ageLabel];
    [self addSubview:self.self.ageTag];
    [self initBtn];
    return self;
}
@end
