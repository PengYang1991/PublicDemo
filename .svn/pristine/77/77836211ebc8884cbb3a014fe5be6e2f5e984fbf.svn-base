//
//  StoryGridCell.h
//  KaiStory
//
//  Created by yanzehua on 15/4/17.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindModel.h"
#import "StoryModel.h"

@interface StoryGridCell : UIView

@property BOOL isPlaying;
@property UIImageView* btnImgView;
-(id) initWithFrame:(CGRect) rect withStoryItem:(StoryModel*) storyItem withMaskImg:(UIImage*) maskImg;
-(void) updatePlayBtnState: (NSInteger) currentPlayId isPlay:(BOOL) playOrNot;
@property(strong,nonatomic)StoryModel *story;
@end
