//
//  KSStoryListController.m
//  KaiStory
//
//  Created by yanzehua on 15/5/8.
//  Copyright (c) 2015年 kaishu. All rights reserved.
//

#import "KSStoryListController.h"
#import "Tools.h"
#import "UIColor+HexStringToColor.h"
#import "UIImageView+WebCache.h"
#import "UserShareInfo.h"
#import "LoveStoryCell.h"
#import "AudioPlayManager.h"
#import "AudioPlayItem.h"
#import "KStoryCell.h"
#import "MyDataService.h"
#import "StoryDetailController.h"

@implementation KSStoryListController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(nil != self.categoryIDStr)
    {
        int const listMarginTop = 66;
        int const listMarginRight = 50;
        int const listWidth = 40;
        int const listHeight = 40;
        
        self.listBtn = [[UIButton alloc] initWithFrame:CGRectMake(FRAME_WIDTH - listMarginRight, listMarginTop/2, listWidth/2, listHeight/2)];
        [self.listBtn setImage:[UIImage imageNamed:@"列表喜欢"] forState:(UIControlStateNormal)];
        [self.listBtn setImage:[UIImage imageNamed:@"列表已经喜欢"] forState:(UIControlStateSelected)];
        [self.listBtn addTarget:self action:@selector(listBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.listBtn];
        if([[UserShareInfo sharedSingleton].lovedAlbumArray containsObject:self.categoryIDStr])
        {
            self.listBtn.selected = YES;
        }
    }
    self.pageCount = 4;
    [self.baseContentView setBackgroundColor:[UIColor ColorWithHexString:@"e2f2ee"]];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, FRAME_WIDTH,[self getContentHeight]) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    static NSString *StoryCellIde = @"StoryCell";
    [self.tableView registerClass:[KStoryCell class] forCellReuseIdentifier:StoryCellIde];
    [self.baseContentView addSubview:self.tableView];
    
    self.m_DataArray = [[NSMutableArray alloc]initWithCapacity:10];
    self.currentPage = 0;
    [self setHeaderView];
    [self setFooterView];
    [self loadPage:self.currentPage+1];
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
        [self loadPage: self.currentPage -1];
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
    
    if(self.hasMore)
    {
        [self loadPage:self.currentPage+1];
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
    return self.m_DataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = indexPath.row;
    
    static NSString *StoryCellIde = @"StoryCell";
    KStoryCell *cell = [tableView dequeueReusableCellWithIdentifier:StoryCellIde];
    if (cell ==nil | cell.mainLabel ==nil) {
        cell = [[KStoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:StoryCellIde];
        [cell setFrame:CGRectMake(0, 0, FRAME_WIDTH, 178*RESIZE_RATIO)];
        [cell initLayout:CGRectMake(0, 0, FRAME_WIDTH, 178*RESIZE_RATIO)];
    }
    StoryModel *model = [self.m_DataArray objectAtIndex:index];
    
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

-(void)optionBtnClick:(id)sender
{
    NSInteger index = [sender tag];
    NSLog(@"Get item at index %ld",index);
    NSArray* btnLabelArray = [[NSArray alloc]initWithObjects:@"加入播放列表",@"直接播放",nil];
    self.menuView = [[ContextMenuView alloc] initWithFrameRect:CGRectMake(0, 0, FRAME_WIDTH, FRAME_HEIGHT) withLabelArray:btnLabelArray];
    
    [self.menuView setItemIndex:index];
    [[self.menuView.btnArray objectAtIndex:0] addTarget:self action:@selector(addToPlayList:) forControlEvents:UIControlEventTouchUpInside];
    [[self.menuView.btnArray objectAtIndex:1] addTarget:self action:@selector(playItem:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.menuView];
}

-(void) addToPlayList:(id)sender
{
    NSLog(@"addToPlayList");
}

-(void)playItem:(id)sender
{
   NSLog(@"playItem");
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 178 * RESIZE_RATIO;
}

-(void)backBtnAction:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^(){}];
}

-(NSMutableArray*) parseFromResult:(id)result
{
    NSDictionary *result1 = [result objectForKey:@"result"];
    //NSString *version  = [result1 objectForKey:@"version"];
    NSDictionary *resu =[result1 objectForKey:@"view_content"];
    NSString* moreFlag = [NSString stringWithFormat:@"%@",[resu objectForKey:@"more"]];
    
    if([moreFlag isEqualToString:@"1"])
    {
        self.hasMore = YES;
    }
    else
    {
        self.hasMore = NO;
    }
    NSDictionary *showdata = [resu objectForKey:@"show_data"];
    NSDictionary *media_list = [showdata objectForKey:@"media_list"];
    NSLog(@"%@",media_list);
    NSArray *uuy = [NSArray arrayWithArray:[showdata objectForKey:@"media_list"]];
    NSMutableArray* modelArray = [NSMutableArray array];
    
    for (NSDictionary *dic in uuy) {
        StoryModel *model = [[StoryModel alloc]initWithDict:dic];
        [modelArray addObject:model];
    }
    return modelArray;
}

-(void) updateData: (id)result AtPageIndex:(int)pageIndex
{
    NSMutableArray* modelArray = [self parseFromResult:result];
    if(modelArray.count > 0)
    {
        [self.m_DataArray removeAllObjects];
        [self.m_DataArray addObjectsFromArray:modelArray];
        //由于更新了数据，需要更新FooterView
        [self.tableView reloadData];
        
        NSUInteger ii[2] = {0, modelArray.count - 1};
        NSIndexPath* indexPath = [NSIndexPath indexPathWithIndexes:ii length:2];
        [self.tableView scrollToRowAtIndexPath:indexPath
                              atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [self.tableView setContentOffset:CGPointZero animated:YES];
        
        self.currentPage = pageIndex;
        [self setFooterView];
    }
    
}

-(void) loadPage:(int) pageIndex
{
    //首先将参数进行拼装
    NSString *params=@"";
    NSInteger i=0;
    /*
    NSDictionary *tempDict = [Tools dictionaryWithJsonString:self.requestParams];
    for (NSString * tmpKey in tempDict)
    {
        NSString *value = [tempDict objectForKey:tmpKey];
        if (i==0) {
            params = [NSString stringWithFormat:@"%@%@=%@",params,tmpKey,value];
        }else{
            params = [NSString stringWithFormat:@"%@&%@=%@",params,tmpKey,value];
        }
        i=i+1;
    }*/
    
    NSString* destUrl = [NSString stringWithFormat:@"%@?&page_num=%d",self.requestUrl,pageIndex];
    NSLog(@"DestUrl is %@",destUrl);
    
    NSMutableDictionary *postDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"1.0",@"app_ver",self.requestParams,@"open_params",nil];
    [MyDataService requestAFURL:destUrl httpMethod:@"POST" params:postDict data:nil complection:^(id result) {
        NSString *code =[NSString stringWithFormat:@"%@",[result objectForKey:@"code"]];
        if( [code isEqualToString:@"200"] )
        {
            NSLog(@"%@",result);
            [self updateData: result AtPageIndex: pageIndex ];
            
            if(1 == pageIndex)
            {
                //  [self updateCacheInfo:result];
            }
        }
    }];
}

-(void) listBtnPressed:(id)sender
{
    self.listBtn.selected = !self.listBtn.selected;
    if (self.listBtn.selected) {
        KSAlbumModel* model = [[KSAlbumModel alloc]init];
        model.modelID = self.categoryIDStr;
        model.modelName = self.titleLabel.text;
        if(self.m_DataArray.count > 0)
        {
            StoryModel* storyModel =[self.m_DataArray objectAtIndex:0];
            model.modelPic = storyModel.cover_url;
        }
        model.requestParams = self.requestParams;
        model.requestUrl = self.requestUrl;
        [[UserShareInfo sharedSingleton] addLoveAlbum:model];
    }else
    {
        [[UserShareInfo sharedSingleton] removeLoveAlbum:self.categoryIDStr];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    StoryModel *model =  [self.m_DataArray objectAtIndex:index];
    StoryDetailController *StoryDetail = [[StoryDetailController alloc]initWithConfig:model.name withBackBtn:YES withFootBar:YES];
    StoryDetail.storyItem = model;
    [self presentViewController:StoryDetail animated:YES completion:^{
    }];
    
}

@end
