//
//  BabyHistoryController.m
//  KaiStory
//
//  Created by yanzehua on 15/5/1.
//  Copyright (c) 2015年 kaishu. All rights reserved.
//

#import "BabyHistoryController.h"
#import "Tools.h"
#import "UIColor+HexStringToColor.h"
#import "UIImageView+WebCache.h"
#import "UserShareInfo.h"
#import "LoveStoryCell.h"
#import "AudioPlayManager.h"
#import "AudioPlayItem.h"
#import "LoveDailyCell.h"
#import "DailyModel.h"
#import "StoryDetailController.h"


@implementation BabyHistoryController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageCount = 4;
     [self.baseContentView setBackgroundColor:[UIColor ColorWithHexString:@"e2f2ee"]];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, FRAME_WIDTH,[self getContentHeight]) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    static NSString *StoryCellIde = @"HistoryStoryCell";
    [self.tableView registerClass:[LoveStoryCell class] forCellReuseIdentifier:StoryCellIde];
    [self.baseContentView addSubview:self.tableView];
    
    self.currentPage = 0;
    [self setHeaderView];
    [self setFooterView];
    
   }

- (void)setHeaderView{
    //创建下拉刷新的控件
    //该下拉控件被添加在tableView的不可见区域内
    _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.tableView.frame.size.width, self.tableView.bounds.size.height)];
    NSLog(@"HEAD VIEW WIDTH %f",  self.tableView.bounds.size.width);
    NSLog(@"HEAD VIEW HEIGHT %f",  self.tableView.bounds.size.height);
    
    [_refreshHeaderView setDelegate:self];
    _refreshHeaderView.backgroundColor = [UIColor blueColor];
    [_refreshHeaderView refreshLastUpdatedDate];
    [self.tableView addSubview:_refreshHeaderView];
}

- (void) setFooterView
{
    CGFloat tableMaxHeight = MAX(self.tableView.contentSize.height, self.tableView.frame.size.height);
    if(_refreshFooterView)
    {
        _refreshFooterView.frame = CGRectMake(0.0f,
                                              tableMaxHeight,
                                              _tableView.frame.size.width,
                                              self.view.bounds.size.height);
    }
    else
    {
        _refreshFooterView =[[EGORefreshTableFooterView alloc] initWithFrame:CGRectMake(0.0f, 0.0f + tableMaxHeight, self.tableView.frame.size.width, self.tableView.bounds.size.height)];
        [_refreshFooterView setDelegate:self];
        _refreshFooterView.backgroundColor = [UIColor blueColor];
        [_refreshFooterView refreshLastUpdatedDate];
        [self.tableView addSubview:_refreshFooterView];
    }
}

//开始加载数据时候调用
- (void)reloadTableHeaderDataSource{
    _refreshHeaderFlag = YES;
    if(self.currentPage > 0)
    {
        self.currentPage -= 1;
        [self.tableView reloadData];
    }

}
//当数据加载完成后调用
- (void)doneLoadingTableHeaderData{
    _refreshHeaderFlag = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}

#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    [_refreshFooterView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    [_refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma 下拉刷新协议方法
//下拉到一定距离，手指放开时调用
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    //请求刷新数据
    [self reloadTableHeaderDataSource];
    [self performSelector:@selector(doneLoadingTableHeaderData) withObject:nil afterDelay:3.0];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    return _refreshHeaderFlag;
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    return [NSDate date]; // should return date data source was last changed
}

//开始加载数据时候调用
- (void)reloadTableFooterDataSource{
    _refreshFooterFlag = YES;

        NSInteger totalCount = [[UserShareInfo sharedSingleton].historyList count];
        if((self.currentPage+1)*self.pageCount <  totalCount)
        {
            self.currentPage +=1;
            [self.tableView reloadData];
        }
        
    
    
}
//当数据加载完成后调用
- (void)doneLoadingTableFooterData{
    _refreshFooterFlag = NO;
    [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}

- (void)egoRefreshTableFooterDidTriggerRefresh:(EGORefreshTableFooterView*)view{
    //请求刷新数据
    [self reloadTableFooterDataSource];
    [self performSelector:@selector(doneLoadingTableFooterData) withObject:nil afterDelay:3.0];
}

- (BOOL)egoRefreshTableFooterDataSourceIsLoading:(EGORefreshTableFooterView*)view{
    return _refreshFooterFlag;
}

- (NSDate*)egoRefreshTableFooterDataSourceLastUpdated:(EGORefreshTableFooterView*)view{
    return [NSDate date]; // should return date data source was last changed
}
-(void)updateState:(NSNotification*)notification
{
    //当有播放状态改变时，直接更新当前数据。
    [self.tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateState:)  name:@"CURRENT_PLAY_ID" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma UItableview代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

        NSInteger totalCount = [[UserShareInfo sharedSingleton].historyList count];
        NSInteger remainCount = totalCount - self.currentPage * self.pageCount;
        if(remainCount > self.pageCount)
            return self.pageCount;
        else
            return remainCount;
   }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        NSInteger index = indexPath.row;
 
        static NSString *StoryCellIde = @"HistoryStoryCell";
        LoveStoryCell *cell = [tableView dequeueReusableCellWithIdentifier:StoryCellIde];
        if (cell ==nil | cell.mainLabel ==nil) {
            cell = [[LoveStoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:StoryCellIde];
            [cell setFrame:CGRectMake(0, 0, FRAME_WIDTH, 178*RESIZE_RATIO)];
            [cell initLayout:CGRectMake(0, 0, FRAME_WIDTH, 178*RESIZE_RATIO)];
        }
        NSString* storyId = [[UserShareInfo sharedSingleton].historyList objectAtIndex:self.currentPage*self.pageCount + index];
    
        StoryModel *model =  [Tools getStoryItem:storyId];
        [cell setModel:model];
        [cell.optionBtn addTarget:self action:@selector(optionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.optionBtnExtA addTarget:self action:@selector(optionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
        [cell.optionBtn setTag:index];
        [cell.optionBtnExtA setTag:index];
      
    
        AudioPlayItem* playItem = [AudioPlayManager sharedManager].currentPlayItem;
        if(nil != playItem)
        {
            NSInteger storyId =[playItem.story.m_id integerValue];
            if([model.m_id integerValue] == storyId && playItem.isPlay)
            {
                cell.playBtn.selected = YES;
            }else
            {
                cell.playBtn.selected = NO;
            }
        }
        return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    NSString* storyId = [[UserShareInfo sharedSingleton].historyList objectAtIndex:self.currentPage*self.pageCount + index];
    
    StoryModel *model =  [Tools getStoryItem:storyId];
    StoryDetailController *StoryDetail = [[StoryDetailController alloc]initWithConfig:model.name withBackBtn:YES withFootBar:YES];
    StoryDetail.storyItem = model;
    [self presentViewController:StoryDetail animated:YES completion:^{
    }];
   
}

-(void)optionBtnClick:(id)sender
{
    NSInteger index = [sender tag];
    NSLog(@"Get item at index %d",index);
    NSArray* btnLabelArray = [[NSArray alloc]initWithObjects:@"加入播放列表",@"删除",nil];
    self.menuView = [[ContextMenuView alloc] initWithFrameRect:CGRectMake(0, 0, FRAME_WIDTH, FRAME_HEIGHT) withLabelArray:btnLabelArray];

    [self.menuView setItemIndex:index];
    [[self.menuView.btnArray objectAtIndex:0] addTarget:self action:@selector(addToPlayList:) forControlEvents:UIControlEventTouchUpInside];
    [[self.menuView.btnArray objectAtIndex:1] addTarget:self action:@selector(delItem:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.menuView];
}

-(void)addToPlayList:(id)sender
{
    NSLog(@"addToPlayList");
    NSUInteger indexAtList = self.currentPage*self.pageCount + self.menuView.index;
    if([[UserShareInfo sharedSingleton].historyList count] > indexAtList)
    {
        NSString* storyId = [[UserShareInfo sharedSingleton].historyList objectAtIndex:indexAtList];
        StoryModel *model =  [Tools getStoryItem:storyId];
        [[AudioPlayManager sharedManager] addToPlayList:model];
    }
}
-(void)delItem:(id)sender
{
    NSLog(@"delItem");
    NSUInteger indexAtList = self.currentPage*self.pageCount + self.menuView.index;
    if([[UserShareInfo sharedSingleton].historyList count] > indexAtList)
    {
        [[UserShareInfo sharedSingleton] removeFromHistoryList:indexAtList];
    
        // 如果不足一页的时候，进行补充处理
        NSInteger totalCount = [[UserShareInfo sharedSingleton].historyList count];
        if((self.currentPage)*self.pageCount >=  totalCount)
        {
            self.currentPage -= 1;
            if(self.currentPage < 0)
            {
                self.currentPage = 0;
            }
        }
        [self.tableView reloadData];
    }
    [self.menuView removeFromSuperview];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 178 * RESIZE_RATIO;
}

-(void)backBtnAction:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^(){}];
}



@end
