//
//  PlayableListCell.m
//  KaiStory
//
//  Created by yanzehua on 15/4/28.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "PlayableListCell.h"
#import "Tools.h"
#import "UIColor+HexStringToColor.h"
#import "UIImageView+WebCache.h"

@implementation PlayableListCell

-(void)initLayout:(CGRect)frame
{
    [super initLayout:frame];
    int height = self.bounds.size.height;
    int btnWidth = 46;
    int marginRight = 30;
    self.optionBtnExtA.frame= CGRectMake(FRAME_WIDTH-(marginRight+btnWidth)*RESIZE_RATIO,0,(marginRight+btnWidth)*RESIZE_RATIO,height*RESIZE_RATIO);
    
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
    
    marginTop = 120;
    fontSize = 20;
    self.subLabel.frame = CGRectMake(marginLeft*RESIZE_RATIO, marginTop*RESIZE_RATIO, 200*RESIZE_RATIO,fontSize*RESIZE_RATIO );
    self.subLabel.font = [UIFont systemFontOfSize:fontSize*RESIZE_RATIO];
    
    marginLeft = 100;
    marginTop = 100;
    int btnSize = 70;
    self.playBtn = [[UIButton alloc] initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO, marginTop*RESIZE_RATIO, btnSize*RESIZE_RATIO,btnSize*RESIZE_RATIO )];
    //self.playBtn.backgroundColor = [UIColor blackColor];
    
    [self.playBtn setImage:[UIImage imageNamed:@"故事详情页-播放.png"] forState:UIControlStateNormal];
    [self.playBtn setImage:[UIImage imageNamed:@"故事详情页-暂停.png"] forState:UIControlStateSelected];
    [self.playBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.playBtn];
}


-(void)playBtnClick:(id)sender
{
    NSLog(@"Need overwrite");
}
@end
