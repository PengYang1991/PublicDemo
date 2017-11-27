//
//  LoveDailyCell.m
//  KaiStory
//
//  Created by yanzehua on 15/5/1.
//  Copyright (c) 2015年 kaishu. All rights reserved.
//

#import "LoveDailyCell.h"
#import "DailyModel.h"
#import "UIImageView+WebCache.h"
#import "Tools.h"
#import "UIColor+HexStringToColor.h"

@implementation LoveDailyCell


-(void)setModel:(id)inputData
{
    self.data = inputData;
    DailyModel* dailyItem =(DailyModel*)self.data;
    [self.coverImgView sd_setImageWithURL:[NSURL URLWithString:dailyItem.img_url]];
    self.mainLabel.text = dailyItem.title;
    self.subLabel.text = dailyItem.release_date;
}


-(void)initLayout:(CGRect)frame
{
    [super initLayout:frame];
    
    int marginLeft = 2;
    int marginTop = 4;
    int imgWidth = 250;
    int imgHeight = 136;
    self.baseImgView.frame = CGRectMake(marginLeft*RESIZE_RATIO, marginTop*RESIZE_RATIO, imgWidth*RESIZE_RATIO, imgHeight*RESIZE_RATIO);
    self.coverImgView.frame = CGRectMake(marginLeft*RESIZE_RATIO, marginTop*RESIZE_RATIO, imgWidth*RESIZE_RATIO, imgHeight*RESIZE_RATIO);
    
    marginLeft = 290;
    marginTop = 50;
    int fontSize = 28;
    int labelWidth =300;
    self.mainLabel.frame = CGRectMake(marginLeft*RESIZE_RATIO, marginTop*RESIZE_RATIO, labelWidth*RESIZE_RATIO,fontSize*RESIZE_RATIO );
    self.mainLabel.font = [UIFont systemFontOfSize:fontSize*RESIZE_RATIO];
    
    marginTop = 90;
    fontSize = 18;
    self.subLabel.frame = CGRectMake(marginLeft*RESIZE_RATIO, marginTop*RESIZE_RATIO, 200*RESIZE_RATIO,fontSize*RESIZE_RATIO );
    self.subLabel.font = [UIFont systemFontOfSize:fontSize*RESIZE_RATIO];
    
    int marginRight = 30;
    int btnWidth = 46;
    int btnHeight = 10;
    marginTop = 66;
    self.optionBtn.frame = CGRectMake(FRAME_WIDTH-(marginRight+btnWidth)*RESIZE_RATIO,marginTop*RESIZE_RATIO,btnWidth*RESIZE_RATIO,btnHeight*RESIZE_RATIO);
}


@end
