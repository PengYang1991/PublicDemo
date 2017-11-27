//
//  KSStoryListController.h
//  KaiStory
//
//  Created by yanzehua on 15/5/8.
//  Copyright (c) 2015年 kaishu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewContr.h"
#import "EGORefreshTableHeaderView.h"
#import "ContextMenuView.h"

@interface KSStoryListController : BaseViewContr<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate,EGORefreshTableFooterDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _refreshHeaderFlag;
    EGORefreshTableFooterView *_refreshFooterView;
    BOOL _refreshFooterFlag;
}

@property(strong,nonatomic)UIButton* listBtn;

@property(assign,nonatomic) NSInteger pageCount;

@property(nonatomic,assign)int currentPage;

@property(strong,nonatomic)UITableView* tableView;

@property(nonatomic)BOOL hasMore;
@property(nonatomic)NSDate* lastUpdateDate;
@property(nonatomic,strong)NSMutableArray *m_DataArray;

@property(nonatomic,strong)ContextMenuView* menuView;

@property(nonatomic,strong) NSString* requestUrl;
@property(nonatomic,strong) NSString* requestParams;
@property(nonatomic,strong) NSString* categoryIDStr;
@end
