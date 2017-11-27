//
//  StoryGridView.m
//  KaiStory
//
//  Created by yanzehua on 15/4/16.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "StoryGridView.h"
#import "Tools.h"
#import "UIColor+HexStringToColor.h"
#import "StoryGridCell.h"
#import "FindModel.h"
#import "AudioPlayManager.h"

@implementation StoryGridView

-(void) initLayout
{
   // @property (strong, nonatomic)  UIImageView *leftImgView;
   // @property (strong, nonatomic)  UILabel *leftLabel;
   // @property (strong, nonatomic)  UIImageView *rightImgView;
   // @property (strong, nonatomic)  UILabel *rightLabel;
    
    int const marginTop = 28;
    int const marginLeft = 24;
    int const leftImgHeight = 24;
    int const leftImgWidth = 8;
    self.leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake( marginLeft*RESIZE_RATIO, marginTop*RESIZE_RATIO, leftImgWidth*RESIZE_RATIO, leftImgHeight*RESIZE_RATIO)];
    [self.leftImgView setImage: [UIImage imageNamed:@"标题标注.png"]];
    [self addSubview:self.leftImgView];
    
    
    int const marginLabelLeft = 42;
    int const marginLabelWidth = 300;
    int const marginLabelHeight =  25;
    self.leftLabel = [[UILabel alloc] initWithFrame:CGRectMake( marginLabelLeft*RESIZE_RATIO,marginTop*RESIZE_RATIO, marginLabelWidth*RESIZE_RATIO, marginLabelHeight*RESIZE_RATIO)];
    self.leftLabel.font = [UIFont systemFontOfSize:24*RESIZE_RATIO];
    self.leftLabel.textColor = [UIColor ColorWithHexString:@"4ab19a"];
    self.leftLabel.text = @"凯叔推荐";
    [self addSubview:self.leftLabel];
    
    int const marginLabelFromRight = 90;
    int const rightLabelMarginTop = 34;
    int const rightLabelWidth = 36;
    int const rightLabelHeight = 18;
    self.rightLabel = [[UILabel alloc] initWithFrame:CGRectMake( FRAME_WIDTH -marginLabelFromRight * RESIZE_RATIO,rightLabelMarginTop*RESIZE_RATIO, rightLabelWidth*RESIZE_RATIO, rightLabelHeight*RESIZE_RATIO)];
    self.rightLabel.font = [UIFont systemFontOfSize:18*RESIZE_RATIO];
    self.rightLabel.textColor = [UIColor ColorWithHexString:@"ff8d5b"];
    self.rightLabel.text = @"更多";
    [self addSubview:self.rightLabel];
    
    int const marginImgFromRight = 53;
    int const marginRightImgWidth = 10;
    int const marginRightImgHeight = 18;
    self.rightImgView = [[UIImageView alloc] initWithFrame:CGRectMake( FRAME_WIDTH -marginImgFromRight* RESIZE_RATIO, rightLabelMarginTop*RESIZE_RATIO, marginRightImgWidth*RESIZE_RATIO, marginRightImgHeight*RESIZE_RATIO)];
    [self.rightImgView setImage: [UIImage imageNamed:@"更多箭头.png"]];
    [self addSubview:self.rightImgView];
    
    self.rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(FRAME_WIDTH -marginLabelFromRight* RESIZE_RATIO, (marginRightImgWidth-7)* RESIZE_RATIO, (rightLabelWidth+50)* RESIZE_RATIO, (rightLabelHeight+50)* RESIZE_RATIO)];
//    [self.rightBtn setBackgroundColor:[UIColor blackColor]];
//    [self.rightBtn addTarget:self action:@selector(RightClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.rightBtn];

}


-(void)initStoryCell :(NSMutableArray*)storyItemArray
{
    UIColor *oldColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
    UIImage* maskImg = [Tools replaceColor:oldColor withColor:[UIColor ColorWithHexString:self.bgColorStr] inImage:[UIImage imageNamed:@"蒙版.png"]];

    
    self.storyGridCellArray = [NSMutableArray array];
    for(int row = 0; row <= 1; row++)
    {
        for(int col = 0; col <= 2; col++)
        {
            int coverImgSize = 149;
            int marginLeft = 10 + 43*(col+1) + col*149;
            int marginTop = (28+24+28) + 149*row ;
            if(row > 0)
                marginTop += 70;
            
            StoryModel* storyItem = storyItemArray[row*3+col];
            StoryGridCell* storyCellView = [[StoryGridCell alloc] initWithFrame:CGRectMake(marginLeft* RESIZE_RATIO, marginTop*RESIZE_RATIO, coverImgSize*RESIZE_RATIO, coverImgSize*RESIZE_RATIO) withStoryItem: storyItem withMaskImg: maskImg];
            [self.storyGridCellArray addObject:storyCellView];
            [self addSubview:storyCellView];
            
            int titleHeight = 20;
            int titleMarginTop = marginTop+ coverImgSize + 12;
            
            UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(marginLeft* RESIZE_RATIO,titleMarginTop*RESIZE_RATIO,
                                                                        coverImgSize*RESIZE_RATIO, titleHeight*RESIZE_RATIO)];
            titleLabel.font = [UIFont systemFontOfSize:20*RESIZE_RATIO];
            titleLabel.textColor = [UIColor ColorWithHexString:@"4ab19a"];
            titleLabel.text = storyItem.name;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:titleLabel];
            
            int playCountHeight = 14;
            int playCountMarginTop = titleMarginTop + titleHeight + 8;
            int playCountMarginLeft = marginLeft + 60;
            int playCountWidth = 50;
            UILabel* playCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(playCountMarginLeft* RESIZE_RATIO,playCountMarginTop*RESIZE_RATIO,playCountWidth*RESIZE_RATIO, playCountHeight*RESIZE_RATIO)];
            playCountLabel.font = [UIFont systemFontOfSize:14*RESIZE_RATIO];
            playCountLabel.textColor = [UIColor ColorWithHexString:@"99d5c8"];
            playCountLabel.text = @"10.7万";
            [self addSubview:playCountLabel];
            
            int playIconHeight = 10;
            int playIconMarginTop = playCountMarginTop + 2;
            int playIconMarginLeft = marginLeft + 50;
            int playIconSize = 10;
            UIImageView* playIconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(playIconMarginLeft* RESIZE_RATIO, playIconMarginTop*RESIZE_RATIO, playIconSize*RESIZE_RATIO, playIconHeight*RESIZE_RATIO)];
            [playIconImgView setImage:[UIImage imageNamed:@"播放小.png"]];
            [self addSubview:playIconImgView];
        }
    }
    
    self.titleViewArray = [NSMutableArray arrayWithCapacity:6];
    self.playCountViewArray = [NSMutableArray arrayWithCapacity:6];
    self.playCountLabelArray = [NSMutableArray arrayWithCapacity:6];
}

-(void)updateCellView:(NSNotification *)notification
{
    [self updateState];
}

-(void)updateState
{
    if(nil != [AudioPlayManager sharedManager].currentPlayItem)
    {
        NSInteger storyId = [[AudioPlayManager sharedManager].currentPlayItem.story.m_id integerValue];
        BOOL isPlayFlag =[AudioPlayManager sharedManager].currentPlayItem.isPlay;
        for (int i=0; i< 6; i++ ) {
            [[self.storyGridCellArray objectAtIndex:i] updatePlayBtnState:storyId isPlay:isPlayFlag];
        }
    }
}

-(void)regObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self
    selector:@selector(updateCellView:)  name:@"CURRENT_PLAY_ID" object:nil];
}

-(void) unRegObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (id)initWithFrameRect:(CGRect)frame color:(NSString*)color story:(NSMutableArray *)arr sort:(NSMutableArray*)sortArray
{
    if ((self = [super initWithFrame:frame])) {
        self.bgColorStr = color;
        self.backgroundColor = [UIColor ColorWithHexString:self.bgColorStr];
        
        [self initLayout];
        [self initStoryCell: sortArray];
        self.m_sortArray = [NSMutableArray array];
        self.m_sortArray =arr;
        StoryItem* storyItem =[self.m_sortArray objectAtIndex:0];
        self.leftLabel.text = [storyItem.left_item objectForKey:@"text"];
    }
    
    return self;
}

@end
