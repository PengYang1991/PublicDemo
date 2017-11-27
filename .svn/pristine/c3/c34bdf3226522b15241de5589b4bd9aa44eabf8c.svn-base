//
//  PlayerCoverView.m
//  KaiStory
//
//  Created by yanzehua on 15/4/24.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "PlayerCoverView.h"
#import "Tools.h"
#import "UIColor+HexStringToColor.h"
#import "AudioPlayManager.h"
#import "UIImageView+WebCache.h"

@implementation PlayerCoverView


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    int authorLabelFontSize = 22;
    int marginTop = 4;
    self.authorLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, marginTop*RESIZE_RATIO, FRAME_WIDTH, authorLabelFontSize*RESIZE_RATIO)];
    self.authorLabel.text = @"作者信息";
    self.authorLabel.textAlignment = NSTextAlignmentCenter;
    self.authorLabel.font = [UIFont systemFontOfSize:authorLabelFontSize*RESIZE_RATIO];
    self.authorLabel.textColor = [UIColor ColorWithHexString:@"4ab19a"];
    [self addSubview:self.authorLabel];
    
    int coverImgMarginLeft = 78;
    int coverImgMarginTop =104;
    int coverImgSize = 484;
    UIImageView* backCoverImgView = [[UIImageView alloc]initWithFrame:CGRectMake(coverImgMarginLeft*RESIZE_RATIO, coverImgMarginTop*RESIZE_RATIO, coverImgSize*RESIZE_RATIO, coverImgSize*RESIZE_RATIO)];
    [backCoverImgView setImage:[UIImage imageNamed:@"defaultCoverBig.jpg"]];
    [self addSubview:backCoverImgView];
    
    self.coverImgView = [[UIImageView alloc]initWithFrame:CGRectMake(coverImgMarginLeft*RESIZE_RATIO, coverImgMarginTop*RESIZE_RATIO, coverImgSize*RESIZE_RATIO, coverImgSize*RESIZE_RATIO)];
    [self.coverImgView setImage:[UIImage imageNamed:@"defaultCoverBig.jpg"]];
    [self addSubview:self.coverImgView];
    
    UIImageView* coverFrameImgView = [[UIImageView alloc]initWithFrame:CGRectMake(coverImgMarginLeft*RESIZE_RATIO, coverImgMarginTop*RESIZE_RATIO, coverImgSize*RESIZE_RATIO, coverImgSize*RESIZE_RATIO)];
    [coverFrameImgView setImage:[UIImage imageNamed:@"cover_frame"]];
    [self addSubview:coverFrameImgView];
    return self;
}

-(void) updateState
{
    AudioPlayItem *playItem = [AudioPlayManager sharedManager].currentPlayItem;
    if(nil != playItem)
    {
        [self.authorLabel setText:playItem.story.author];
        [self.coverImgView sd_setImageWithURL:[NSURL URLWithString:playItem.story.cover_url]];
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
