//
//  KStoryCell.m
//  KaiStory
//
//  Created by yanzehua on 15/5/11.
//  Copyright (c) 2015年 kaishu. All rights reserved.
//

#import "KStoryCell.h"
#import "Tools.h"
#import "UIColor+HexStringToColor.h"
#import "UIImageView+WebCache.h"
#import "AudioPlayManager.h"

@implementation KStoryCell
-(void)initLayout:(CGRect)frame
{
    int marginLeft = 2;
    int marginTop = 2;
    int imgWidth = 170;
    int height = self.bounds.size.height;
    self.baseImgView =[[UIImageView alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO,marginTop*RESIZE_RATIO ,imgWidth*RESIZE_RATIO,height-marginTop*RESIZE_RATIO)];
    self.baseImgView.image = [UIImage imageNamed:@"defaultCoverSmall.jpg"];
    self.coverImgView = [[UIImageView alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO,marginTop*RESIZE_RATIO ,imgWidth*RESIZE_RATIO,height-marginTop*RESIZE_RATIO)];
    [self addSubview:self.baseImgView];
    [self addSubview:self.coverImgView];
    
    marginLeft = 100;
    marginTop = 100;
    int btnSize = 70;
    self.playBtn = [[UIButton alloc] initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO, marginTop*RESIZE_RATIO, btnSize*RESIZE_RATIO,btnSize*RESIZE_RATIO )];
    //self.playBtn.backgroundColor = [UIColor blackColor];
    [self.playBtn setImage:[UIImage imageNamed:@"故事详情页-播放.png"] forState:UIControlStateNormal];
    [self.playBtn setImage:[UIImage imageNamed:@"故事详情页-暂停.png"] forState:UIControlStateSelected];
    [self.playBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.playBtn];
    
    marginLeft = 200;
    marginTop = 70;
    int fontSize = 26;
    int labelWidth = 300;
    self.mainLabel=[[UILabel alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO,marginTop*RESIZE_RATIO,labelWidth*RESIZE_RATIO,fontSize*RESIZE_RATIO)];
    self.mainLabel.text = @"标题";
    self.mainLabel.font = [UIFont systemFontOfSize:fontSize*RESIZE_RATIO];
    self.mainLabel.textColor = [UIColor ColorWithHexString:@"656565"];
    [self addSubview:self.mainLabel];
    
    marginTop = 130;
    marginLeft = 200;
    fontSize = 14;
    labelWidth = 100;
    int imgSize = 15;
    self.playCountImgView = [[UIImageView alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO,marginTop*RESIZE_RATIO,imgSize*RESIZE_RATIO,imgSize*RESIZE_RATIO)];
    [self.playCountImgView setImage:[UIImage imageNamed:@"列表播放量"]];
    [self addSubview:self.playCountImgView];
    
    marginLeft = 220;
    self.playCountLabel=[[UILabel alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO,marginTop*RESIZE_RATIO,labelWidth*RESIZE_RATIO,fontSize*RESIZE_RATIO)];
    self.playCountLabel.text = @"0";
    self.playCountLabel.font = [UIFont systemFontOfSize:fontSize*RESIZE_RATIO];
    self.playCountLabel.textColor = [UIColor ColorWithHexString:@"656565"];
    [self addSubview:self.playCountLabel];
    
    marginLeft = 320;
    self.loveCountImgView = [[UIImageView alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO,marginTop*RESIZE_RATIO,imgSize*RESIZE_RATIO,imgSize*RESIZE_RATIO)];
    [self.loveCountImgView setImage:[UIImage imageNamed:@"列表收藏量"]];
    [self addSubview:self.loveCountImgView];
    
    marginLeft = 340;
    self.loveCountLabel=[[UILabel alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO,marginTop*RESIZE_RATIO,labelWidth*RESIZE_RATIO,fontSize*RESIZE_RATIO)];
    self.loveCountLabel.text = @"0";
    self.loveCountLabel.font = [UIFont systemFontOfSize:fontSize*RESIZE_RATIO];
    self.loveCountLabel.textColor = [UIColor ColorWithHexString:@"656565"];
    [self addSubview:self.loveCountLabel];
    
    marginLeft = 440;
    self.durationImgView = [[UIImageView alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO,marginTop*RESIZE_RATIO,imgSize*RESIZE_RATIO,imgSize*RESIZE_RATIO)];
    [self.durationImgView setImage:[UIImage imageNamed:@"列表播放时长"]];
    [self addSubview:self.durationImgView];
    
    marginLeft = 460;
    self.durationLabel=[[UILabel alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO,marginTop*RESIZE_RATIO,labelWidth*RESIZE_RATIO,fontSize*RESIZE_RATIO)];
    self.durationLabel.text = @"0";
    self.durationLabel.font = [UIFont systemFontOfSize:fontSize*RESIZE_RATIO];
    self.durationLabel.textColor = [UIColor ColorWithHexString:@"656565"];
    [self addSubview:self.durationLabel];
    
    marginLeft = 560;
    self.priceImgView = [[UIImageView alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO,marginTop*RESIZE_RATIO,imgSize*RESIZE_RATIO,imgSize*RESIZE_RATIO)];
    [self.priceImgView setImage:[UIImage imageNamed:@"列表价格"]];
    [self addSubview:self.priceImgView];
    
    marginLeft = 580;
    self.priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO,marginTop*RESIZE_RATIO,labelWidth*RESIZE_RATIO,fontSize*RESIZE_RATIO)];
    self.priceLabel.text = @"0";
    self.priceLabel.font = [UIFont systemFontOfSize:fontSize*RESIZE_RATIO];
    self.priceLabel.textColor = [UIColor ColorWithHexString:@"656565"];
    [self addSubview:self.priceLabel];
    
    int marginRight = 30;
    marginTop = 80;
    int btnWidth = 46;
    int btnHeight = 10;
    self.optionBtn = [[UIButton alloc]initWithFrame:CGRectMake(FRAME_WIDTH-(marginRight+btnWidth)*RESIZE_RATIO,marginTop*RESIZE_RATIO,btnWidth*RESIZE_RATIO,btnHeight*RESIZE_RATIO)];
    [self.optionBtn setImage:[UIImage imageNamed:@"更多.png"] forState:UIControlStateNormal];
    [self.optionBtn setImage:[UIImage imageNamed:@"更多.png"] forState:UIControlStateSelected];
    self.optionBtnExtA = [[UIButton alloc]initWithFrame:CGRectMake(FRAME_WIDTH-(marginRight+btnWidth)*RESIZE_RATIO,0,(marginTop + btnWidth)*RESIZE_RATIO,height)];
    //[self.optionBtnExtB setBackgroundColor:[UIColor blackColor]];
    [self addSubview:self.optionBtn];
    [self addSubview:self.optionBtnExtA];
 }


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
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

-(void)setModel:(StoryModel*)inputData
{
    self.data = inputData;
    [self.coverImgView sd_setImageWithURL:[NSURL URLWithString:self.data.icon_url]];
    self.mainLabel.text = self.data.name;
    self.playCountLabel.text = self.data.play_count;
    self.loveCountLabel.text = self.data.favor_count;
    self.durationLabel.text = self.data.duration;
    self.priceLabel.text = self.data.price;
}

@end
