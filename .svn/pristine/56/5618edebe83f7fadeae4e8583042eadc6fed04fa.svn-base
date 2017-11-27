//
//  StoryView.h
//  KaiStory
//
//  Created by yangpeng on 15/3/19.
//  Copyright (c) 2015年 yangpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindModel.h"
#import "CategoryModel.h"
#import "StoryModel.h"



@protocol StoryDetailListDelegate <NSObject>
-(void)EnterStoryDetail:(NSArray*)DataSource category:(CategoryModel *)categorymodel;
@end


@interface StoryView : UIView{

StoryView *stroyView;



}

@property (weak, nonatomic) IBOutlet UIView *storyViews;

//zuozhe
@property (weak, nonatomic) IBOutlet UILabel *oneLable;
@property (weak, nonatomic) IBOutlet UILabel *twoLable;
@property (weak, nonatomic) IBOutlet UILabel *threeLable;
@property (weak, nonatomic) IBOutlet UILabel *fourLable;
@property (weak, nonatomic) IBOutlet UILabel *fiveLable;
@property (weak, nonatomic) IBOutlet UILabel *sixLable;
//shuliang

@property (weak, nonatomic) IBOutlet UILabel *oneCount;
@property (weak, nonatomic) IBOutlet UILabel *twoCount;
@property (weak, nonatomic) IBOutlet UILabel *threeCount;
@property (weak, nonatomic) IBOutlet UILabel *fourCount;
@property (weak, nonatomic) IBOutlet UILabel *fiveCount;

@property (weak, nonatomic) IBOutlet UILabel *sixCount;

@property (weak, nonatomic) IBOutlet UILabel *recommend;

@property (weak, nonatomic) IBOutlet UILabel *moreLable;

@property (weak, nonatomic) IBOutlet UIImageView *storyOne;

@property (weak, nonatomic) IBOutlet UIImageView *storyTwo;

@property (weak, nonatomic) IBOutlet UIImageView *storyThree;

@property (weak, nonatomic) IBOutlet UIImageView *storyFour;

@property (weak, nonatomic) IBOutlet UIImageView *storyFive;

@property (weak, nonatomic) IBOutlet UIImageView *storySix;

@property (nonatomic,strong)NSMutableArray *sortlist;  //故事列表

@property (nonatomic,strong)NSMutableArray *storyList; //left 。right

@property(nonatomic,strong)StoryItem *storyItem;

@property(nonatomic,strong)StoryModel *sortModel;


@property(nonatomic,strong)NSMutableArray *m_StoryListArray;

- (IBAction)playButton:(id)sender;

@property (nonatomic,assign)id<StoryDetailListDelegate>m_StoryDetailDelegate;

-(id)initWithFrame:(CGRect)frame color:(NSString*)color story:(NSMutableArray *)arr sort:(NSMutableArray*)sort ;

@end
