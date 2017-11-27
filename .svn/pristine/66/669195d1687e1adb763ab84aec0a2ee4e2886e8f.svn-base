//
//  PlayerDetailView.m
//  KaiStory
//
//  Created by yanzehua on 15/4/23.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "PlayerDetailView.h"
#import "Tools.h"
#import "UIColor+HexStringToColor.h"
#import "AudioPlayManager.h"

@implementation PlayerDetailView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    int marginLeft = 25;
    int marginTop = 28;
    int const leftImgwidth = 8;
    int const leftImgHeight = 34;
    self.detailLeftImgView = [[UIImageView alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO,marginTop*RESIZE_RATIO,leftImgwidth*RESIZE_RATIO,leftImgHeight*RESIZE_RATIO)];
    [self.detailLeftImgView setImage:[UIImage imageNamed:@"分类提示标"]];
    [self addSubview:self.detailLeftImgView];
    
    marginLeft = 40;
    marginTop = 30;
    int const leftLabelWidth = 200;
    int const leftLabelHeight = 28;
    self.detailLeftLabel = [[UILabel alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO,marginTop*RESIZE_RATIO, leftLabelWidth*RESIZE_RATIO, leftLabelHeight*RESIZE_RATIO)];
    self.detailLeftLabel.text = @"故事详情";
    self.detailLeftLabel.textColor = [UIColor ColorWithHexString:@"4ab19a"];
    self.detailLeftLabel.font = [UIFont systemFontOfSize:leftLabelHeight*RESIZE_RATIO];
    [self addSubview:self.detailLeftLabel];
    
    marginLeft = 40;
    marginTop = 90;
    int const detailTagWidth = 100;
    int const detailTagHeight = 24;
    self.detailAuthorTag = [[UILabel alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO,marginTop*RESIZE_RATIO, detailTagWidth*RESIZE_RATIO, detailTagHeight*RESIZE_RATIO)];
    self.detailAuthorTag.text = @"作者：";
    self.detailAuthorTag.textColor = [UIColor ColorWithHexString:@"9c9c9c"];
    self.detailAuthorTag.font = [UIFont systemFontOfSize:detailTagHeight*RESIZE_RATIO];
    [self addSubview:self.detailAuthorTag];
    
    marginTop = 140;
    self.detailPublishTag = [[UILabel alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO,marginTop*RESIZE_RATIO, detailTagWidth*RESIZE_RATIO, detailTagHeight*RESIZE_RATIO)];
    self.detailPublishTag.text = @"出版社：";
    self.detailPublishTag.textColor = [UIColor ColorWithHexString:@"9c9c9c"];
    self.detailPublishTag.font = [UIFont systemFontOfSize:detailTagHeight*RESIZE_RATIO];
    [self addSubview:self.detailPublishTag];
    
    marginTop = 190;
    self.detailAbstractTag = [[UILabel alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO,marginTop*RESIZE_RATIO, detailTagWidth*RESIZE_RATIO, detailTagHeight*RESIZE_RATIO)];
    self.detailAbstractTag.text = @"简介：";
    self.detailAbstractTag.textColor = [UIColor ColorWithHexString:@"9c9c9c"];
    self.detailAbstractTag.font = [UIFont systemFontOfSize:detailTagHeight*RESIZE_RATIO];
    [self addSubview:self.detailAbstractTag];
    
    marginLeft = 140;
    marginTop = 90;
    int detailInfoWidth = 400;
    int detailInfoHeight = 28;
    self.detailAuthorLabel = [[UILabel alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO,marginTop*RESIZE_RATIO, detailInfoWidth*RESIZE_RATIO, detailInfoHeight*RESIZE_RATIO)];
    self.detailAuthorLabel.text = @"作者信息";
    self.detailAuthorLabel.textColor = [UIColor ColorWithHexString:@"656565"];
    self.detailAuthorLabel.font = [UIFont systemFontOfSize:detailInfoHeight*RESIZE_RATIO];
    [self addSubview:self.detailAuthorLabel];
    
    marginTop = 140;
    self.detailPublishLabel = [[UILabel alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO,marginTop*RESIZE_RATIO, detailInfoWidth*RESIZE_RATIO, detailInfoHeight*RESIZE_RATIO)];
    self.detailPublishLabel.text = @"出版社信息";
    self.detailPublishLabel.textColor = [UIColor ColorWithHexString:@"656565"];
    self.detailPublishLabel.font = [UIFont systemFontOfSize:detailInfoHeight*RESIZE_RATIO];
    [self addSubview:self.detailPublishLabel];
    
    int detailAbstractHeight = 100;
    marginTop = 190;
    self.detailAbstractLabel = [[UILabel alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO,marginTop*RESIZE_RATIO, detailInfoWidth*RESIZE_RATIO, detailAbstractHeight*RESIZE_RATIO)];
    self.detailAbstractLabel.text = @"简介信息";
    //todo 长度不够的时候，需要补充空格以占据长度
    self.detailAbstractLabel.textColor = [UIColor ColorWithHexString:@"656565"];
    //self.detailAbstractLabel.backgroundColor = [UIColor blackColor];
    self.detailAbstractLabel.font = [UIFont systemFontOfSize:detailInfoHeight*FONT_RESIZE_RATIO];
    self.detailAbstractLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.detailAbstractLabel.numberOfLines = 0;
    [self addSubview:self.detailAbstractLabel];
    
    return self;
}


-(void) updateState
{
    AudioPlayItem *playItem = [AudioPlayManager sharedManager].currentPlayItem;
    if(nil != playItem)
    {
        [self.detailAuthorLabel setText:playItem.story.author];
        [self.detailPublishLabel setText:playItem.story.publisher];
        [self.detailAbstractLabel setText:playItem.story.summary];
        [self.detailAbstractLabel sizeToFit];
    }
}

-(void) updateCoverView:(NSNotification *)notification
{
    [self updateState];
}

-(void)regObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateCoverView:)  name:@"CURRENT_PLAY_ID" object:nil];
}

-(void) unRegObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
