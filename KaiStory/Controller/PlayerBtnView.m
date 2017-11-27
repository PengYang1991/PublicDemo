//
//  PlayerBtnView.m
//  KaiStory
//
//  Created by yanzehua on 15/4/27.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "PlayerBtnView.h"
#import "UIImageView+WebCache.h"
#import "UIColor+HexStringToColor.h"
#import "Tools.h"
#import "AudioPlayManager.h"

@implementation PlayerBtnView


-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    int marginLeft = 48;
    int marginTop = 0;
    int width = 60;
    int fontSize = 20;
    self.currentTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO, marginTop*RESIZE_RATIO, width*RESIZE_RATIO, fontSize*RESIZE_RATIO)];
    self.currentTimeLabel.font = [UIFont systemFontOfSize:RESIZE_RATIO*fontSize];
    self.currentTimeLabel.text = @"0:00";
    self.currentTimeLabel.textColor = [UIColor ColorWithHexString:@"#4ab19a"];
    [self addSubview:self.currentTimeLabel];
    
    marginLeft = 108;
    width = 430;
    int height = 20;
    self.timeSlider = [[UISlider alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO, marginTop*RESIZE_RATIO, width*RESIZE_RATIO, height*RESIZE_RATIO)];
    self.timeSlider.value = 0;
    self.timeSlider.minimumValue = 0;
    self.timeSlider.maximumValue = 100;
    [self.timeSlider setMinimumTrackImage:[UIImage imageNamed:@"progress_bar_1"] forState:UIControlStateNormal];
    //self.timeSlider.minimumTrackTintColor = [UIColor ColorWithHexString:@"4fb19b"];
    self.timeSlider.maximumTrackTintColor = [UIColor ColorWithHexString:@"cdd9d5"];
    self.timeSlider.continuous = NO;
    [self.timeSlider setThumbImage:[UIImage imageNamed:@"progress_bar_1"] forState:UIControlStateNormal];
    [self.timeSlider addTarget:self action:@selector(changeSlider:) forControlEvents:UIControlEventValueChanged];
    [self.timeSlider addTarget:self action:@selector(beginChangeSlider:) forControlEvents:UIControlEventTouchDown];
    [self.timeSlider addTarget:self action:@selector(finishChangeSlider:) forControlEvents:UIControlEventTouchUpInside];
    self.isChaningSlider = NO;
    NSLog(@"reset Changing");
    [self addSubview:self.timeSlider];
    
    marginLeft = 540;
    width = 60;
    self.totalTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO, marginTop*RESIZE_RATIO, width*RESIZE_RATIO, fontSize*RESIZE_RATIO)];
    self.totalTimeLabel.font = [UIFont systemFontOfSize:RESIZE_RATIO*fontSize];
    self.totalTimeLabel.text = @"10:00";
    self.totalTimeLabel.textColor = [UIColor ColorWithHexString:@"#4ab19a"];
    [self addSubview:self.totalTimeLabel];
    
    marginTop = 70;
    marginLeft = 100;
    int btnSize = 108;
    self.preButton = [[UIButton alloc] initWithFrame:CGRectMake( marginLeft*RESIZE_RATIO, marginTop*RESIZE_RATIO, btnSize*RESIZE_RATIO, btnSize*RESIZE_RATIO)];
    [self.preButton setImage:[UIImage imageNamed:@"上一故事"] forState:UIControlStateNormal];
    [self.preButton addTarget:self action:@selector(playPreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.preButton];
    
    marginTop = 46;
    btnSize = 160;
    self.playButton = [[UIButton alloc] initWithFrame:CGRectMake( (FRAME_WIDTH-btnSize*RESIZE_RATIO)/2, marginTop*RESIZE_RATIO, btnSize*RESIZE_RATIO, btnSize*RESIZE_RATIO)];
    [self.playButton setImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];
    [self.playButton setImage:[UIImage imageNamed:@"暂停"] forState:UIControlStateSelected];
    [self.playButton addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.playButton];
    
    marginTop = 70;
    int marginRight = 100;
    btnSize = 108;
    self.nextButton = [[UIButton alloc] initWithFrame:CGRectMake(  FRAME_WIDTH-(btnSize+marginRight)*RESIZE_RATIO, marginTop*RESIZE_RATIO, btnSize*RESIZE_RATIO, btnSize*RESIZE_RATIO)];
    [self.nextButton setImage:[UIImage imageNamed:@"下一个故事"] forState:UIControlStateNormal];
    [self.nextButton addTarget:self action:@selector(playNextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.nextButton];
    
    return self;
}

-(void)playBtnClick:(id)sender
{
    if(self.playButton.isSelected)
    {
        [[AudioPlayManager sharedManager] pause];
    }
    else
    {
        [[AudioPlayManager sharedManager] resume];
    }
}


-(void)playPreBtnClick:(id)sender
{
    [[AudioPlayManager sharedManager] previousPlay];
}

-(void)playNextBtnClick:(id)sender
{
    [[AudioPlayManager sharedManager] nextPlay];
}

-(void) updatePlayerBtnViewState
{
    AudioPlayItem *playItem = [AudioPlayManager sharedManager].currentPlayItem;
    if(nil != playItem)
    {
        if(playItem.isPlay)
        {
            self.playButton.selected = YES;
        }
        else
        {
            self.playButton.selected = NO;
        }
    }else
    {
        self.playButton.selected = NO;
    }
}

-(void) updatePlayerBtnView:(NSNotification *)notification
{
    [self updatePlayerBtnViewState];
}

-(void)regObserver
{
    NSString* progressKey = @"progress";
    NSString* playedTimeKey = @"playedTime";
    NSString* totalTimeKey = @"totalTime";
    NSString* totalTimeFloatKey = @"totalTimeFloat";
    [[AudioPlayManager sharedManager] addObserver:self forKeyPath:progressKey options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [[AudioPlayManager sharedManager] addObserver:self forKeyPath:playedTimeKey options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [[AudioPlayManager sharedManager] addObserver:self forKeyPath:totalTimeKey options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [[AudioPlayManager sharedManager] addObserver:self forKeyPath:totalTimeFloatKey options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updatePlayerBtnView:)  name:@"CURRENT_PLAY_ID" object:nil];
}

-(void) unRegObserver
{
    NSString* progressKey = @"progress";
    NSString* playedTimeKey = @"playedTime";
    NSString* totalTimeKey = @"totalTime";
    NSString* totalTimeFloatKey = @"totalTimeFloat";
    [[AudioPlayManager sharedManager] removeObserver:self forKeyPath:progressKey];
    [[AudioPlayManager sharedManager] removeObserver:self forKeyPath:playedTimeKey];
    [[AudioPlayManager sharedManager] removeObserver:self forKeyPath:totalTimeKey];
    [[AudioPlayManager sharedManager] removeObserver:self forKeyPath:totalTimeFloatKey];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if([keyPath isEqualToString:@"progress"] && !self.isChaningSlider)
    {
        [self.timeSlider setValue:[change[@"new"] floatValue] animated:YES];
    }
    
    if([keyPath isEqualToString:@"playedTime"])
    {
        self.currentTimeLabel.text = change[@"new"];
    }
    
    if([keyPath isEqualToString:@"totalTime"])
    {
        self.totalTimeLabel.text = change[@"new"];
    }
    if([keyPath isEqualToString:@"totalTimeFloat"])
    {
        self.totalTime = [change[@"new"] floatValue];
    }
}

- (void)changeSlider:(UISlider *)slider{
    NSLog(@"%f",slider.value);
    CGFloat secOnePiece = self.totalTime/100;
    int destSecond = (int)(secOnePiece*slider.value);
    [[AudioPlayManager sharedManager] moveToSeconds:destSecond];
    
}

-(void)beginChangeSlider:(UISlider*)slider
{
    self.isChaningSlider = YES;
}

-(void)finishChangeSlider:(UISlider*)slider
{
    self.isChaningSlider = NO;
}

@end
