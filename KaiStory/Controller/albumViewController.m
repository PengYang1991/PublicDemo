//
//  albumViewController.m
//  KaiStory
//
//  Created by yangpeng on 15/4/10.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "albumViewController.h"
#import "Tools.h"
#import "UIColor+HexStringToColor.h"
#import "AlbumCell.h"

#import "LoginDataService.h"
#import "MyDataService.h"

#import "AlbumeModel.h"

#import "AlbumCellView.h"

#import "SqliteControl.h"

@interface albumViewController (){

    NSString *identy;
    AlbumeModel *albumModel;


}

@end

@implementation albumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataArrary = [NSMutableArray array];
    self.currentPage = 1;
    self.hasMore =YES;
    
   [self creatTitleView];
    
    [self loadPage:self.currentPage];
    
//    [self initData];
    
}
-(void)initData
{
    //更新数据的时间
    NSString *albumName = [NSString stringWithFormat:@"专辑－%@",self.albumModel.name];
    
    BOOL isExpire = [Tools checkTimeExpire:albumName ExpireSeconds:3600];
    NSLog(@"isExpire %d",isExpire);
    NSLog(@"Ablum=========%@",albumName);
}

- (void)creatTitleView{
    identy = @"AlbumCell";
    _albumTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, FRAME_WIDTH, FRAME_HEIGHT - 120)style:UITableViewStylePlain];
     [_albumTableView registerClass:[AlbumCellView class] forCellReuseIdentifier:identy];
    _albumTableView.dataSource = self;
    _albumTableView.delegate = self;
    [self.view addSubview:_albumTableView];
    
    [self setHeaderView];
    
}
-(void)setHeaderView
{
    _refreshHeaderView = [[EGORefreshTableHeaderView  alloc]initWithFrame:CGRectMake(0.0f, 0.0f - _albumTableView.bounds.size.height, _albumTableView.bounds.size.width, _albumTableView.bounds.size.height)];
    [_refreshHeaderView setDelegate:self];
    [_refreshHeaderView setBackgroundColor:[UIColor blueColor]];
    [_refreshHeaderView refreshLastUpdatedDate];
    [_albumTableView addSubview:_refreshHeaderView];
    
}
-(void)setFooterView
{
    CGFloat tableMaxHeight = MAX(_albumTableView.contentSize.height, _albumTableView.frame.size.height);
    if (_refreshFooterView) {
        _refreshFooterView.frame =CGRectMake(0.0f, tableMaxHeight, _albumTableView.frame.size.width, self.view.bounds.size.height);
    }else{
        _refreshFooterView = [[EGORefreshTableFooterView alloc]initWithFrame:CGRectMake(0.0f, 0.0+tableMaxHeight, _albumTableView.frame.size.width, _albumTableView.bounds.size.height)];
        [_refreshFooterView setDelegate:self];
        _refreshFooterView.backgroundColor =[UIColor blueColor];
        [_refreshFooterView refreshLastUpdatedDate];
        [_albumTableView addSubview:_refreshFooterView];
    }
}

-(void)reloadTableHeaderDataSource{
    _refreshFooterFlag =YES;
    if (dataArrary.count >0)
    {
         [_albumTableView reloadData];
      
    }else{
       [self loadPage:1];
    }
   
}
-(void)doneLoadingTableHeaderData{
    _refreshHeaderFlag =NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_albumTableView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    [_refreshFooterView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    [_refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];
}


-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
{
    [self reloadTableHeaderDataSource];
    [self performSelector:@selector(doneLoadingTableHeaderData) withObject:nil afterDelay:3.0];
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    return _refreshHeaderFlag;
}
-(NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view{
    return [NSDate date];
}

-(void)reloadTableFooterDataSource{
    _refreshFooterFlag = YES;
    if (self.hasMore ==YES) {
        [self loadPage:self.currentPage +1];
    }
}

-(void)doneLoadingTableFooterData{
    _refreshFooterFlag = NO;
    [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:_albumTableView];
}
-(void)egoRefreshTableFooterDidTriggerRefresh:(EGORefreshTableFooterView *)view{
    [self reloadTableFooterDataSource];
    [self performSelector:@selector(doneLoadingTableFooterData) withObject:nil afterDelay:3.0];
}
-(BOOL)egoRefreshTableFooterDataSourceIsLoading:(EGORefreshTableFooterView *)view{
    return _refreshFooterFlag;
}
-(NSDate *)egoRefreshTableFooterDataSourceLastUpdated:(EGORefreshTableFooterView *)view
{
    return [NSDate date];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArrary.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AlbumeModel *cellItem = [dataArrary objectAtIndex:indexPath.row];
    AlbumCellView *cell  = [tableView dequeueReusableCellWithIdentifier:identy];
    
    if (cell) {
        
        cell = [[AlbumCellView alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
        
    }
    [cell setFrame:CGRectMake(0, 0, FRAME_WIDTH, 178*RESIZE_RATIO)];
    [cell initLayout:CGRectMake(0, 0, FRAME_WIDTH, 178*RESIZE_RATIO)];
    [cell SetCellData:cellItem];
    [cell.playBtn addTarget:self action:@selector(PlayStory:) forControlEvents:UIControlEventTouchUpInside];
   
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AlbumeModel *cellItem = [dataArrary objectAtIndex:indexPath.row];
    /*
    StoryListControllerViewController *contr = [[StoryListControllerViewController alloc]initWithConfig:cellItem.name withBackBtn:YES];
    [contr loadStoryList:cellItem.open_url params:cellItem.open_params];
    [self.navigationController pushViewController:contr animated:YES];
     */
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 178*RESIZE_RATIO;
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _refreshFooterFlag = NO;
    _refreshHeaderFlag = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
-(void)backBtnAction:(id)sender{
    NSLog(@"NEED OVERWRITE");
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)PlayStory:(id)sender
{
    NSLog(@"专辑故事被点击了!!!!!!!!!");

    
}
-(void)loadPage:(NSInteger)pageIndex
{
        NSString *page_num = [NSString stringWithFormat:@"%ld",(long)pageIndex];
        NSString *page_size = @"2";
        NSString *appid=@"1.0";
        NSString *app_ver = @"1.0";
        NSString *json_ver = @"0.1";
        NSString *ln = @"33.332";
        NSString *lat = @"199.3232";
        NSString *user_id = @"100";
        NSString *token = @"12";
        NSString *sex = @"m";
        NSString *show_category_id=self.albumModel.m_id;
        NSString *URL = [NSString stringWithFormat:@"%@?page_num=%@",self.albumModel.open_url,page_num];
        
        NSMutableDictionary *postDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:page_num,@"page_num",page_size,@"page_size",appid,@"appid",app_ver,@"app_ver",json_ver,@"json_ver",ln,@"lng",lat,@"lat",user_id,@"user_id",token,@"token",sex,@"sex",show_category_id,@"show_category_id",nil];
        
        [LoginDataService requestAFURL1:URL httpMethod:@"POST" params:postDict data:nil complection:^(id result)
         {
             NSLog(@"Result==========%@",result);
             NSLog(@"URL========%@",URL);
             NSString *code =[NSString stringWithFormat:@"%@",[result objectForKey:@"code"]];
             if ([code isEqualToString:@"200"])
             {
                 [self updateData:result AtPageIndex:pageIndex];
             }
             
             
             //         NSMutableDictionary* updateDict =[[NSMutableDictionary alloc] initWithCapacity:10];
             //         NSString *ResultStr = [Tools NSDictionaryToString:result];
             //         [updateDict setValue:self.albumModel.name forKey:@"AlbumName"];
             //         [updateDict setValue:ResultStr forKey:@"JSON"];
             //         [updateDict setValue:version forKey:@"version"];
             //         BOOL status =  [[SqliteControl sharedController]insertTableInfo:@"albumTable" tablefield:updateDict];
             //
             //         NSMutableDictionary *where = [[NSMutableDictionary alloc]initWithCapacity:10];
             //         [where setValue:self.albumModel.name forKey:@"AlbumName"];
             //
             //         NSArray * mm  =[[SqliteControl sharedController]selectTableInfo:@"albumTable" tablefield:where];
             //         NSLog(@"==========%lu",(unsigned long)mm.count);
             //         NSLog(@"==========%@",version);
             
         }];
}

-(void) updateData: (id)result AtPageIndex:(NSInteger)pageIndex
{
    NSMutableArray *modelArray = [self parseFromResult:result];
    if (modelArray.count > 0)
    {
        if (pageIndex == 1)
        {
            [dataArrary removeAllObjects];
            [dataArrary addObjectsFromArray:modelArray];
        }else{
            [dataArrary addObjectsFromArray:modelArray];
        }
        [_albumTableView reloadData];
    }
    [_albumTableView reloadData];
    self.currentPage = pageIndex;
    [self setFooterView];
}
-(NSMutableArray*) parseFromResult:(id)result{
    NSMutableArray *array = [NSMutableArray array];
    NSDictionary *m_result = [result objectForKey:@"result"];
    NSLog(@"result========%@",m_result);
    NSString *version = [m_result objectForKey:@"version"];
    NSDictionary *view_content = [m_result objectForKey:@"view_content"];
    NSString *more = [view_content objectForKey:@"more"];
    NSLog(@"more=====%@",more);
    NSString *More = @"1";
    NSString* moreFlag = [NSString stringWithFormat:@"%@",[view_content objectForKey:@"more"]];
    if([moreFlag isEqualToString:@"1"])
    {
        self.hasMore = YES;
    }
    else
    {
        self.hasMore = NO;
    }
    NSDictionary *show_data = [view_content objectForKey:@"show_data"];
    NSDictionary *album_list = [show_data objectForKey:@"album_list"];
    NSLog(@"m_result========%@",album_list);
    NSArray *uu = [show_data objectForKey:@"album_list"];
    for (NSDictionary *dic in uu)
    {
        AlbumeModel *albumModel1 =[[AlbumeModel alloc]initWithDict:dic];
        NSLog(@"AlbumModel=========%@",albumModel1);
        [array addObject:albumModel1];
    }
    return  array;
}


@end
