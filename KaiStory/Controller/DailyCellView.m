//
//  DailyCellView.m
//  KaiStory
//
//  Created by yanzehua on 15/4/14.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "DailyCellView.h"
#import "UIColor+HexStringToColor.h"
#import "Tools.h"
#import "UIImageView+AFNetworking.h"
#import "UIImageView+WebCache.h"

@implementation DailyCellView

- (void) initConst
{
    readPrefix = @"阅读 %@";
    commentPrefix = @"评论 %@";
    sharePrefix = @"分享 %@";
    favorPrefix = @"喜欢 %@";
}

- (void)initLayout:(CGRect)frame
{
    int WIDTH = frame.size.width;
    //int HEIGHT = frame.size.height;
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        int const marginLeft = 20;
        //int const marginRight = 20;
        
        // 头图的图像区域
        int const imgMarginTop = 20;
        int const imgWidth = 222;
        int const imgHeight = 120;
        self.todayImage =[[UIImageView alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO, imgMarginTop*RESIZE_RATIO, imgWidth*RESIZE_RATIO, imgHeight*RESIZE_RATIO)];
        [self addSubview:self.todayImage];
        self.todayImage.contentMode = UIViewContentModeScaleAspectFill;
        self.todayImage.clipsToBounds  = YES;
        
        // 标题区域
        int const titleMarginLeft = marginLeft + imgWidth + 25;
        int const titleMarginRight = 35;
        int const titleFontSize = 30;
        int const titleHeight = 80;
        NSString *titleFontColor = @"808080";
        self.todayName =[[UILabel alloc]initWithFrame:CGRectMake(titleMarginLeft*RESIZE_RATIO, imgMarginTop*RESIZE_RATIO, WIDTH-(titleMarginLeft+titleMarginRight)*RESIZE_RATIO, titleHeight*RESIZE_RATIO)];
        self.todayName.font =  [UIFont boldSystemFontOfSize:titleFontSize*RESIZE_RATIO];
        self.todayName.numberOfLines = 2;
        self.todayName.lineBreakMode = NSLineBreakByWordWrapping;
        UIColor *todayNameColor = [UIColor ColorWithHexString:titleFontColor];
        self.todayName.textColor = todayNameColor;
        [self addSubview:self.todayName];
        
        // 发布时间区域
        int const timeMarginTop = 12;
        int const timeMarginLeft = marginLeft + imgWidth + 25;
        int const timeTop = imgMarginTop + titleHeight + timeMarginTop;
        NSString *timeFontColor =@"4ab19a";
        int const timeFontSize = 20;
        self.todayTime = [[UILabel alloc]initWithFrame:CGRectMake(timeMarginLeft*RESIZE_RATIO, timeTop*RESIZE_RATIO, WIDTH-(titleMarginLeft+titleMarginRight)*RESIZE_RATIO, timeFontSize*RESIZE_RATIO)];
        self.todayTime.font =  [UIFont boldSystemFontOfSize:timeFontSize*RESIZE_RATIO];
        UIColor *todayTimeColor = [UIColor ColorWithHexString:timeFontColor];
        self.todayTime.textColor = todayTimeColor;
        [self addSubview:self.todayTime];
        
        
        // 展示内容区域
        int const infoRegionMarginTop = 13;
        int const infoTop = imgMarginTop + imgHeight + infoRegionMarginTop;
        int const infoIconSize = 20;
        int const infoTxtWidth = 100;
        int const infoTxtFontSize = 16;
        NSString* infoTxtFontColor = @"9d9e9e";
        UIColor *infoFontColor = [UIColor ColorWithHexString:infoTxtFontColor];
        int const infoIconMarginRight = 10;
        
        self.readIcon = [[UIImageView alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO, infoTop*RESIZE_RATIO, infoIconSize*RESIZE_RATIO, infoIconSize*RESIZE_RATIO)];
        [self.readIcon setImage:[UIImage imageNamed:@"阅读.png"]];
        [self addSubview:self.readIcon];
        
        int const readTxtMarginLeft = marginLeft + infoIconSize + infoIconMarginRight;
        self.read_count =[[UILabel alloc]initWithFrame:CGRectMake(readTxtMarginLeft*RESIZE_RATIO, infoTop*RESIZE_RATIO, infoTxtWidth * RESIZE_RATIO, infoTxtFontSize*RESIZE_RATIO)];
        self.read_count.text = [NSString stringWithFormat:readPrefix,@"0"];
        self.read_count.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        self.read_count.font =  [UIFont boldSystemFontOfSize:infoTxtFontSize*RESIZE_RATIO];
        self.read_count.textColor = infoFontColor;
        [self addSubview:self.read_count];
        
        
        int const commentIconMarginLeft = 178;
        self.commentIcon =[[UIImageView alloc]initWithFrame:CGRectMake(commentIconMarginLeft*RESIZE_RATIO, infoTop*RESIZE_RATIO, infoIconSize*RESIZE_RATIO, infoIconSize*RESIZE_RATIO)];
        [self.commentIcon setImage:[UIImage imageNamed:@"评论1.png"] ];
        [self addSubview:self.commentIcon];
        
        int const commentTxtMarginLeft = commentIconMarginLeft + infoIconSize + infoIconMarginRight;
        self.comment_count =[[UILabel alloc]initWithFrame:CGRectMake(commentTxtMarginLeft*RESIZE_RATIO, infoTop*RESIZE_RATIO, infoTxtWidth * RESIZE_RATIO, infoTxtFontSize*RESIZE_RATIO)];
        self.comment_count.text = [NSString stringWithFormat:commentPrefix,@"0"];
        self.comment_count.font =  [UIFont boldSystemFontOfSize:infoTxtFontSize*RESIZE_RATIO];
        self.comment_count.textColor = infoFontColor;
        [self addSubview:self.comment_count];
        
        
        int const shareIconMarginLeft = 334;
        self.shareIcon =[[UIImageView alloc]initWithFrame:CGRectMake(shareIconMarginLeft*RESIZE_RATIO, infoTop*RESIZE_RATIO, infoIconSize*RESIZE_RATIO, infoIconSize*RESIZE_RATIO)];
        [self.shareIcon setImage:[UIImage imageNamed:@"转发.png"] ];
        [self addSubview:self.shareIcon];
        
        int const shareTxtMarginLeft = shareIconMarginLeft + infoIconSize + infoIconMarginRight;
        self.share_count =[[UILabel alloc]initWithFrame:CGRectMake(shareTxtMarginLeft*RESIZE_RATIO, infoTop*RESIZE_RATIO, infoTxtWidth * RESIZE_RATIO, infoTxtFontSize*RESIZE_RATIO)];
        self.share_count.text = [NSString stringWithFormat:sharePrefix,@"0"];
        self.share_count.font =  [UIFont boldSystemFontOfSize:infoTxtFontSize*RESIZE_RATIO];
        self.share_count.textColor = infoFontColor;
        [self addSubview:self.share_count];
        
        
        int const favorIconMarginLeft = 496;
        self.favorIcon =[[UIImageView alloc]initWithFrame:CGRectMake(favorIconMarginLeft*RESIZE_RATIO, infoTop*RESIZE_RATIO, infoIconSize*RESIZE_RATIO, infoIconSize*RESIZE_RATIO)];
        [self.favorIcon setImage:[UIImage imageNamed:@"喜欢.png"] ];
        [self addSubview:self.favorIcon];
        
        int const favorTxtMarginLeft = favorIconMarginLeft + infoIconSize + infoIconMarginRight;
        self.favor_count =[[UILabel alloc]initWithFrame:CGRectMake(favorTxtMarginLeft*RESIZE_RATIO, infoTop*RESIZE_RATIO, infoTxtWidth * RESIZE_RATIO, infoTxtFontSize*RESIZE_RATIO)];
        self.favor_count.text = [NSString stringWithFormat:favorPrefix,@"0"];
        self.favor_count.font =  [UIFont boldSystemFontOfSize:infoTxtFontSize*RESIZE_RATIO];
        self.favor_count.textColor = infoFontColor;
        [self addSubview:self.favor_count];
        
    }
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self initConst];
    return self;
}

-(void)setTodayInfo:(DailyModel*) todayModel{
    self.todayModel = todayModel;
    self.todayName.text = todayModel.title;
    [self.todayImage sd_setImageWithURL:[NSURL URLWithString:todayModel.img_url]];
    self.todayTime.text = todayModel.release_date;
    if ( [Tools isBlankString:todayModel.read_count]) {
        todayModel.read_count = @"0";
    }
    if ( [Tools isBlankString:todayModel.comment_count]) {
        todayModel.comment_count = @"0";
    }
    if ( [Tools isBlankString:todayModel.share_count]) {
        todayModel.share_count = @"0";
    }
    if ( [Tools isBlankString:todayModel.favor_count]) {
        todayModel.favor_count = @"0";
    }
    self.read_count.text = [NSString stringWithFormat:readPrefix,todayModel.read_count];
    self.comment_count.text = [NSString stringWithFormat:commentPrefix,todayModel.comment_count];
    self.share_count.text = [NSString stringWithFormat:sharePrefix,todayModel.share_count];
    self.favor_count.text = [NSString stringWithFormat:favorPrefix,todayModel.favor_count];
}

@end
