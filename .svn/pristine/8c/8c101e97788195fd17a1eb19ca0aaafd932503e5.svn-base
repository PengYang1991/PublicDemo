//
//  LoveStoryCell.m
//  KaiStory
//
//  Created by yanzehua on 15/4/28.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "LoveStoryCell.h"
#import "Tools.h"
#import "StoryModel.h"
#import "UIColor+HexStringToColor.h"
#import "UIImageView+WebCache.h"
#import "AudioPlayManager.h"

@implementation LoveStoryCell

-(void)setModel:(id)inputData
{
    self.data = inputData;
    StoryModel* storyItem =(StoryModel*)self.data;
    [self.coverImgView sd_setImageWithURL:[NSURL URLWithString:storyItem.icon_url]];
    self.mainLabel.text = storyItem.name;
    self.subLabel.text = storyItem.duration;
}

-(void)initLayout:(CGRect)frame
{
    [super initLayout:frame];
    
    int marginRight = 30;
    int btnWidth = 46;
     
    int height = self.bounds.size.height;
    self.optionBtnExtA.frame = CGRectMake(FRAME_WIDTH-(marginRight+btnWidth)*RESIZE_RATIO,0,(marginRight+btnWidth)*RESIZE_RATIO,height);
    
}

-(void)playBtnClick:(id)sender
{
    if(nil != self.data)
    {
        StoryModel* storyItem =(StoryModel*)self.data;
        if(!self.playBtn.selected)
        {
            [[AudioPlayManager sharedManager]playAItem:storyItem addToListOrNot:YES];
        }else
        {
            [[AudioPlayManager sharedManager] pauseAItem:storyItem];
        }
        self.playBtn.selected =!self.playBtn.selected;
    }
}

@end
