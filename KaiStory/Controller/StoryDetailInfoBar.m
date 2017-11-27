//
//  StoryDetailInfoBar.m
//  KaiStory
//
//  Created by yanzehua on 15/5/2.
//  Copyright (c) 2015年 kaishu. All rights reserved.
//

#import "StoryDetailInfoBar.h"
#import "UIColor+HexStringToColor.h"
#import "UIImageView+WebCache.h"
#import "Tools.h"

@implementation StoryDetailInfoBar

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor ColorWithHexString:@"e1f1eb"];
    NSArray* imgNameArray = [NSArray arrayWithObjects:@"详情播放量",@"详情收藏量",@"详情播放时长",@"详情价格", nil];
    for(int i = 0; i< 4; i++)
    {
        int marginLeft = 162 + 120 * i;
        int marginTop = 12;
        int iconSize = 20;
        UIImageView* iconImgView = [[UIImageView alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO, marginTop*RESIZE_RATIO, iconSize*RESIZE_RATIO, iconSize*RESIZE_RATIO)];
        [iconImgView setImage:[UIImage imageNamed:[imgNameArray objectAtIndex:i]]] ;
        [self addSubview:iconImgView];
    }
    
    self.labelArray = [[NSMutableArray alloc]initWithCapacity:4];
    for(int i = 0; i< 4; i++)
    {
        int marginLeft = 162 + 120 * i + 28;
        int marginTop = 12;
        int fontSize = 18;
        int labelwidth = 100;
        UILabel* labelView = [[UILabel alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO, marginTop*RESIZE_RATIO, labelwidth*RESIZE_RATIO, fontSize*RESIZE_RATIO)];
        labelView.font = [UIFont systemFontOfSize:fontSize*RESIZE_RATIO];
        labelView.textColor = [UIColor ColorWithHexString:@"656565"];
        labelView.text = @"信息";
        [self addSubview:labelView];
        [self.labelArray addObject:labelView];
    }
    return self;
}

-(void)setModel:(StoryModel*) storyItem
{
    if([Tools isBlankString:storyItem.play_count])
    {
        ((UILabel*)[self.labelArray objectAtIndex:0]).text = @"0";
    }else
    {
        ((UILabel*)[self.labelArray objectAtIndex:0]).text = storyItem.play_count;
    }
    if([Tools isBlankString:storyItem.favor_count])
    {
        ((UILabel*)[self.labelArray objectAtIndex:1]).text = @"0";
    }
    else
    {
        ((UILabel*)[self.labelArray objectAtIndex:1]).text = storyItem.favor_count;
    }
    ((UILabel*)[self.labelArray objectAtIndex:2]).text = storyItem.duration;
     if([Tools isBlankString:storyItem.favor_count])
     {
         ((UILabel*)[self.labelArray objectAtIndex:3]).text= @"0";
     }else
     {
         ((UILabel*)[self.labelArray objectAtIndex:3]).text = storyItem.price;
     }
}
@end
