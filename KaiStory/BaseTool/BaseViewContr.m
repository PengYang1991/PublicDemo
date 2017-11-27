//
//  BaseViewContr.m
//  KaiStory
//
//  Created by mac on 15/2/10.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "BaseViewContr.h"
#import "Tools.h"
#import "UIColor+HexStringToColor.h"

@interface BaseViewContr ()

@end

@implementation BaseViewContr

-(id)init{
    
    self =[super init];
    if (self) {
        self.hasBackBtn = NO;
        self.hasFootBar = NO;
    }
    return self;
    
}

- (id)initWithConfig : (NSString*) inputTitleStr withBackBtn:(BOOL) inputHasBackBtn
{
    self = [self initWithConfig:inputTitleStr withBackBtn:inputHasBackBtn withFootBar:NO];
    return self;
}

- (id)initWithConfig : (NSString*) inputTitleStr withBackBtn:(BOOL) inputHasBackBtn withFootBar:(BOOL)hasFootBar
{
    self =[super init];
    
    if (self) {
        self.titleStr = inputTitleStr;
        self.hasBackBtn = inputHasBackBtn;
        self.hasFootBar = hasFootBar;
    }
    return self;
}

- (void) initBaseLayout
{
    //int titleViewHeight = 40+88;
    int titleViewHeight = 40+88;
    self.titleView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, FRAME_WIDTH, titleViewHeight/2)];
    NSString* titleViewColorStr = @"e4f2ee";
    UIColor *titleViewColor = [UIColor ColorWithHexString:titleViewColorStr];
    self.titleView.backgroundColor = titleViewColor;
    [self.view addSubview:self.titleView];
    
    if(![Tools isBlankString:self.titleStr])
    {
        NSString* titleFontColorStr = @"41B99E";
        UIColor *titleFontColor = [UIColor ColorWithHexString:titleFontColorStr];
        int titleLabelWidth = 500;
        int titleLabelHeight = 40;
        int titleFontMarginTop = 60;
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((FRAME_WIDTH-titleLabelWidth/2)/2, titleFontMarginTop/2, titleLabelWidth/2, titleLabelHeight/2)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleLabelText: self.titleStr];
        self.titleLabel.textColor = titleFontColor;
        [self.view addSubview:self.titleLabel];
    }
    
    if (self.hasBackBtn) {
        int const backMarginTop = 60;
        int const backMarginLeft = 20;
        int const backWidth = 40;
        int const backHeight = 40;
        //[self.backBtn setBackgroundColor:[UIColor blackColor]];
        self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.backBtn.frame = CGRectMake(backMarginLeft/2, backMarginTop/2, backWidth/2, backHeight/2);
        [self.backBtn setImage:[UIImage imageNamed:@"返回上一页.png"] forState:(UIControlStateNormal)];
        [self.backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.backBtn.imageView setContentMode:UIViewContentModeCenter];
        [self.view addSubview:self.backBtn];
        
        //TODO trick的方式扩大返回上一页的点击区域
        self.backExtBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.backExtBtn.frame = CGRectMake(0, backMarginTop/2, backWidth*2, backHeight);
        //self.backExtBtn.backgroundColor = [UIColor blackColor];
        [self.backExtBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.backExtBtn];
        
    }
    
    if(self.hasFootBar)
    {
        int height = 102;
        self.footBar = [[PlayerFootBar alloc]initWithFrame:CGRectMake(0, FRAME_HEIGHT-height*RESIZE_RATIO, FRAME_WIDTH, height*RESIZE_RATIO)];
        [self.view addSubview:self.footBar];
    }
    
    self.baseContentView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, FRAME_WIDTH, [self getContentHeight])];
    //self.baseContentView.userInteractionEnabled = NO;
    [self.view addSubview:self.baseContentView];
    
}

-(void)backBtnAction:(id)sender{
    NSLog(@"NEED OVERWRITE");
}

- (void) setTitleLabelText:(NSString*) titleValue
{
    int titleFontSize = 40;
    if([titleValue length] >= 10)
    {
        titleFontSize = 30;
    }
    if([titleValue length] >= 15)
    {
        titleFontSize = 24;
    }
    self.titleLabel.font = [UIFont systemFontOfSize:titleFontSize/2];
    self.titleLabel.text = titleValue;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setFrame:CGRectMake(0, 0, FRAME_WIDTH, FRAME_HEIGHT)];
    [self initBaseLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(self.hasFootBar)
    {
        [self.footBar updateState];
        [self.footBar regObserver];
    }
}

-(void) viewWillDisappear:(BOOL)animated
{
    if(self.hasFootBar)
    {
        [self.footBar unRegObserver];
    }
}

- (NSInteger) getContentHeight
{
    if(self.hasFootBar)
    {
        return FRAME_HEIGHT - 102*RESIZE_RATIO - 64;
    }else
    {
        return FRAME_HEIGHT  - 64;
    }
}
@end
