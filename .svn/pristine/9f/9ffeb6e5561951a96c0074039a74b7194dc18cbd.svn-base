//
//  BabyHistoryController.h
//  KaiStory
//
//  Created by yanzehua on 15/5/1.
//  Copyright (c) 2015年 kaishu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewContr.h"
#import "EGORefreshTableHeaderView.h"
#import "ContextMenuView.h"

@interface BabyHistoryController : BaseViewContr<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate,EGORefreshTableFooterDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _refreshHeaderFlag;
    EGORefreshTableFooterView *_refreshFooterView;
    BOOL _refreshFooterFlag;
}

@property(assign,nonatomic) NSInteger pageCount;

@property(nonatomic,assign)int currentPage;

@property(strong,nonatomic)UITableView* tableView;

@property(nonatomic)BOOL hasMore;
@property(nonatomic)NSDate* lastUpdateDate;
@property(nonatomic,strong)ContextMenuView* menuView;

@end
