//
//  albumViewController.h
//  KaiStory
//
//  Created by yangpeng on 15/4/10.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumeModel.h"
#import "BaseViewContr.h"
#import "FindModel.h"

#import "EGORefreshTableHeaderView.h"

typedef void(^pulldouwnFinishblock)(void);


@interface albumViewController : BaseViewContr<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate,EGORefreshTableFooterDelegate>{

    UITableView *_albumTableView;
    NSMutableArray *dataArrary;
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _refreshHeaderFlag;
    EGORefreshTableFooterView *_refreshFooterView;
    BOOL _refreshFooterFlag;
    
}
@property(nonatomic,retain)AlbumeModel *sortItem;

@property(nonatomic,strong)FindModel *albumModel;
@property(nonatomic,assign)NSInteger currentPage;
@property(assign,nonatomic)BOOL hasMore;
@property(nonatomic,assign)NSDate *lastUpdateDate;




- (void)setaldume:(NSArray*)sortmodel;
-(void)setHeaderView;
-(void)setFooterView;

-(void)loadFirstPageFromDB;
-(void)loadPage:(NSInteger)pageIndex;
-(void) updateData: (id)result AtPageIndex:(NSInteger)pageIndex;
-(NSMutableArray*) parseFromResult:(id)result;

@end
