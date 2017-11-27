//
//  CategoryViewController.h
//  KaiStory
//
//  Created by mac on 15/3/31.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "BaseViewContr.h"
#import "EGORefreshTableHeaderView.h"
#import "DailyCellView.h"
#import "TodayDailyView.h"
#import "CategoryCellCollectionViewCell.h"
//#import "ShopController.h"
@interface CategoryViewController : BaseViewContr<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,EGORefreshTableFooterDelegate,EGORefreshTableHeaderDelegate,seletecellDelgate>{

    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _refreshHeaderFlag;
    EGORefreshTableFooterView *_refreshFooterView;
    BOOL _refreshFooterFlag;
    UIButton * searchBt;
    NSInteger tags;
    UIView *searchview;
    UIImageView *imageview;
    NSArray *butarrary;
    UIButton * paxubt ;
    NSMutableSet *set;
    NSInteger totalTime;
}

@property (strong,nonatomic)NSMutableArray *selectIndex;

@property(strong,nonatomic)UICollectionView *m_CollectionView;
@property(strong,nonatomic)NSMutableArray *m_dataSource;
///
@property(nonatomic,assign)int currentPage;
@property(nonatomic,assign)BOOL hasMore;
@property(nonatomic,assign)NSDate* lastUpdateDate;
@property(nonatomic,strong)NSMutableArray *m_dayArray;
@property(nonatomic,strong)DailyModel *todayModel;
@property(nonatomic,strong)NSMutableArray *m_DataArray;
@property(nonatomic,strong)TodayDailyView *todayDaily;
@property(strong,nonatomic)UITableView *tableView;
@property (strong,nonatomic)UIButton *oldbutton;
//@property (nonatomic,strong)ShopController *shopcontro;
-(void) setHeaderView;
-(void) setFooterView;

@end
