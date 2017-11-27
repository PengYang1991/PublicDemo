//
//  StoryDetailAbstractView.m
//  KaiStory
//
//  Created by yanzehua on 15/5/2.
//  Copyright (c) 2015年 kaishu. All rights reserved.
//

#import "StoryDetailAbstractView.h"
#import "UIColor+HexStringToColor.h"
#import "UIImageView+WebCache.h"
#import "Tools.h"

@implementation StoryDetailAbstractView

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    int marginLeft = 35;
    int marginTop  =  36;
    int fontSize = 35;
    int labelWidth = 200;
    int labelHeight = 35;
    self.barLabel = [[UILabel alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO, marginTop*RESIZE_RATIO, labelWidth*RESIZE_RATIO, labelHeight*RESIZE_RATIO)];
    self.barLabel.textColor = [UIColor ColorWithHexString:@"4db299"];
    self.barLabel.font = [UIFont systemFontOfSize:fontSize*RESIZE_RATIO];
    self.barLabel.text = @"故事简介";
    [self addSubview:self.barLabel];
    
    marginLeft = 10;
    marginTop = 36;
    int imgWidth = 10;
    int imgHeight = 36;
    self.barImgView = [[UIImageView alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO, marginTop*RESIZE_RATIO, imgWidth*RESIZE_RATIO, imgHeight*RESIZE_RATIO )];
    [self.barImgView setImage:[UIImage imageNamed:@"详情分类柱"]];
    [self addSubview:self.barImgView];
    
    marginLeft = 35;
    marginTop  =  100;
    fontSize = 30;
    labelWidth = 580;
    labelHeight = 140;

    self.abstractLabel = [[UILabel alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO, marginTop*RESIZE_RATIO, labelWidth*RESIZE_RATIO, labelHeight*RESIZE_RATIO)];
    self.abstractLabel.text = @"故事简介";
    self.abstractLabel.font = [UIFont systemFontOfSize:fontSize*RESIZE_RATIO];
    self.abstractLabel.lineBreakMode = UILineBreakModeWordWrap;
    self.abstractLabel.numberOfLines = 0;
    //[self.abstractLabel sizeToFit];
    [self addSubview:self.abstractLabel];
    
    return self;
}

-(void)setAbstract:(NSString*) inputAbstract
{
    self.abstractLabel.text = inputAbstract;
    [self.abstractLabel sizeToFit];
}
@end
