//
//  LoveAlbumCell.m
//  KaiStory
//
//  Created by yanzehua on 15/5/11.
//  Copyright (c) 2015年 kaishu. All rights reserved.
//

#import "LoveAlbumCell.h"
#import "KSAlbumModel.h"
#import "Tools.h"
#import "UIImageView+WebCache.h"
#import "UIColor+HexStringToColor.h"


@implementation LoveAlbumCell

-(void)setModel:(id)inputData
{
    self.data = inputData;
    KSAlbumModel* modelItem =(KSAlbumModel*)self.data;
    if(![Tools isBlankString:modelItem.modelPic]){
        [self.coverImgView sd_setImageWithURL:[NSURL URLWithString:modelItem.modelPic]];
    }
    self.mainLabel.text = modelItem.modelName;
    }


-(void)initLayout:(CGRect)frame{
    [super initLayout:frame];
    [self.subLabel removeFromSuperview];
    [self.optionBtn removeFromSuperview];
    [self.optionBtnExtA removeFromSuperview];
 
    
    int marginLeft = 2;
    int marginTop = 4;
    int imgSize = 170;
    self.baseImgView.frame = CGRectMake(marginLeft*RESIZE_RATIO, marginTop*RESIZE_RATIO, imgSize*RESIZE_RATIO, imgSize*RESIZE_RATIO);
    self.coverImgView.frame = CGRectMake(marginLeft*RESIZE_RATIO, marginTop*RESIZE_RATIO, imgSize*RESIZE_RATIO, imgSize*RESIZE_RATIO);
    
    marginLeft = 220;
    marginTop = 70;
    int fontSize = 28;
    int labelWidth =300;
    self.mainLabel.frame = CGRectMake(marginLeft*RESIZE_RATIO, marginTop*RESIZE_RATIO, labelWidth*RESIZE_RATIO,fontSize*RESIZE_RATIO );
    self.mainLabel.font = [UIFont systemFontOfSize:fontSize*RESIZE_RATIO];
}

@end
