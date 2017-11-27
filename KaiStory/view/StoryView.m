//
//  StoryView.m
//  KaiStory
//
//  Created by yangepng on 15/3/19.
//  Copyright (c) 2015年 yangepng. All rights reserved.
//

#import "StoryView.h"
#import "Tools.h"
#import "UIColor+HexStringToColor.h"
#import "LoginDataService.h"
#import "UIImageView+AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "StoryModel.h"
#import "BaseNavigationContr.h"
#import "CategoryModel.h"
@implementation StoryView

-(id)initWithFrame:(CGRect)frame color:(NSString*)color story:(NSMutableArray *)arr sort:(NSMutableArray*)sort ;
{
    if ((self = [super initWithFrame:frame])) {
        
        stroyView = [[[NSBundle mainBundle]loadNibNamed:@"StoryView" owner:self options:nil]lastObject];
        stroyView.frame = CGRectMake((self.bounds.size.width-333)/2, 0, 333, StoryHeight);
//        stroyView.backgroundColor = [UIColor ColorWithHexString:color];
        NSLog(@"fra_______==%f",self.bounds.size.width);
        
        [self addSubview:stroyView];
        self.storyList = arr;
        self.sortlist = sort;

        [self creatSortList];
                    }
    
    self.m_StoryListArray = [NSMutableArray array];
    
    return self;
    
}
#pragma Lable 触摸事件
- (void)creatSortList{
    
    UITapGestureRecognizer *tab = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tabAction:)];
    
    [self.moreLable  addGestureRecognizer:tab];
    self.moreLable.userInteractionEnabled = YES;
    self.moreLable.text = @"yzh";
    NSLog(@"MORELABEL %f %f",self.frame.origin.y, self.frame.size.height);
   NSLog(@"MORELABEL %f %f",self.moreLable.bounds.origin.y, self.moreLable.bounds.size.height);
    //[self.moreLable setFrame :CGRectMake(0, 375, 100, 100)];
    NSLog(@"MORELABEL %f %f",self.moreLable.frame.origin.y, self.moreLable.frame.size.height);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapActions:)];
    self.recommend.userInteractionEnabled = YES;
    [self.recommend addGestureRecognizer:tap];
    NSArray *arrary = @[self.storyOne,self.storyTwo,self.storyThree,self.storyFour,self.storyFive,self.storySix];
    NSArray *lableArrary = @[self.oneLable,self.twoLable,self.threeLable,self.fourLable , self.fiveLable,self.sixLable];
    
    NSArray *countArrary = @[self.oneCount,self.twoCount,self.threeCount,self.fourCount,self.fiveCount,self.sixCount];
    for (NSInteger i=0; i<arrary.count; i++) {
        
        self.sortModel = [self.sortlist objectAtIndex:i];
        UIImageView *imageview = [arrary objectAtIndex:i];
        NSString *iconUrl = self.sortModel.icon_url;
//        [imageview setImageWithURL:[NSURL URLWithString:iconUrl]];
        [imageview sd_setImageWithURL:[NSURL URLWithString:iconUrl]];
        
        UILabel *lab = [lableArrary objectAtIndex:i];
        lab.text = self.sortModel.author;
        
        UILabel *count = [countArrary objectAtIndex:i];
    
//        count.text = self.sortModel.play_count;
        
     }

}
- (void)tabAction:(id)sender{

    [self LoadData];
    
    NSLog(@"DataSource======%lu",(unsigned long)self.m_StoryListArray.count);
    
    
   

}

-(void)LoadData{
    NSLog(@"触摸了");
    
    NSLog(@"se=============%lu,fs==============%lu",(unsigned long)self.storyList.count,(unsigned long)self.sortlist.count);
    
    self.storyItem = [self.storyList firstObject];
    NSDictionary *dic = self.storyItem.right_item;
    NSString *urlstring = [dic objectForKey:@"open_url"];
    NSString *rightText = [dic objectForKey:@"text"];
    NSDictionary *leftDic = self.storyItem.left_item;
    self.recommend.text = [leftDic objectForKey:@"text"];
    self.moreLable.text = rightText;
    NSString *method = [dic objectForKey:@"open_method"];
    //  NSString *params = [dic objectForKey:@"open_params"];
    NSLog(@"jsdfks==%@",method);
    
    if (![urlstring isEqualToString:@""]) {
        
    }else{
        [LoginDataService requestAFURL1:urlstring httpMethod:@"GET" params:nil data:nil complection:^(id result) {
            NSLog(@"___________resut==%@",result);
            NSDictionary *Result = result[@"result"];
            NSString *verson = [Result objectForKey:@"version"];
            NSLog(@"verson=====%@",verson);
            NSDictionary *view_content = [Result objectForKey:@"view_content"];
            NSLog(@"view_content======%@",view_content);
            NSDictionary *showData= [view_content objectForKey:@"show_data"];
            NSLog(@"showData========%@",showData);
            NSDictionary *category= [showData objectForKey:@"category"];
            
            CategoryModel *categorymodel = [[CategoryModel alloc]initWithDict:category];
            
            NSLog(@"Category=====%@",categorymodel);
            NSLog(@"Category=====%@",categorymodel.banner_url);
            NSDictionary *mediaList = [showData objectForKey:@"media_list"];
            NSLog(@"mediaList=====%@",mediaList);
            NSArray *DataList = [showData objectForKey:@"media_list"];
            NSLog(@"mediaList=====%@",DataList);
            for (NSDictionary * dic in DataList) {
                StoryModel *model = [[StoryModel alloc]initWithDict:dic];
                [self.m_StoryListArray addObject:model];
            }
            
            [self.m_StoryDetailDelegate EnterStoryDetail:self.m_StoryListArray category:categorymodel];
        }];
 
    }
    
}
-(void)tapActions:(id)sender{

    NSLog(@"触摸2");



}
//播放方法
- (IBAction)playButton:(id)sender {
    if ([sender isKindOfClass:[UIButton class]]) {
        
        UIButton *btn = sender;
        NSInteger i = btn.tag-1000;
        self.sortModel = [self.sortlist objectAtIndex:i];
        NSString *media_url = self.sortModel.media_url;
//        self.sortModel.product_id = @"2";
        NSLog(@"_______media-URL===%@",self.sortModel.m_id);
        
    }
    
    //[[PlayShare sharedSingleton]PlayNetStory:self.sortModel :nil];

//    NSLog(@"开始播放======%@",playContr.story.media_url);

}
@end
