//
//  StoryCell.m
//  KaiStory
//
//  Created by mac on 15/3/31.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "StoryCell.h"
#import "Tools.h"
#import "UIColor+HexStringToColor.h"
#import "UIImageView+AFNetworking.h"
#import "AudioPlayManager.h"

@implementation StoryCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)initLayout:(CGRect)frame
{
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        int const marginLeft = 10;
        int const marginRight = 20;
        
        // 头图的图像区域
        int const imgMarginTop = 5;
        int const imgWidth = 170;
        int const imgHeight = 170;
        self.bannerIcon =[[UIImageView alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO, imgMarginTop*RESIZE_RATIO, imgWidth*RESIZE_RATIO, imgHeight*RESIZE_RATIO)];
        int const playBtnWidth =92;
        int const PlayBtnleft =self.bannerIcon.frame.origin.x+imgWidth-6-playBtnWidth;
        int const playBtnTop = self.bannerIcon.frame.origin.y+imgHeight-4-playBtnWidth;
        self.playBtn = [[UIButton alloc]initWithFrame:CGRectMake(PlayBtnleft*RESIZE_RATIO, playBtnTop*RESIZE_RATIO, playBtnWidth*RESIZE_RATIO, playBtnWidth*RESIZE_RATIO)];
        [self.playBtn setImage:[UIImage imageNamed:@"故事详情页-播放.png"] forState:UIControlStateNormal];
        [self.playBtn setImage:[UIImage imageNamed:@"故事详情页-暂停.png"] forState:UIControlStateSelected];
        [self.playBtn addTarget:self action:@selector(PlayStory:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.bannerIcon addSubview:self.playBtn];
        self.bannerIcon.userInteractionEnabled = YES;
        
        
        [self addSubview:self.bannerIcon];
        // 标题区域
        int const titleMarginLeft = marginLeft + imgWidth + 44;
        int const titleFontSize = 28;
        int const titleHeight = 80;
        int const titlewidth = 180;
        int const titleTop = 40;
        NSString *titleFontColor = @"656565";
        self.albumName =[[UILabel alloc]initWithFrame:CGRectMake(titleMarginLeft*RESIZE_RATIO, titleTop*RESIZE_RATIO, titlewidth*RESIZE_RATIO, titleHeight*RESIZE_RATIO)];
        self.albumName.font =  [UIFont boldSystemFontOfSize:titleFontSize*RESIZE_RATIO];
        self.albumName.numberOfLines = 2;
        self.albumName.lineBreakMode = UILineBreakModeWordWrap;
        UIColor *todayNameColor = [UIColor ColorWithHexString:titleFontColor];
        self.albumName.textColor = todayNameColor;
        [self addSubview:self.albumName];
        
        int const playIconleft =titleMarginLeft;
        int const playIconTop = titleTop+titleHeight+10;
        int playIconHeight =13;
        self.playIcon =[[UIImageView alloc]initWithFrame:CGRectMake(playIconleft*RESIZE_RATIO, playIconTop*RESIZE_RATIO, playIconHeight*RESIZE_RATIO, playIconHeight*RESIZE_RATIO)];
        [self.playIcon setImage:[UIImage imageNamed:@"播放量.png"]];
        [self addSubview:self.playIcon];
        
        int const playCountleft =playIconleft+playIconHeight+10;
        int const playCountTop =playIconTop-10;
        int const playCountWidth =60;
        int const playCountHeight = 30;
        self.playCount = [[UILabel alloc]initWithFrame:CGRectMake(playCountleft*RESIZE_RATIO, playCountTop*RESIZE_RATIO, playCountWidth*RESIZE_RATIO, playCountHeight*RESIZE_RATIO)];
        self.playCount.font = [UIFont systemFontOfSize:8];
        [self addSubview:self.playCount];
        
        int const favorIconleft =playCountleft+playCountWidth+10;
        int const favorIconTop =playIconTop;
        int const favorWidth =13;
        self.favorIcon = [[UIImageView alloc]initWithFrame:CGRectMake(favorIconleft*RESIZE_RATIO, favorIconTop*RESIZE_RATIO, favorWidth*RESIZE_RATIO, favorWidth*RESIZE_RATIO)];
        [self.favorIcon setImage:[UIImage imageNamed:@"搜藏量.png"]];
        [self addSubview:self.favorIcon];
        
        int const favorCountleft=favorIconleft+favorWidth+10;
        int const favorCountTop=playIconTop-10;
        int const favorCountWidth=60;
        int const favorCountHeight =30;
        self.favCount = [[UILabel alloc]initWithFrame:CGRectMake(favorCountleft*RESIZE_RATIO, favorCountTop*RESIZE_RATIO, favorCountWidth*RESIZE_RATIO, favorCountHeight*RESIZE_RATIO)];
        self.favCount.font = [UIFont systemFontOfSize:8];
        [self addSubview:self.favCount];
        
        int const TotalCountleft =favorCountleft+favorCountWidth+10;
        int const TotalCounttop =favorCountTop;
        int const TotalCountWidth = 60;
        int const TotalCountHeight = 30;
        
        self.TotalCount =[[UILabel alloc]initWithFrame:CGRectMake(TotalCountleft*RESIZE_RATIO, TotalCounttop*RESIZE_RATIO, TotalCountWidth*RESIZE_RATIO, TotalCountHeight*RESIZE_RATIO)];
        self.TotalCount.font = [UIFont systemFontOfSize:8];
        [self addSubview:self.TotalCount];
        
        
        int const collectBtnwidth =46;
        int const collectBtnHeight =10;
        //        int const collectBtnleft = TotalCountleft+80;
        int const collectBtnleft = 570;
        
        
        int const collectTop =80;
        
        UIImageView *BtnView = [[UIImageView alloc]initWithFrame:CGRectMake((collectBtnleft-30)*RESIZE_RATIO, (collectTop-20)*RESIZE_RATIO, (collectBtnwidth+60)*RESIZE_RATIO, (collectBtnHeight+40)*RESIZE_RATIO)];
//        [BtnView setBackgroundColor:[UIColor redColor]];
        [self addSubview:BtnView];
        BtnView.userInteractionEnabled = YES;
        
        self.CollectBtn =[[UIButton alloc]initWithFrame:CGRectMake(collectBtnleft*RESIZE_RATIO, collectTop*RESIZE_RATIO, collectBtnwidth*RESIZE_RATIO, collectBtnHeight*RESIZE_RATIO)];
        
        [self.CollectBtn addTarget:self action:@selector(MoreAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.CollectBtn setImage:[UIImage imageNamed:@"更多.png"] forState:UIControlStateNormal];
        [self.CollectBtn setImage:[UIImage imageNamed:@"更多.png"] forState:UIControlStateSelected];
        [self addSubview:self.CollectBtn];
        
    }
    
}
-(void)SetCellData:(StoryModel*)story
{
    
    self.albumName.text =story.name;
    NSString *playcont =[NSString stringWithFormat:@"%@+",story.play_count];
    self.playCount.text = playcont;
    NSString *favcount =[NSString stringWithFormat:@"%@+",story.favor_count];
    
    self.favCount.text =favcount;
    self.TotalCount.text = story.duration;
    [self.bannerIcon setImageWithURL:[NSURL URLWithString:story.icon_url]];
    self.currentStory  = story;
    
}
-(void)PlayStory:(id)sender
{
    /*
    UIButton *btn =(UIButton *)sender;
    btn.selected = !btn.selected;
    if (btn.selected)
    {
        int storyId = [self.currentStory.m_id intValue];
        [PlayShare sharedSingleton].currentStoryId = storyId;
        NSLog(@"Story id is %d",storyId);
        NSLog(@"Current Story change to %d",[PlayShare sharedSingleton].currentStoryId);
        [[AudioPlayManager sharedManager] playAItem:self.currentStory addToListOrNot:YES];
    }else{
        [[AudioPlayManager sharedManager] pause];
    }*/
}

-(void)MoreAction:(id)sender
{
    UIButton *btn =(UIButton *)sender;
    btn.selected = !btn.selected;
    if (btn.selected) {
        
    }else{
        
    }
}
@end
