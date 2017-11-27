//
//  PlayerListView.h
//  KaiStory
//
//  Created by yanzehua on 15/4/24.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@interface PlayerListView : UIView <UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate,EGORefreshTableFooterDelegate>{
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _refreshHeaderFlag;
    EGORefreshTableFooterView *_refreshFooterView;
    BOOL _refreshFooterFlag;
}

@property(assign,nonatomic) NSInteger pageCount;
@property(strong,nonatomic)UITableView *tableView;
@property(nonatomic,assign)int currentPage;

-(void) setHeaderView;
-(void) setFooterView;

-(void) regObserver;
-(void) unRegObserver;

@end
