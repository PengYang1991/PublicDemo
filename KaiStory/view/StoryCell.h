//
//  StoryCell.h
//  KaiStory
//
//  Created by mac on 15/3/31.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoryModel.h"

@protocol PlayStatusDelegate <NSObject>
-(void)UpdatePlayStatus: (NSInteger)index;
@end


@interface StoryCell : UITableViewCell
@property(strong,nonatomic)UIImageView *bannerIcon;
@property(strong,nonatomic)UILabel *albumName;

//@property(strong,nonatomic)UIButton *playBtn;
@property(strong,nonatomic)UIImageView *playIcon;
@property(strong,nonatomic)UILabel *playCount;

@property(strong,nonatomic)UIImageView *favorIcon;
@property(strong,nonatomic)UILabel *favCount;

@property(strong,nonatomic)UIButton *favorBtn;

@property(strong,nonatomic)UILabel *TotalCount;

@property(strong,nonatomic)UIButton *CollectBtn;

@property(strong,nonatomic)UIButton *playBtn;

@property (nonatomic,assign)id<PlayStatusDelegate>m_PlayStatusDelegate;

@property(strong,nonatomic)StoryModel *currentStory;

- (void)initLayout:(CGRect)frame;
-(void)SetCellData:(StoryModel*)story;
@end
