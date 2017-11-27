//
//  CustomController.m
//  KaiStory
//
//  Created by mac on 15/2/6.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "CustomController.h"
 
#import "MyDataService.h"
#import "CustomAlertView.h"
#import "DailyModel.h"
#import "SqliteControl.h"
#import "Tools.h"

#import "DailyDetailControl.h"
#import "UIImageView+AFNetworking.h"


#import "TodayDaily.h"
#import "UIColor+HexStringToColor.h"
#import "LayoutConst.h"
#import "DailyCellView.h"

@interface CustomController (){


}

@end

@implementation CustomController

- (void) initData
{
    self.m_DataArray = [[NSMutableArray alloc]initWithCapacity:10];
    self.todayModel = [[DailyModel alloc]init];
    self.currentPage = 1;
    self.hasMore = YES;
    
    // TODO 更新时间的GAP
    BOOL isExpire = [Tools checkTimeExpire:@"DAILY_LASTUPDATE" ExpireSeconds:3600];
    NSLog(@"isExpire %d", isExpire);
    
    // 从Cache中载入数据
    NSString* jsonStr = [Tools getCacheJson:@"DAILY_JSON"];
    if(NO == [Tools isBlankString:jsonStr] )
    {
        NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                 options:NSJSONReadingMutableContainers
                                                 error:&err];
        //NSLog(@"INITDATA %@",dic);
        [self updateData:dic AtPageIndex:self.currentPage];
    }
    
    if(YES == isExpire || [Tools isBlankString:jsonStr])
    {
        NSLog(@"Request info");
        [self loadPage: self.currentPage];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //界面的初始化
    UIColor *bgColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"BG.png"]];
    [self.view setBackgroundColor:bgColor];
    
    int titleViewHeight = 40+88;
    // 创建头条内容
    int todayDailyHeight = 490;
    self.todayDaily = [[TodayDailyView alloc]initWithFrame:CGRectMake(0, 0, FRAME_WIDTH, todayDailyHeight*RESIZE_RATIO)];
    [self.todayDaily.ClickBtn addTarget:self action:@selector(EnterToday:) forControlEvents:UIControlEventTouchUpInside];

    // 创建列表区域
    int tableMarginTop = titleViewHeight;
    // TODO 列表区域高度调整
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, tableMarginTop/2, FRAME_WIDTH, FRAME_HEIGHT-tableMarginTop*2*RESIZE_RATIO) style:UITableViewStylePlain];
    
    static NSString *StoryCellIde = @"DailyCell";
    [self.tableView registerClass:[DailyCellView class] forCellReuseIdentifier:StoryCellIde];
    self.tableView.userInteractionEnabled = YES;
    [self.view addSubview:self.tableView];

    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.tableHeaderView = self.todayDaily;
    
    //创建下拉 上拉刷新区域
    [self setHeaderView];
    
    //数据的初始化
    [self initData];
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

    [self loadPage:1];
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
    if (YES == self.hasMore) {
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
    NSDictionary *daily_list = [showdata objectForKey:@"daily_list"];
    NSLog(@"%@",daily_list);
    NSArray *uuy = [NSArray arrayWithArray:[showdata objectForKey:@"daily_list"]];
    NSMutableArray* modelArray = [NSMutableArray array];

    for (NSDictionary *dic in uuy) {
        DailyModel *model = [[DailyModel alloc]initWithDict:dic];
        [modelArray addObject:model];
    }
    return modelArray;
}

-(void) updateData: (id)result AtPageIndex:(int)pageIndex
{
    NSMutableArray* modelArray = [self parseFromResult:result];
    if(modelArray.count > 0)
    {
        if(pageIndex == 1)
        {
            self.todayModel = modelArray[0];
            [self setTodayInfo];
            NSRange range = NSMakeRange(1,modelArray.count-1);
            [self.m_DataArray removeAllObjects];
            [self.m_DataArray addObjectsFromArray : [modelArray subarrayWithRange:range]];
        }else
        {
            [self.m_DataArray addObjectsFromArray:modelArray];
        }
        
        //由于更新了数据，需要更新FooterView
        [self.tableView reloadData];
        self.currentPage = pageIndex;
        [self setFooterView];
    }

}

-(void) updateCacheInfo: (id)result
{
    //TODO 更新数据库中缓存的数据和时间
   
        BOOL ret = [Tools setUpdateTime:@"DAILY_LASTUPDATE"];
        NSLog(@"setUpdateTime's result %d", ret);
        //序列化json内容
        NSError *parseError = nil;
        NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted error:&parseError];
        NSString* serialStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        //NSLog(@"SerialStr is %@",serialStr);
        ret =[Tools setCacheJson: serialStr forKey:@"DAILY_JSON"];
        NSLog(@"setCacheJson result %d", ret);
    
}

-(void) loadPage:(int) pageIndex
{
    NSString *url = @"/res/daily/list?";
    NSString *page_num = [NSString stringWithFormat:@"%d",pageIndex];
    NSLog(@"load Page %@",page_num);
    NSString *page_size = @"2";
    NSString *appid=@"1.0";
    NSString *app_ver = @"1.0";
    NSString *json_ver = @"0.1";
    
    NSString *ln = @"33.332";
    NSString *lat = @"199.3232";
    NSMutableDictionary *postDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:page_num,@"page_num",page_size,@"page_size",appid,@"appid",app_ver,@"app_ver",json_ver,@"json_ver",ln,@"lng",lat,@"lat",nil];

    url = [NSString stringWithFormat:@"%@page_num=%@",url,page_num];
    [MyDataService requestAFURL:url httpMethod:@"POST" params:postDict data:nil complection:^(id result) {
        NSString *code =[NSString stringWithFormat:@"%@",[result objectForKey:@"code"]];
        if( [code isEqualToString:@"200"] )
        {

        [self updateData: result AtPageIndex: pageIndex ];
        
            if(1 == pageIndex)
            {
                [self updateCacheInfo:result];
            }
        }
    }];
}


-(void)loadDataList
{
    NSString *url = @"/res/daily/list?";
    NSString *page_num = @"1";
//    NSString *page_num = [NSString stringWithFormat:@"%ld",page_num];
    
    NSString *page_size = @"4";
    NSString *appid=@"1.0";
    NSString *app_ver = @"1.0";
    NSString *json_ver = @"0.1";
    
    NSString *ln = @"33.332";
    NSString *lat = @"199.3232";
    
    NSMutableDictionary *dir = [NSMutableDictionary dictionaryWithObjectsAndKeys:page_num,@"page_num",page_size,@"page_size",appid,@"appid",app_ver,@"app_ver",json_ver,@"json_ver",ln,@"lng",lat,@"lat",nil];
    [MyDataService requestAFURL:url httpMethod:@"POST" params:dir data:nil complection:^(id result) {
       
        //NSLog(@"___________result=======%@",result);
        
        
        NSDictionary *result1 = [result objectForKey:@"result"];
        NSString *version  = [result1 objectForKey:@"version"];
        NSLog(@"%@",version);
        NSDictionary *resu =[result1 objectForKey:@"view_content"];
        NSDictionary *showdata = [resu objectForKey:@"show_data"];
        NSDictionary *daily_list = [showdata objectForKey:@"daily_list"];
        NSLog(@"%@",daily_list);
        NSArray *uuy = [NSArray arrayWithArray:[showdata objectForKey:@"daily_list"]];
        NSMutableDictionary *DailyDict = [NSMutableDictionary dictionary];
        self.m_DataArray = [NSMutableArray array];
        int i=2;
        for (NSDictionary *dic in uuy) {
            
            DailyModel *model = [[DailyModel alloc]initWithDict:dic];
            
            DailyDict[@"story_id"] = model.m_id;
            DailyDict[@"title"] = model.title;
            DailyDict[@"summary"] = model.summary;
            DailyDict[@"open_type"]= model.open_type;
            DailyDict[@"open_url"] = model.open_url;
           // DailyDict[@"open_param"] = model.open_param;
            DailyDict[@"open_method"] = model.open_method;
            DailyDict[@"img_url"] = model.img_url;
            DailyDict[@"release_date"] = model.release_date;
            DailyDict[@"read_count"] = model.read_count;
            DailyDict[@"comment_count"] = model.comment_count;
            DailyDict[@"collect_count"] = model.share_count;
            //数据库表中添加数据
            //BOOL InsertStatus = [[SqliteControl sharedController]insertTableInfo:@"Test" tablefield:DailyDict];
            //NSLog(@"abc======%hhd",InsertStatus);
            
            if (i==2){
//                [self.m_dayArray addObject:model];
                self.todayModel = model;
            }else{
               [self.m_DataArray addObject:model];
            }
            i=i+1;
           
            
            NSLog(@"%lu",(unsigned long)self.m_DataArray.count);
        }
        [self setTodayInfo];
        [self.tableView reloadData];
        //数据库表中查询数据
    
        NSArray *DailyList  = [[SqliteControl sharedController]selectTableInfo:@"Test" tablefield:nil];//数据库查询
        NSLog(@"DailyList=======%@",DailyList);
        [self setFooterView];
    }];
}

#pragma UItableview代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.m_DataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *StoryCellIde = @"DailyCell";
    DailyModel *model = [self.m_DataArray objectAtIndex:indexPath.row];
    DailyCellView *cell = [tableView dequeueReusableCellWithIdentifier:StoryCellIde];
    if (cell ==nil) {
        cell = [[DailyCellView alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:StoryCellIde];
    }
    if (cell.todayName == nil)
    {
        [cell initConst];
        [cell setFrame:CGRectMake(0, 0, FRAME_WIDTH, 186*RESIZE_RATIO)];
        [cell initLayout:CGRectMake(0, 0, FRAME_WIDTH, 186*RESIZE_RATIO)];
    }
    [cell setTodayInfo:model];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 186 * RESIZE_RATIO;
}





- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _refreshHeaderFlag = NO;
    _refreshFooterFlag = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)setTodayInfo{
    [self.todayDaily setTodayInfo:self.todayModel];
}

-(void)transIntoDetail:(DailyModel*) model
{
    NSString *DailyId =model.m_id;
    NSLog(@"DailyId======%@",DailyId);
    DailyDetailControl *DetailDail = [[DailyDetailControl alloc]initWithConfig:@"" withBackBtn:YES withFootBar:YES];
    DetailDail.m_DailyID = model.m_id;
    DetailDail.m_URL = model.open_url;
    DetailDail.m_CurrentModel = model;
    NSLog(@"Daily============%@",self.m_DataArray);
    [self presentViewController:DetailDail animated:YES completion:^{
    }];
}

-(void)EnterToday:(id)sender{
    [self transIntoDetail: self.todayModel];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DailyModel *model = [self.m_DataArray objectAtIndex:indexPath.row];
    [self transIntoDetail: model];
}


@end
