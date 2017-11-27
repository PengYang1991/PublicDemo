//
//  BaseListCell.h
//  KaiStory
//
//  Created by yanzehua on 15/4/27.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseListCell : UITableViewCell

@property(nonatomic,strong)UILabel *mainLabel;
@property(nonatomic,strong)UILabel *subLabel;
@property(nonatomic,strong)UIImageView *baseImgView;
@property(nonatomic,strong)UIImageView *coverImgView;
@property(nonatomic,strong)UIButton *optionBtnExtA;
@property(nonatomic,strong)UIButton *optionBtnExtB;
@property(nonatomic,strong)UIButton *optionBtn;

@property(nonatomic,strong)id data;

-(void)initLayout:(CGRect)frame;
-(void)setModel:(id)inputData;

@end
