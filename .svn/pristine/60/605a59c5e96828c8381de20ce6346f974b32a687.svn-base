//
//  BabyFavorController.m
//  KaiStory
//
//  Created by yanzehua on 15/4/27.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "BabyFavorController.h"
#import "Tools.h"
#import "UIColor+HexStringToColor.h"
#import "UIImageView+WebCache.h"
#import "UserShareInfo.h"
#import "LoveStoryCell.h"
#import "AudioPlayManager.h"
#import "AudioPlayItem.h"
#import "LoveDailyCell.h"
#import "DailyModel.h"
#import "LoveAlbumCell.h"
#import "KSAlbumModel.h"
#import "StoryDetailController.h"
#import "DailyDetailControl.h"
#import "KSStoryListController.h"

@implementation BabyFavorController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageCount = 4;
    
    [self.baseContentView setBackgroundColor:[UIColor ColorWithHexString:@"e2f2ee"]];
    int btnWidth = 186;
    int btnHeight = 53;
    int marginTop = 6;
    int fontSize = 30;
    
    self.leftBtn = [[UIButton alloc]initWithFrame:CGRectMake( (FRAME_WIDTH-(btnWidth*3*RESIZE_RATIO))/2, marginTop*RESIZE_RATIO, btnWidth*RESIZE_RATIO, btnHeight*RESIZE_RATIO)];

    [self.leftBtn setBackgroundImage:[UIImage imageNamed:@"左"] forState:UIControlStateNormal];
    [self.leftBtn setBackgroundImage:[UIImage imageNamed:@"左_check"] forState:UIControlStateSelected];
    
    [self.leftBtn setTitleColor:[UIColor ColorWithHexString:@"4fb19b"] forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:[UIColor ColorWithHexString:@"ffffff"] forState:UIControlStateSelected];
    [self.leftBtn setTitle:@"故事" forState:UIControlStateNormal];
    self.leftBtn.titleLabel.font = [UIFont systemFontOfSize:fontSize*RESIZE_RATIO];
    [self.leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.baseContentView addSubview:self.leftBtn];
    
    self.midBtn = [[UIButton alloc]initWithFrame:CGRectMake( (FRAME_WIDTH-(btnWidth*3*RESIZE_RATIO))/2 + btnWidth*RESIZE_RATIO, marginTop*RESIZE_RATIO, btnWidth*RESIZE_RATIO, btnHeight*RESIZE_RATIO)];
    
    [self.midBtn setBackgroundImage:[UIImage imageNamed:@"中"] forState:UIControlStateNormal];
    [self.midBtn setBackgroundImage:[UIImage imageNamed:@"中_check"] forState:UIControlStateSelected];
    [self.midBtn setTitleColor:[UIColor ColorWithHexString:@"4fb19b"] forState:UIControlStateNormal];
    [self.midBtn setTitleColor:[UIColor ColorWithHexString:@"ffffff"] forState:UIControlStateSelected];
    [self.midBtn setTitle:@"专辑" forState:UIControlStateNormal];
    [self.midBtn addTarget:self action:@selector(midBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.midBtn.titleLabel.font = [UIFont systemFontOfSize:fontSize*RESIZE_RATIO];
    [self.baseContentView addSubview:self.midBtn];
    
    self.rightBtn = [[UIButton alloc]initWithFrame:CGRectMake( (FRAME_WIDTH-(btnWidth*3*RESIZE_RATIO))/2+ btnWidth*2*RESIZE_RATIO, marginTop*RESIZE_RATIO, btnWidth*RESIZE_RATIO, btnHeight*RESIZE_RATIO)];
    
    [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"右"] forState:UIControlStateNormal];
    [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"右_check"] forState:UIControlStateSelected];
    [self.rightBtn setTitleColor:[UIColor ColorWithHexString:@"4fb19b"] forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:[UIColor ColorWithHexString:@"ffffff"] forState:UIControlStateSelected];
    [self.rightBtn setTitle:@"日课" forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:fontSize*RESIZE_RATIO];
    [self.baseContentView addSubview:self.rightBtn];
    

    marginTop += (btnHeight + 14);
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, marginTop*RESIZE_RATIO, FRAME_WIDTH,[self getContentHeight]- marginTop*RESIZE_RATIO) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    static NSString *StoryCellIde = @"LoveStoryCell";
    [self.tableView registerClass:[LoveStoryCell class] forCellReuseIdentifier:StoryCellIde];
    static NSString *AlbumCellIde = @"LoveAlbumCell";
    [self.tableView registerClass:[LoveAlbumCell class] forCellReuseIdentifier:AlbumCellIde];
    static NSString *DailyCellIde = @"LoveDailyCell";
    [self.tableView registerClass:[LoveStoryCell class] forCellReuseIdentifier:DailyCellIde];
    [self.baseContentView addSubview:self.tableView];
    [self setHeaderView];
    
    self.currentTab = 0;
    self.leftBtn.selected = YES;

    [self setFooterView];
}

-(void) clearBtnStatus
{
    self.leftBtn.selected = NO;
    self.midBtn.selected = NO;
    self.rightBtn.selected = NO;
}

-(void) leftBtnClick:(id)sender
{
    self.currentTab = 0;
    [self clearBtnStatus];
    self.leftBtn.selected = YES;
    [self.tableView reloadData];
}

-(void) midBtnClick:(id)sender
{
    self.currentTab = 1;
    [self clearBtnStatus];
    self.midBtn.selected = YES;
    [self.tableView reloadData];
}

-(void) rightBtnClick:(id)sender
{
    self.currentTab = 2;
    [self clearBtnStatus];
    self.rightBtn.selected = YES;
    [self.tableView reloadData];
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
    
    if(0 == self.currentTab && self.leftPage > 0)
    {
        self.leftPage -= 1;
        [self.tableView reloadData];
    }else if (1 == self.currentTab)
    {
        self.midPage -= 1;
        [self.tableView reloadData];
    
    }else if(2 == self.currentTab && self.rightPage > 0)
    {
        self.rightPage -= 1;
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
    if(0 == self.currentTab)
    {
        NSInteger totalCount = [[UserShareInfo sharedSingleton].lovedStoryArray count];
        if((self.leftPage+1)*self.pageCount <  totalCount)
        {
            self.leftPage +=1;
            [self.tableView reloadData];
        }
    }else if(1 == self.currentTab)
    {
        NSInteger totalCount = [[UserShareInfo sharedSingleton].lovedAlbumArray count];
        if((self.midPage+1)*self.pageCount < totalCount)
        {
            self.midPage += 1;
            [self.tableView reloadData];
        }
    }else if(2 == self.currentTab)
    {
       
            NSInteger totalCount = [[UserShareInfo sharedSingleton].lovedDailyArray count];
            if((self.rightPage+1)*self.pageCount <  totalCount)
            {
                self.rightPage +=1;
                [self.tableView reloadData];
            }
        
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

-(void)updatePlayerBtnView:(NSNotification*)notification
{
    //当有播放状态改变时，直接更新当前数据。
    [self.tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updatePlayerBtnView:)  name:@"CURRENT_PLAY_ID" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma UItableview代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(0 == self.currentTab)
    {
       NSInteger totalCount = [[UserShareInfo sharedSingleton].lovedStoryArray count];
       NSInteger remainCount = totalCount - self.leftPage * self.pageCount;
       if(remainCount > self.pageCount)
           return self.pageCount;
       else
           return remainCount;
    }
    else if(1 == self.currentTab)
    {
        NSInteger totalCount = [[UserShareInfo sharedSingleton].lovedAlbumArray count];
        NSInteger remainCount = totalCount - self.leftPage * self.pageCount;
        if(remainCount > self.pageCount)
            return self.pageCount;
        else
            return remainCount;
    }
    else if(2 == self.currentTab)
    {
        NSInteger totalCount = [[UserShareInfo sharedSingleton].lovedDailyArray count];
        NSInteger remainCount = totalCount - self.rightPage * self.pageCount;
        if(remainCount > self.pageCount)
            return self.pageCount;
        else
            return remainCount;
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    if(0 == self.currentTab)
    {
        NSString* storyId = [[UserShareInfo sharedSingleton].lovedStoryArray objectAtIndex:self.leftPage*self.pageCount + index];
        StoryModel *model = [Tools getStoryItem:storyId];
        StoryDetailController *StoryDetail = [[StoryDetailController alloc]initWithConfig:model.name withBackBtn:YES withFootBar:YES];
        StoryDetail.storyItem = model;
        [self presentViewController:StoryDetail animated:YES completion:^{
        }];
    }else if(1 == self.currentTab)
    {
        NSString* albumID = [[UserShareInfo sharedSingleton].lovedAlbumArray objectAtIndex:self.leftPage*self.pageCount + index];
        KSAlbumModel *model = [Tools getAlbumItem:albumID];
        KSStoryListController *controller = [[KSStoryListController alloc]initWithConfig:model.modelName withBackBtn:YES withFootBar:YES];
        controller.requestUrl = model.requestUrl;
        controller.requestParams = model.requestParams;
        controller.categoryIDStr = model.modelID;
        [self presentViewController:controller animated:YES completion:^{
        }];
    }
    else if(2 == self.currentTab)
    {
    
        NSString* dailyId = [[UserShareInfo sharedSingleton].lovedDailyArray objectAtIndex:self.leftPage*self.pageCount + index];
        NSString* dailyKey = [NSString stringWithFormat:@"DAILYINFO_%@",dailyId];
        NSString* dailyStr = [Tools getCacheJson:dailyKey];
        NSData* dailyData = [[NSData alloc]initWithBase64Encoding:dailyStr];
        DailyModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:dailyData];
        
        DailyDetailControl *DetailDail = [[DailyDetailControl alloc]initWithConfig:@"" withBackBtn:YES withFootBar:YES];
        DetailDail.m_DailyID = model.m_id;
        DetailDail.m_URL = model.open_url;
        DetailDail.m_CurrentModel = model;
        [self presentViewController:DetailDail animated:YES completion:^{
        }];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = indexPath.row;
    if(0 == self.currentTab)
    {
        static NSString *StoryCellIde = @"LoveStoryCell";
        LoveStoryCell *cell = [tableView dequeueReusableCellWithIdentifier:StoryCellIde];
        if (cell ==nil | cell.mainLabel ==nil) {
            cell = [[LoveStoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:StoryCellIde];
            [cell setFrame:CGRectMake(0, 0, FRAME_WIDTH, 178*RESIZE_RATIO)];
            [cell initLayout:CGRectMake(0, 0, FRAME_WIDTH, 178*RESIZE_RATIO)];
        }
        NSString* storyId = [[UserShareInfo sharedSingleton].lovedStoryArray objectAtIndex:self.leftPage*self.pageCount + index];
        StoryModel *model = [Tools getStoryItem:storyId];
        [cell setModel:model];
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
        [cell.optionBtn addTarget:self action:@selector(optionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.optionBtnExtA addTarget:self action:@selector(optionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.optionBtn setTag:index];
        [cell.optionBtnExtA setTag:index];
        return cell;
    }else if (1==self.currentTab)
    {
        static NSString *AlbumCellIde = @"LoveAlbumCell";
        LoveAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:AlbumCellIde];
        if (cell ==nil | cell.mainLabel ==nil) {
            cell = [[LoveAlbumCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AlbumCellIde];
            [cell setFrame:CGRectMake(0, 0, FRAME_WIDTH, 178*RESIZE_RATIO)];
            [cell initLayout:CGRectMake(0, 0, FRAME_WIDTH, 178*RESIZE_RATIO)];
        }
        NSString* albumID = [[UserShareInfo sharedSingleton].lovedAlbumArray objectAtIndex:self.leftPage*self.pageCount + index];
        KSAlbumModel *model = [Tools getAlbumItem:albumID];
        [cell setModel:model];

        return cell;
    }else
    {
        static NSString *DailyCellIde = @"LoveDailyCell";
        LoveDailyCell *cell = [tableView dequeueReusableCellWithIdentifier:DailyCellIde];
        if (cell ==nil | cell.mainLabel ==nil) {
            cell = [[LoveDailyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DailyCellIde];
            [cell setFrame:CGRectMake(0, 0, FRAME_WIDTH, 140*RESIZE_RATIO)];
            [cell initLayout:CGRectMake(0, 0, FRAME_WIDTH, 140*RESIZE_RATIO)];
        }
        NSString* dailyId = [[UserShareInfo sharedSingleton].lovedDailyArray objectAtIndex:self.leftPage*self.pageCount + index];
        NSString* dailyKey = [NSString stringWithFormat:@"DAILYINFO_%@",dailyId];
        NSString* dailyStr = [Tools getCacheJson:dailyKey];
        NSData* dailyData = [[NSData alloc]initWithBase64Encoding:dailyStr];
        DailyModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:dailyData];
        [cell setModel:model];
        return cell;
    }
    return nil;
    
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
    NSUInteger indexAtList = self.leftPage*self.pageCount + self.menuView.index;
    if([[UserShareInfo sharedSingleton].lovedStoryArray count] > indexAtList)
    {
        NSString* storyId = [[UserShareInfo sharedSingleton].lovedStoryArray objectAtIndex:indexAtList];
        StoryModel *model =  [Tools getStoryItem:storyId];
        [[AudioPlayManager sharedManager] addToPlayList:model];
    }
    [self.menuView removeFromSuperview];
}
-(void)delItem:(id)sender
{
    NSLog(@"delItem");
    NSUInteger indexAtList = self.leftPage*self.pageCount + self.menuView.index;
    if([[UserShareInfo sharedSingleton].lovedStoryArray count] > indexAtList)
    {
        NSString* storyId = [[UserShareInfo sharedSingleton].lovedStoryArray objectAtIndex:indexAtList];
        [[UserShareInfo sharedSingleton] removeLoveStory:storyId];
        
        // 如果不足一页的时候，进行补充处理
        NSInteger totalCount = [[UserShareInfo sharedSingleton].lovedStoryArray count];
        if((self.leftPage)*self.pageCount >=  totalCount)
        {
            self.leftPage -= 1;
            if(self.leftPage < 0)
            {
                self.leftPage = 0;
            }
        }
        [self.tableView reloadData];
    }
    [self.menuView removeFromSuperview];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(0 == self.currentTab)
    {
        return 178 * RESIZE_RATIO;
    }else if(1 == self.currentTab)
    {
        return 178 * RESIZE_RATIO;
    }else if (2 == self.currentTab)
    {
        return 140 * RESIZE_RATIO;
    }
    return 0 ;
}

-(void)backBtnAction:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^(){}];
}

@end
