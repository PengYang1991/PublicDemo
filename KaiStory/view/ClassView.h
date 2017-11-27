//
//  ClassView.h
//  KaiStory
//
//  Created by yangpeng on 15/3/19.
//  Copyright (c) 2015年 yangpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindModel.h"
#import "StoryModel.h"
#import "CategoryModel.h"


@protocol StoryDetailListDelegate <NSObject>
-(void)EnterStoryDetail:(NSArray*)DataSource category:(FindModel *)categorymodel;
-(void)EnterClassList;

-(void)EnterAlbumList:(FindModel *)AlbumModel;

@end

@interface ClassView : UIView{
    NSMutableArray *category;
    NSMutableArray *butArrry;
}

@property (nonatomic,retain)FindModel *findeItem;
@property(strong,nonatomic)NSMutableArray *m_StoryListArray;

-(id)initWithFrameRect:(CGRect)frame dataArray:(NSArray *)data;

@property (nonatomic,assign)id<StoryDetailListDelegate>m_StoryDetailDelegate;

@end
