//
//  PlayerFootBar.m
//  KaiStory
//
//  Created by yanzehua on 15/4/25.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "PlayerFootBar.h"
#import "Tools.h"
#import "UIColor+HexStringToColor.h"
#import "UIImageView+WebCache.h"
#import "AudioPlayManager.h"

@implementation PlayerFootBar


-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self initLayout];
    return self;
}

-(void) initLayout
{
    self.backgroundColor = [UIColor ColorWithHexString:@"e1efeb"];
    int marginLeft = 10;
    int marginTop = 10;
    int coverSize = 82;
    self.coverImgView = [[UIImageView alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO, marginTop*RESIZE_RATIO, coverSize*RESIZE_RATIO, coverSize*RESIZE_RATIO)];
    [self.coverImgView setImage:[UIImage imageNamed:@"defaultCoverSmall.jpg"]];
    [self addSubview:self.coverImgView];
    
    marginLeft = 100;
    marginTop = 20;
    int width = 400;
    int height = 30;
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO, marginTop*RESIZE_RATIO, width*RESIZE_RATIO, height*RESIZE_RATIO)];
    self.titleLabel.text = @"故事名称";
    self.titleLabel.font = [UIFont systemFontOfSize:height*RESIZE_RATIO];
    self.titleLabel.textColor = [UIColor ColorWithHexString:@"4ab19a"];
    [self addSubview:self.titleLabel];
    
    marginTop = 60;
    width = 400;
    height = 20;
    self.authorLabel = [[UILabel alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO, marginTop*RESIZE_RATIO, width*RESIZE_RATIO, height*RESIZE_RATIO)];
    self.authorLabel.text = @"作者名称";
    self.authorLabel.font = [UIFont systemFontOfSize:height*RESIZE_RATIO];
    self.authorLabel.textColor = [UIColor ColorWithHexString:@"7a7a7a"];
    [self addSubview:self.authorLabel];
    
  
    marginTop = 6;
    int btnSize = 90;
    int marginRight = 30;
    self.playBtn = [[UIButton alloc] initWithFrame:CGRectMake(FRAME_WIDTH-(marginRight+btnSize)*RESIZE_RATIO,marginTop*RESIZE_RATIO,btnSize*RESIZE_RATIO,btnSize*RESIZE_RATIO)];
    [self.playBtn setBackgroundImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];
    [self.playBtn setBackgroundImage:[UIImage imageNamed:@"暂停"] forState:UIControlStateSelected];
    [self.playBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.playBtn];
}



-(void)playBtnClick:(id)sender
{
    if(self.playBtn.isSelected)
    {
      [[AudioPlayManager sharedManager] pause];
    }
    else
    {
      [[AudioPlayManager sharedManager] resume];
    }
}

-(void) updateState
{
    AudioPlayItem *playItem = [AudioPlayManager sharedManager].currentPlayItem;
    if(nil != playItem)
    {
        [self.coverImgView sd_setImageWithURL:[NSURL URLWithString:playItem.story.cover_url]];
        self.titleLabel.text =playItem.story.name;
        self.authorLabel.text = playItem.story.author;
        if(playItem.isPlay)
        {
            self.playBtn.selected = YES;
        }
        else
        {
            self.playBtn.selected = NO;
        }
    }else
    {
        self.playBtn.selected = NO;
    }
}

-(void) updateFootBar:(NSNotification *)notification
{
    [self updateState];
}

-(void)regObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateFootBar:)  name:@"CURRENT_PLAY_ID" object:nil];
}

-(void) unRegObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
