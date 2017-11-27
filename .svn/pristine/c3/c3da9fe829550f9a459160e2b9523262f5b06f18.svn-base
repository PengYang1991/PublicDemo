//
//  FeedBackController.m
//  KaiStory
//
//  Created by yanzehua on 15/4/19.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "FeedBackController.h"
#import "Tools.h"
#import "UIColor+HexStringToColor.h"

@implementation FeedBackController

- (void) initLayout
{
    int const marginLeft = 56;
    int const width = 520;
    
    int const labelMarginTop = 44;
    int const labelHeight = 80;
    int const labelFontSize = 26;
    NSString* labelFontColor = @"656f6d";
    UILabel* label = [[UILabel alloc]initWithFrame: CGRectMake(marginLeft*RESIZE_RATIO,labelMarginTop*RESIZE_RATIO, width*RESIZE_RATIO,labelHeight*RESIZE_RATIO)];
    label.textColor = [UIColor ColorWithHexString:labelFontColor];
    label.font = [UIFont systemFontOfSize:labelFontSize*RESIZE_RATIO];
    label.lineBreakMode = UILineBreakModeWordWrap;
    label.numberOfLines = 0;
    label.text = @"您在使用过程中有任何的问题或者建议，请给我们留言。";
    [self.contentView addSubview:label];
    
    int const textViewMarginTop = labelMarginTop + labelHeight + 26;
    self.feedbackView = [[UITextView alloc]initWithFrame:CGRectMake(marginLeft* RESIZE_RATIO, textViewMarginTop* RESIZE_RATIO, width* RESIZE_RATIO, 300* RESIZE_RATIO)];
    NSString* txtFontColor = @"4ab19a";
    self.feedbackView.textColor = [UIColor ColorWithHexString:txtFontColor];
    self.feedbackView.font =[UIFont systemFontOfSize:labelFontSize* RESIZE_RATIO];
    self.feedbackView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
    [self.contentView addSubview:self.feedbackView];

    
    int const btnMarginLeft = 56;
    int const btnMarginTop =  textViewMarginTop + 350;
    int const btnWidth = 520;
    int const btnHeight = 88;
    UIButton* feedbackBtn = [[UIButton alloc]initWithFrame:CGRectMake(btnMarginLeft*RESIZE_RATIO,btnMarginTop*RESIZE_RATIO,btnWidth*RESIZE_RATIO,btnHeight*RESIZE_RATIO)];
    [feedbackBtn setTitle:@"提交" forState:UIControlStateNormal];
    [feedbackBtn setTitleColor:[UIColor ColorWithHexString:@"ffffff"]forState:UIControlStateNormal];
    feedbackBtn.titleLabel.font = [UIFont systemFontOfSize:30*RESIZE_RATIO];
    [feedbackBtn setBackgroundImage:[UIImage imageNamed:@"登陆按钮.png"] forState:UIControlStateNormal];
    [feedbackBtn addTarget:self action:@selector(feedbackBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:feedbackBtn];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, FRAME_WIDTH, FRAME_HEIGHT)];
    UIColor *bgColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"BG.png"]];
    self.contentView.backgroundColor = bgColor;
    self.contentView.contentSize = CGSizeMake(FRAME_WIDTH, FRAME_HEIGHT+100);
    [self initLayout];
    [self.view addSubview:self.contentView];
}

-(void)backBtnAction:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^(){}];
}

-(void)feedbackBtnClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^(){}];
}

@end
