//
//  PlayerListItemView.m
//  KaiStory
//
//  Created by yanzehua on 15/4/24.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "PlayerListItemView.h"
#import "Tools.h"
#import "UIImageView+WebCache.h"
#import "UIColor+HexStringToColor.h"

@implementation PlayerListItemView


- (void)initLayout:(CGRect)frame
{
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        int marginLeft = 0;
        int marginTop = 14;
        int imgSize = 77;
        self.coverImgView = [[UIImageView alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO, marginTop*RESIZE_RATIO, imgSize*RESIZE_RATIO, imgSize*RESIZE_RATIO)];
        [self.coverImgView setImage:[UIImage imageNamed:@"defaultCoverSmall.jpg"]];
        [self addSubview:self.coverImgView];
        
        
        marginLeft = 100;
        marginTop = 40;
        int width = 200;
        int height = 28;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO, marginTop*RESIZE_RATIO, width*RESIZE_RATIO, height*RESIZE_RATIO)];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:28*FONT_RESIZE_RATIO];
        self.titleLabel.textColor = [UIColor ColorWithHexString:@"ababab"];
        self.titleLabel.text =@"音频题目";
        [self addSubview:self.titleLabel];
        
        
        marginLeft = 500;
        marginTop = 44;
        width = 100;
        height = 20;
        self.periodLabel = [[UILabel alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO, marginTop*RESIZE_RATIO, width*RESIZE_RATIO, height*RESIZE_RATIO)];
        self.periodLabel.font = [UIFont systemFontOfSize:20*FONT_RESIZE_RATIO];
        self.periodLabel.textColor = [UIColor ColorWithHexString:@"434343"];
        self.periodLabel.text =@"音频时长";
        [self addSubview:self.periodLabel];
    }
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}




@end
