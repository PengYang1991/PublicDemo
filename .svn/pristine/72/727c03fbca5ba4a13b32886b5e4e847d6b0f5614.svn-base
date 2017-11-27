//
//  CustomController.h
//  KaiStory
//
//  Created by mac on 15/2/6.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewContr.h"
#import "EGORefreshTableHeaderView.h"
#import "DailyModel.h"
#import "TodayDailyView.h"
typedef void(^pulldouwnFinishblock)(void);
@interface CustomController : BaseViewContr<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate,EGORefreshTableFooterDelegate>{

    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _refreshHeaderFlag;
    EGORefreshTableFooterView *_refreshFooterView;
    BOOL _refreshFooterFlag;
}

@property(nonatomic,assign)int currentPage;
@property(nonatomic,assign)BOOL hasMore;
@property(nonatomic,assign)NSDate* lastUpdateDate;
@property(nonatomic,strong)NSMutableArray *m_dayArray;
@property(nonatomic,strong)DailyModel *todayModel;
@property(nonatomic,strong)NSMutableArray *m_DataArray;
@property(nonatomic,strong)TodayDailyView *todayDaily;
@property(strong,nonatomic)UITableView *tableView;


-(void) setHeaderView;
-(void) setFooterView;

-(void) loadFirstPageFromDB;
-(void) loadPage:(int) pageIndex;

@end
