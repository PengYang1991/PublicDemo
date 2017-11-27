//
//  AlbumCellView.h
//  KaiStory
//
//  Created by mac on 15/4/17.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumeModel.h"

@interface AlbumCellView : UITableViewCell

@property(strong,nonatomic)UIImageView *bannerIcon;
@property(strong,nonatomic)UILabel *albumName;

@property(strong,nonatomic)UIButton *playBtn;
@property(strong,nonatomic)UIImageView *playIcon;
@property(strong,nonatomic)UILabel *playCount;

@property(strong,nonatomic)UIImageView *favorIcon;
@property(strong,nonatomic)UILabel *favCount;

@property(strong,nonatomic)UIButton *favorBtn;

@property(strong,nonatomic)UILabel *TotalCount;

@property(strong,nonatomic)UIButton *CollectBtn;



-(void)SetCellData:(AlbumeModel*)album;

- (void)initLayout:(CGRect)frame;
@end
