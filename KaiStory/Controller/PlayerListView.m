//
//  PlayerListView.m
//  KaiStory
//
//  Created by yanzehua on 15/4/24.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "PlayerListView.h"
#import "Tools.h"
#import "UIImageView+WebCache.h"
#import "UIColor+HexStringToColor.h"
#import "PlayerListItemView.h"
#import "AudioPlayManager.h"


@implementation PlayerListView

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    int marginLeft = 30;
    int marginTop = 28;
    int labelWidth = 200;
    int labelHeight = 28;
    int labelFontSize = 28;
    UILabel* playListLabel = [[UILabel alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO, marginTop*RESIZE_RATIO, labelWidth*RESIZE_RATIO, labelHeight*RESIZE_RATIO)];
    playListLabel.textColor = [UIColor ColorWithHexString:@"ababab"];
    playListLabel.text = @"播放列表";
    playListLabel.font = [UIFont systemFontOfSize:labelFontSize*RESIZE_RATIO];
    playListLabel.lineBreakMode = NSLineBreakByWordWrapping;
    playListLabel.numberOfLines = 0;
    [self addSubview:playListLabel];
    
    marginTop = 90;
    int tableWidth = 580;
    int tableHeight = 525;
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(marginLeft*RESIZE_RATIO, marginTop*RESIZE_RATIO, tableWidth*RESIZE_RATIO, tableHeight*RESIZE_RATIO)];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //self.playListView.separatorStyle = NO;
    [self addSubview:self.tableView];
    
    self.pageCount = 4;
    NSInteger indexInList = self.currentPage*self.pageCount + index;
    //获取全局播放器的播放序号
    NSInteger currentPlayIndex = [AudioPlayManager sharedManager].currentIndex;
    self.currentPage = currentPlayIndex/self.pageCount;

    [self setHeaderView];
    [self setFooterView];
    
    return self;
}

#pragma mark - uitableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger totalCount = [[AudioPlayManager sharedManager].playList count];
    NSInteger remainCount = totalCount - self.currentPage * self.pageCount;
    if(remainCount > self.pageCount)
        return self.pageCount;
    else
        return remainCount;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105*RESIZE_RATIO;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableCellIdentify = @"playListItem";
    PlayerListItemView *cell = [tableView dequeueReusableCellWithIdentifier:tableCellIdentify];
    if (cell ==nil || cell.coverImgView == nil) {
        cell = [[PlayerListItemView alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableCellIdentify];
        [cell setFrame:CGRectMake(0, 0, FRAME_WIDTH, 105*RESIZE_RATIO)];
        [cell initLayout:CGRectMake(0, 0, FRAME_WIDTH, 105*RESIZE_RATIO)];
    }
    //设置基础信息
    NSInteger index = indexPath.row;
    //读取播放列表里的内容
    NSInteger indexInList = self.currentPage*self.pageCount + index;
    NSInteger currentPlayIndex = [AudioPlayManager sharedManager].currentIndex;
    NSString* storyIDStr =[[AudioPlayManager sharedManager].playList objectAtIndex: indexInList];
    StoryModel* storyItem = [Tools getStoryItem:storyIDStr];
    cell.titleLabel.text = storyItem.name;
    [cell.coverImgView sd_setImageWithURL:[NSURL URLWithString:storyItem.icon_url]];
    cell.periodLabel.text = storyItem.duration;
    
    if(currentPlayIndex == indexInList)
    {
        cell.titleLabel.textColor = [UIColor ColorWithHexString:@"4ab19a"];
        cell.periodLabel.textColor = [UIColor ColorWithHexString:@"4ab19a"];
    }else
    {
        cell.titleLabel.textColor = [UIColor ColorWithHexString:@"ababab"];
        cell.periodLabel.textColor = [UIColor ColorWithHexString:@"ababab"];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = indexPath.row;
    //读取播放列表里的内容
    NSUInteger indexInList = self.currentPage*self.pageCount + index;
    [[AudioPlayManager sharedManager] playAItemInList:indexInList];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =(UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor =[UIColor clearColor];
}


- (void)setHeaderView{
    //创建下拉刷新的控件
    //该下拉控件被添加在tableView的不可见区域内
    _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.tableView.frame.size.width, self.tableView.bounds.size.height)];
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
                                              self.bounds.size.height);
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
    [self performSelector:@selector(doneLoadingTableHeaderData) withObject:nil afterDelay:1.0];
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
    NSInteger totalCount = [AudioPlayManager sharedManager].playList.count;
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
    [self performSelector:@selector(doneLoadingTableFooterData) withObject:nil afterDelay:1.0];
}

- (BOOL)egoRefreshTableFooterDataSourceIsLoading:(EGORefreshTableFooterView*)view{
    return _refreshFooterFlag;
}

- (NSDate*)egoRefreshTableFooterDataSourceLastUpdated:(EGORefreshTableFooterView*)view{
    return [NSDate date]; // should return date data source was last changed
}

-(void) updateState
{
    [self.tableView reloadData];
}

-(void) updatePlayItemView:(NSNotification *)notification
{
    [self updateState];
}

-(void)regObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updatePlayItemView:)  name:@"CURRENT_PLAY_ID" object:nil];
}

-(void) unRegObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
