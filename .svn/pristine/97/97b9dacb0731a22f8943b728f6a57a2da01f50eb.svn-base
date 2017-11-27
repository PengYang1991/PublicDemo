//
//  KStoryCell.h
//  KaiStory
//
//  Created by yanzehua on 15/5/11.
//  Copyright (c) 2015年 kaishu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoryModel.h"

@interface KStoryCell : UITableViewCell

@property(nonatomic,strong)UIImageView *baseImgView;
@property(nonatomic,strong)UIImageView *coverImgView;
@property(nonatomic,strong)UIButton *optionBtnExtA;
@property(nonatomic,strong)UIButton *optionBtnExtB;
@property(nonatomic,strong)UIButton *optionBtn;
@property (strong,nonatomic)UIButton* playBtn;

@property(nonatomic,strong)UILabel *mainLabel;
@property(nonatomic,strong)UIImageView *playCountImgView;
@property(nonatomic,strong)UILabel *playCountLabel;
@property(nonatomic,strong)UIImageView *loveCountImgView;
@property(nonatomic,strong)UILabel *loveCountLabel;
@property(nonatomic,strong)UIImageView *durationImgView;
@property(nonatomic,strong)UILabel *durationLabel;
@property(nonatomic,strong)UIImageView *priceImgView;
@property(nonatomic,strong)UILabel *priceLabel;

@property(nonatomic,strong)StoryModel* data;

-(void)initLayout:(CGRect)frame;
-(void)playBtnClick:(id)sender;
-(void)setModel:(StoryModel*)inputData;

@end
