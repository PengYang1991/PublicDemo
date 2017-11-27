//
//  BabyDownloadListCell.h
//  KaiStory
//
//  Created by yanzehua on 15/5/5.
//  Copyright (c) 2015年 kaishu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseListCell.h"
#import "PlayableListCell.h"
#import "DownloadItem.h"

@interface BabyDownloadListCell : PlayableListCell

@property(strong,nonatomic) UIView* progressBaseView;
@property(strong,nonatomic) UIView* progressUpView;
@property(strong,nonatomic) UILabel* progressLabel;
@property(strong,nonatomic) DownloadItem* dowloadItem;

-(void) setDownloadInfo:(DownloadItem*) inputItem;
@end
