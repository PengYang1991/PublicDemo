//
//  CategoryViewController.m
//  KaiStory
//
//  Created by mac on 15/3/31.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "CategoryViewController.h"
#import "Tools.h"
#import "MyDataService.h"
//#import "CategoryCellCollectionViewCell.h"
#import "SqliteControl.h"
#import "UIColor+HexStringToColor.h"
#import "UIViewExt.h"
#import "CustomizedViewController.h"
#import "CategoryModel.h"
#import "Allstroymodel.h"
@interface CategoryViewController (){
    
    NSString *indefy;
    UIButton * leftbutton;
    UILabel *minLable;
    NSMutableArray *setarrary;
    UILabel *minLables;
}

@end

@implementation CategoryViewController
static NSString *const CollectionCell = @"color";
static NSString *const CellIdentify =@"cell";
//- (void) initData
//{
//    self.m_DataArray = [[NSMutableArray alloc]initWithCapacity:10];
////    self.todayModel = [[DailyModel alloc]init];
//    self.currentPage = 1;
//    self.hasMore = YES;
//
//    // TODO 更新时间的GAP
//    BOOL isExpire = [Tools checkTimeExpire:@"DAILY_LASTUPDATE" ExpireSeconds:3600];
//    NSLog(@"isExpire %d", isExpire);
//
//    // 从Cache中载入数据
//    NSString* jsonStr = [Tools getCacheJson:@"DAILY_JSON"];
//    if(NO == [Tools isBlankString:jsonStr] )
//    {
//        NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
//        NSError *err;
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
//                                                            options:NSJSONReadingMutableContainers
//                                                              error:&err];
//        //NSLog(@"INITDATA %@",dic);
//        [self updateData:dic AtPageIndex:self.currentPage];
//    }
//
//    if(YES == isExpire || [Tools isBlankString:jsonStr])
//    {
//        NSLog(@"Request info");
//        [self loadPage: self.currentPage];
//    }
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatHearButton];
    _selectIndex = [NSMutableArray array];
    self.view.backgroundColor = [UIColor ColorWithHexString:@"e4f2ee"];
    self.m_dataSource = [NSMutableArray array];
    self.currentPage = 1;
    setarrary = [NSMutableArray array];
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.headerReferenceSize= CGSizeMake(FRAME_WIDTH, 0);
    NSInteger top = 28+64+53+60;
    self.m_CollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, top*RESIZE_RATIO,
                                                                              FRAME_WIDTH, FRAME_HEIGHT) collectionViewLayout:flowLayout];
    self.m_CollectionView.delegate =self;
    self.m_CollectionView.dataSource = self;
    self.m_CollectionView.allowsMultipleSelection = NO;
    [self.m_CollectionView registerClass:[CategoryCellCollectionViewCell class]
              forCellWithReuseIdentifier:CellIdentify];
    
    self.m_CollectionView.backgroundColor = [UIColor ColorWithHexString:@"e4f2ee"];
    [self setHeaderView];
    [self.view addSubview:self.m_CollectionView];
    
    NSInteger leftbt = 545;
    NSInteger topbt = 40;
    NSInteger width =  64;
    NSInteger height = 54;
    UIButton * certainbt = [UIButton buttonWithType:UIButtonTypeCustom];
    certainbt.frame = CGRectMake(leftbt*RESIZE_RATIO,
                                 topbt*RESIZE_RATIO,
                                 width*RESIZE_RATIO,
                                 height*RESIZE_RATIO);
    [certainbt setTitle:@"完成" forState:UIControlStateNormal];
    [self.view addSubview:certainbt];
    [certainbt setTitleColor:[UIColor ColorWithHexString:@"46b098"] forState:UIControlStateNormal];
    [certainbt addTarget:self action:@selector(finishAction:) forControlEvents:UIControlEventTouchUpInside];
    [self cretMintView];
//    [self loadPage:self.currentPage];
    [self loadDataList];
    }
-(void)backBtnAction:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"se==%lu",(unsigned long)self.m_DataArray.count);

    return [self.m_DataArray count];
    }
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                                                                  cellForItemAtIndexPath:
                                                                         (NSIndexPath *)indexPath{
    
    CategoryCellCollectionViewCell *cell = [collectionView
                                            dequeueReusableCellWithReuseIdentifier:CellIdentify forIndexPath:indexPath];
    
   [cell sizeToFit];
    Allstroymodel *modes = [[Allstroymodel alloc]init];
    modes = [self.m_DataArray objectAtIndex:indexPath.row];
    [cell setmodel:modes];
    if ([self isHaveString:[NSString stringWithFormat:@"%ld",indexPath.row]]) {
        cell.isSelect = YES;
    }else{
        cell.isSelect = NO;
    }
    cell.tag = indexPath.row+10000;
    cell.cellsDelegate = self;
    return cell;
}

- (BOOL)isHaveString:(NSString*)str{
    for (NSString*s in _selectIndex) {
        if ([str isEqualToString:s]) {
            return YES;
        }
    }
    return NO;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(278*RESIZE_RATIO, 330*RESIZE_RATIO);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0*RESIZE_RATIO, 40*RESIZE_RATIO, 16*RESIZE_RATIO, 40*RESIZE_RATIO);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    CategoryCellCollectionViewCell *cell = (CategoryCellCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
     [self.selectIndex addObject:[NSString stringWithFormat:@"%ld",indexPath.row]];
    NSInteger min = [minLables.text integerValue];
    if ([self isHaveString:[NSString stringWithFormat:@"%ld",indexPath.row]]) {
        cell.isSelect = YES;
    }else {
        
        cell.isSelect = NO;
        
    }

    if (totalTime/60>min) {
        
        NSLog(@"超过选定时间");

        return;
        
    }else{
      
       NSLog(@"----------->%@",_selectIndex);
       Allstroymodel *modes = [[Allstroymodel alloc]init];
       modes = [self.m_DataArray objectAtIndex:indexPath.row];
       totalTime+=modes.duration;
        NSLog(@"totaltimne =%ld",(long)totalTime);
        NSString *ID =  modes.m_id;
     [setarrary addObject:ID];
     NSUserDefaults *selectStroy = [NSUserDefaults standardUserDefaults];
    [selectStroy setObject:setarrary forKey:@"setid"];
    [selectStroy synchronize];
//    NSInteger min = [minLables.text integerValue];
//    if (totalTime/60>min) {
//        
//        cell.isSelect = NO;
//    }else{
//        cell.isSelect = YES;
    minLable.text = [NSString stringWithFormat:@"%ld 分钟",(long)totalTime/60];
//    }
  }
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0*RESIZE_RATIO;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 16*RESIZE_RATIO;
}
- (void)setHeaderView{
    //创建下拉刷新的控件
    //该下拉控件被添加在tableView的不可见区域内
    _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.m_CollectionView.bounds.size.height, self.m_CollectionView.frame.size.width, self.m_CollectionView.bounds.size.height)];
    [_refreshHeaderView setDelegate:self];
    _refreshHeaderView.backgroundColor = [UIColor blueColor];
    [_refreshHeaderView refreshLastUpdatedDate];
    [self.m_CollectionView addSubview:_refreshHeaderView];
}

- (void) setFooterView
{
    CGFloat tableMaxHeight = MAX(self.m_CollectionView.contentSize.height, self.m_CollectionView.frame.size.height);
    NSLog(@"tableMaxHEIGHT ====%f",tableMaxHeight);
    if(_refreshFooterView)
    {
        _refreshFooterView.frame = CGRectMake(0.0f,
                                              tableMaxHeight,
                                              _m_CollectionView.frame.size.width,
                                              self.view.bounds.size.height);
    }
    else
    {
        _refreshFooterView =[[EGORefreshTableFooterView alloc] initWithFrame:CGRectMake(0.0f, 0.0f + tableMaxHeight+380, self.m_CollectionView.frame.size.width, self.m_CollectionView.bounds.size.height)];
        [_refreshFooterView setDelegate:self];
        _refreshFooterView.backgroundColor = [UIColor blueColor];
        [_refreshFooterView refreshLastUpdatedDate];
        [self.m_CollectionView addSubview:_refreshFooterView];
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
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.m_CollectionView];
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
//    [self performSelector:@selector(doneLoadingTableHeaderData) withObject:nil afterDelay:3.0];
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
    [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:self.m_CollectionView];
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

-(void)loadDataList
{
    
    NSString *url = @"/customize/media/list?";
    NSString *page_num = @"1";
    //    NSString *page_num = @"1";
    NSLog(@"load Page %@",page_num);
    NSString *page_size = @"15";
    NSString *cid = @"100000";
    NSMutableDictionary *postDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:page_num,@"page_num",page_size,@"page_size",cid,@"cid",nil];
    
    url = [NSString stringWithFormat:@"%@page_num=%@",url,page_num];
    NSLog(@"%@",url);
    [MyDataService requestAFURL:url httpMethod:@"POST" params:postDict data:nil complection:^(id result) {
        NSString *code =[NSString stringWithFormat:@"%@",[result objectForKey:@"code"]];
        if( [code isEqualToString:@"200"] )
        {
//             [self updateData: result AtPageIndex: 1 ];
            self.m_DataArray = [NSMutableArray array];
            NSMutableArray* modelArray = [self parseFromResult:result];
            
            if(modelArray.count > 0)
            {
                [self.m_dataSource addObjectsFromArray:modelArray];
                [self.m_DataArray addObjectsFromArray:self.m_dataSource];
                
                NSLog(@"se++++++++++++==%ld",self.m_DataArray.count);
                
            }

                [self updateCacheInfo:result];
                [self.m_CollectionView reloadData];
                [self setFooterView];
        }
    }];
}
-(void) updateData: (id)result AtPageIndex:(int)pageIndex
{
    
//    self.m_DataArray = [NSMutableArray array];
    NSMutableArray* modelArray = [self parseFromResult:result];
    
    if(modelArray.count > 0)
    {
        [self.m_dataSource addObjectsFromArray:modelArray];
            [self.m_DataArray addObjectsFromArray:self.m_dataSource];
        
        NSLog(@"se++++++++++++==%ld",self.m_DataArray.count);
        
        }
        
        //由于更新了数据，需要更新FooterView
        [self.m_CollectionView reloadData];
        self.currentPage = pageIndex;
        [self setFooterView];
    
//    }

}
//
-(void) loadPage:(int) pageIndex
{
    NSString *url = @"/customize/media/list?";
    NSString *page_num = [NSString stringWithFormat:@"%d",pageIndex];
//    NSString *page_num = @"1";
    NSLog(@"load Page %@",page_num);
    NSString *page_size = @"10";
    NSString *cid = @"100000";
    NSMutableDictionary *postDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:page_num,@"page_num",page_size,@"page_size",cid,@"cid",nil];
    
    url = [NSString stringWithFormat:@"%@page_num=%@",url,page_num];
    NSLog(@"%@",url);
    [MyDataService requestAFURL:url httpMethod:@"POST" params:postDict data:nil complection:^(id result) {
        NSString *code =[NSString stringWithFormat:@"%@",[result objectForKey:@"code"]];
        if( [code isEqualToString:@"200"] )
        {
            [self updateData: result AtPageIndex: pageIndex ];
            [self updateCacheInfo:result];
            
        }
    }];
}
-(NSMutableArray*) parseFromResult:(id)result
{
    NSDictionary *result1 = [result objectForKey:@"result"];
    NSLog(@"result1 == %@",result1);
    NSArray *resuarrary =[result1 objectForKey:@"media_list"];
    NSString* moreFlag = [NSString stringWithFormat:@"%@",[result1 objectForKey:@"is_more"]];
    
    if([moreFlag isEqualToString:@"1"])
    {
        self.hasMore = YES;
    }
    else
    {
        self.hasMore = NO;
    }
    NSMutableArray* modelArray = [NSMutableArray array];
    
    for (NSDictionary *dic in resuarrary) {
        Allstroymodel*model = [[Allstroymodel alloc]initWithDict:dic];
        [modelArray addObject:model];
        NSLog(@"mdoel = %ld",modelArray.count);
//        [self savejson:modelArray];
    }
       return modelArray;
    
}

- (void)savejson:(NSString*)strings{
    NSUserDefaults *selectmodel = [NSUserDefaults standardUserDefaults];
    [selectmodel setObject:strings forKey:@"model"];



}
//-(void)setTodayInfo{
//    [self.todayDaily setTodayInfo:self.todayModel];
//}
//
//-(void)transIntoDetail:(DailyModel*) model
//{
//    NSString *DailyId =model.m_id;
//    NSLog(@"DailyId======%@",DailyId);
//    //    DailyDetailControl *DetailDail = [[DailyDetailControl alloc]initWithConfig:@"" withBackBtn:YES];
//    //    DetailDail.m_URL = model.open_url;
//    //    DetailDail.m_CurrentModel = model;
//    //    NSLog(@"Daily============%@",self.m_DataArray);
//    //    [self presentViewController:DetailDail animated:YES completion:^{
//    //    }];
//}
-(void) updateCacheInfo: (id)result
{
    //TODO 更新数据库中缓存的数据和时间
    NSLog(@"%@",result);
    BOOL ret = [Tools setUpdateTime:@"DAILY_LASTUPDATE"];
    NSLog(@"setUpdateTime's result %d", ret);
    //序列化json内容
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString* serialStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [self savejson:serialStr];
    NSLog(@"SerialStr is %@",serialStr);
//    ret =[Tools setCacheJson: serialStr forKey:@"DAILY_JSON"];
    NSLog(@"setCacheJson result %d", ret);
}
- (void)creatHearButton{
    NSInteger bttop = 28+64+28;
    NSInteger btleft = 42;
    NSInteger btwidth = 186;
    NSInteger btheight = 53;
    
    leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbutton.frame = CGRectMake(btleft*RESIZE_RATIO,
                                  bttop*RESIZE_RATIO,
                                  btwidth*RESIZE_RATIO,
                                  btheight*RESIZE_RATIO);
    [leftbutton setTitle:@"最新下载" forState:UIControlStateNormal];
    [leftbutton setBackgroundImage:[UIImage imageNamed:@"左"] forState:UIControlStateNormal];
    [self.view addSubview:leftbutton];
    [leftbutton setTitleColor:[UIColor ColorWithHexString:@"46b098"] forState:UIControlStateNormal];
    [leftbutton addTarget:self action:@selector(downAction:) forControlEvents:UIControlEventTouchUpInside];
    leftbutton.tag = 10001;
    NSInteger leftbt = btleft+186;
    UIButton * centerBt = [UIButton buttonWithType:UIButtonTypeCustom];
    centerBt.frame = CGRectMake(leftbt*RESIZE_RATIO,
                                bttop*RESIZE_RATIO,
                                btwidth*RESIZE_RATIO,
                                btheight*RESIZE_RATIO);
    [centerBt setTitle:@"我的最爱" forState:UIControlStateNormal];
    [centerBt setBackgroundImage:[UIImage imageNamed:@"中"] forState:UIControlStateNormal];
    [self.view addSubview:centerBt];
    [centerBt setTitleColor:[UIColor ColorWithHexString:@"46b098"] forState:UIControlStateNormal];
    [centerBt addTarget:self action:@selector(downAction:) forControlEvents:UIControlEventTouchUpInside];
    
    centerBt.tag = 10002;
    NSInteger rightleft = leftbt+186;
    UIButton * rightBt = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBt.frame = CGRectMake(rightleft*RESIZE_RATIO,
                               bttop*RESIZE_RATIO,
                               btwidth*RESIZE_RATIO,
                               btheight*RESIZE_RATIO);
    [rightBt setTitle:@"所有故事" forState:UIControlStateNormal];
    rightBt.tag = 10003;
    [rightBt setBackgroundImage:[UIImage imageNamed:@"右"] forState:UIControlStateNormal];
    [self.view addSubview:rightBt];
    [rightBt setTitleColor:[UIColor ColorWithHexString:@"46b098"] forState:UIControlStateNormal];
    [rightBt addTarget:self action:@selector(downAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSInteger topleft = bttop+btheight+12;
    NSInteger leftsearch = 30;
    NSInteger searchWidth = 441+122;
    NSInteger seachHeight = 47;
    
    searchview = [[UIView alloc]initWithFrame:CGRectMake(leftsearch*RESIZE_RATIO,
                                                         topleft*RESIZE_RATIO,
                                                         searchWidth*RESIZE_RATIO,
                                                         seachHeight*RESIZE_RATIO)];
    [self.view addSubview:searchview];
    NSInteger toplefts = 0;
    NSInteger leftsearchs = 0;
    NSInteger searchWidths = 441;
    NSInteger seachHeights = 47;
    searchBt = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBt.frame = CGRectMake(leftsearchs*RESIZE_RATIO,
                                toplefts*RESIZE_RATIO,
                                searchWidths*RESIZE_RATIO,
                                seachHeights*RESIZE_RATIO);
    [searchBt setTitle:@"搜索" forState:UIControlStateNormal];
    
    [searchBt setImage:[UIImage imageNamed:@"fangdajing"] forState:UIControlStateNormal];
    searchBt.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [searchBt setBackgroundImage:[UIImage imageNamed:@"sousuo1"] forState:UIControlStateNormal];
    [searchview addSubview:searchBt];
    [searchBt setTitleColor:[UIColor ColorWithHexString:@"46b098"] forState:UIControlStateNormal];
    [searchBt addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSInteger paxutop = 10;
    NSInteger paxuleft = searchWidths+20;
    NSInteger paxuwidth = 88;
    NSInteger paixuheight = 29;
    paxubt = [UIButton buttonWithType:UIButtonTypeCustom];
    paxubt.frame = CGRectMake(paxuleft*RESIZE_RATIO,
                              paxutop*RESIZE_RATIO,
                              paxuwidth*RESIZE_RATIO,
                              paixuheight*RESIZE_RATIO);
    
    paxubt.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [paxubt setBackgroundImage:[UIImage imageNamed:@"paixu"] forState:UIControlStateNormal];
    [searchview addSubview:paxubt];
    [paxubt addTarget:self action:@selector(paxuAction:) forControlEvents:UIControlEventTouchUpInside];
    searchview .hidden= YES;
    
    
    
    
    
    
}
- (void)downAction:(id)sender{
    UIButton *button = (UIButton*)sender;
    NSInteger itag = button.tag;
    button.selected = YES;
    if (itag!= tags)
    {
        self.oldbutton.selected = NO;
        
    }
    
    if (itag==10001) {
        [button setTitle:@"最新下载" forState:UIControlStateSelected];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageNamed:@"左_check"] forState:UIControlStateSelected];
        [self resueme];
    }else if (itag == 10002){
        
        [button setTitle:@"我的最爱" forState:UIControlStateSelected];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageNamed:@"中_check"] forState:UIControlStateSelected];
        [self resueme];
    }else if (itag==10003){
        [button setTitle:@"所有故事" forState:UIControlStateSelected];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageNamed:@"右_check"] forState:UIControlStateSelected];
        [self allAction];
        
    }
    
    self.oldbutton = button;
    tags = itag;
    
    
}
- (void)allAction{
    NSInteger top = 28+64+53+60+12+20+12;
    self.m_CollectionView.frame = CGRectMake(0, top*RESIZE_RATIO,
                                             FRAME_WIDTH,
                                             FRAME_HEIGHT);
    searchview.hidden = NO;
}
- (void)searchAction:(id)sender{
    
    
}
-(void)resueme{
    searchview.hidden = YES;
    NSInteger top = 28+64+53+60;
    imageview.hidden = YES;
    paxubt.selected = NO;
    self.m_CollectionView.frame = CGRectMake(0,top*RESIZE_RATIO,
                                             FRAME_WIDTH,
                                             FRAME_HEIGHT);
}
-(void)paxuAction:(id)sender{
    UIButton *button = (UIButton*)sender;
    button.selected = !button.selected;
    if (button.selected) {
        [button setBackgroundImage:[UIImage imageNamed:@"paixu2"] forState:UIControlStateSelected];
        [self creatprompt];
    }else {
        
        imageview.hidden = YES;
        
    }
    
}
- (void)creatprompt{
    NSInteger tbtop = 28+64+53+60+30;
    NSInteger tbleft =441+30+10;
    NSInteger tbwidth = 119;
    NSInteger tbheight = 219;
    imageview = [[UIImageView alloc]initWithFrame:CGRectMake(tbleft*RESIZE_RATIO,
                                                             tbtop*RESIZE_RATIO,
                                                             tbwidth*RESIZE_RATIO,
                                                             tbheight*RESIZE_RATIO)];
    imageview.image = [UIImage imageNamed:@"paixubeijng"];
    imageview.userInteractionEnabled = YES;
    
    butarrary = @[@"推荐",@"按时长",@"按热度",@"适龄"];
    for (NSInteger i=0; i<butarrary.count; i++) {
        NSInteger brwidth = 119;
        NSInteger brheight = 219/4;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, i*brheight*RESIZE_RATIO,
                                  brwidth*RESIZE_RATIO,
                                  brheight*RESIZE_RATIO);
        UIImageView *imageviews = [[UIImageView alloc]initWithFrame:CGRectMake(0,
                                                                               button.bottom,
                                                                               brwidth*RESIZE_RATIO,
                                                                               2*RESIZE_RATIO)];
        
        imageviews.image = [UIImage  imageNamed:@"paixujiangexian"];
        NSString*name = butarrary[i];
        [button setTitle:name forState:UIControlStateNormal];
        
        [imageview addSubview:button];
        [imageview addSubview:imageviews];
        
        [self.view addSubview:imageview];
        button.tag = i;
        
        [button addTarget:self action:@selector(titleAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}

-(void)titleAction:(id)sender{
    UIButton *button = (UIButton*)sender;
    if (button.tag ==0 ) {
        NSLog(@"点击推荐了");
        
    }else if (button.tag ==1){
        NSLog(@"点击按时长了");
        
    }else if (button.tag==2) {
        NSLog(@"点击热度了");
    }
    else if (button.tag ==3){
        NSLog(@"点击适龄了");
        
    }
    
}
- (void)finishAction:(id)sender{
    
    CustomizedViewController *custom = [[CustomizedViewController alloc]
                                        initWithConfig:@"哄睡"
                                        withBackBtn:YES withFootBar:YES];
    
    [self presentViewController:custom animated:YES completion:^{
        
    }];
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    leftbutton.selected = YES;
    [self downAction:leftbutton];
    
    
}
- (void)cretMintView{
    NSInteger minleft = 0;
    NSInteger mintop =  890+64+64;
    NSInteger minwidth = FRAME_WIDTH;
    NSInteger minheight = 120;
    NSInteger minlabsizae = 22;
    
    UIView *minView = [[UIView alloc]initWithFrame:CGRectMake(minleft*RESIZE_RATIO,
                                                              mintop*RESIZE_RATIO,
                                                              minwidth,
                                                              minheight*RESIZE_RATIO)];
    
    
    
    minView .backgroundColor = [UIColor ColorWithHexString:@"46b098"];
    [self.view addSubview:minView];
    NSInteger leftlab = 30;
    NSInteger  toplab = 30;
    NSInteger  widthlab = 80;
    NSInteger heightlab = 40;
    UILabel *finishLable = [[UILabel alloc]initWithFrame:CGRectMake(leftlab*RESIZE_RATIO,
                                                                    toplab*RESIZE_RATIO,
                                                                    widthlab*RESIZE_RATIO,
                                                                    heightlab*RESIZE_RATIO)];
    finishLable.text = @"已完成:";
    finishLable.textColor = [UIColor whiteColor];
    finishLable.font = [UIFont systemFontOfSize:minlabsizae*RESIZE_RATIO];
    [minView addSubview:finishLable];
    
    NSInteger leftmin = leftlab+widthlab;
    NSInteger  topmin = 30;
    NSInteger  widthmin = 90;
    NSInteger heightmin = 40;
    minLable = [[UILabel alloc]initWithFrame:CGRectMake(leftmin*RESIZE_RATIO,
                                                                 topmin*RESIZE_RATIO,
                                                                 widthmin*RESIZE_RATIO,
                                                                 heightmin*RESIZE_RATIO)];
    minLable.text = [NSString stringWithFormat:@"%ld 分钟",(long)totalTime];
    minLable.textColor = [UIColor whiteColor];
    minLable.font = [UIFont systemFontOfSize:minlabsizae*RESIZE_RATIO];
    [minView addSubview:minLable];
    
    NSInteger leftcount = leftmin+widthmin;
    NSInteger  topcount = 30;
    NSInteger  widthcount = 120;
    NSInteger heightcount = 40;
    UILabel *countLable = [[UILabel alloc]initWithFrame:CGRectMake(leftcount*RESIZE_RATIO,
                                                                   topcount*RESIZE_RATIO,
                                                                   widthcount*RESIZE_RATIO,
                                                                   heightcount*RESIZE_RATIO)];
    countLable.text = @" (个)";
    countLable.textColor = [UIColor whiteColor];
    countLable.font = [UIFont systemFontOfSize:minlabsizae*RESIZE_RATIO];
    [minView addSubview:countLable];
    
    NSInteger leftsettime = leftcount+widthcount;
    NSInteger  topsettime = 30;
    NSInteger  widthsettime = 80;
    NSInteger heightsettime = 40;
    UILabel *settimeLable = [[UILabel alloc]initWithFrame:CGRectMake(leftsettime*RESIZE_RATIO,
                                                                     topsettime*RESIZE_RATIO,
                                                                     widthsettime*RESIZE_RATIO,
                                                                     heightsettime*RESIZE_RATIO)];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults ];
    NSString *checkstaue = [user objectForKey:@"checkstaue"];
    if ([checkstaue isEqualToString:@"1"]) {
        NSLog(@"时间优先");
        countLable.text = @" / 设定时间:";
        
    }else if ([checkstaue isEqualToString:@"2"]){
        
      countLable.text = @" / 设定个数:";
        
        }

    countLable.textColor = [UIColor whiteColor];
    countLable.font = [UIFont systemFontOfSize:minlabsizae*RESIZE_RATIO];
    [minView addSubview:settimeLable];
    
    
    
    NSInteger leftmins = leftsettime;
    NSInteger  topmins = 30;
    NSInteger  widthmins = 100;
    NSInteger heightmins = 40;
    minLables= [[UILabel alloc]initWithFrame:CGRectMake(leftmins*RESIZE_RATIO,
                                                                 topmins*RESIZE_RATIO,
                                                                 widthmins*RESIZE_RATIO,
                                                                 heightmins*RESIZE_RATIO)];
    minLables.text = @" 45 分钟";
    [self checkseletecells];
    minLables.textColor = [UIColor whiteColor];
    minLables.font = [UIFont systemFontOfSize:minlabsizae*RESIZE_RATIO];
    [minView addSubview:minLables];
    
    
    
    NSInteger leftcountss = leftmins+widthmins;
    NSInteger  topcountss = 30;
    NSInteger  widthcountss = 120;
    NSInteger heightcountss = 40;
    UILabel *countLabless = [[UILabel alloc]initWithFrame:CGRectMake(leftcountss*RESIZE_RATIO,
                                                                     topcountss*RESIZE_RATIO,
                                                                     widthcountss*RESIZE_RATIO,
                                                                     heightcountss*RESIZE_RATIO)];
    countLabless.text = @"(个)";
    countLabless.textColor = [UIColor whiteColor];
    countLabless.font = [UIFont systemFontOfSize:minlabsizae*RESIZE_RATIO];
    [minView addSubview:countLabless];
    
    
}
-(void)seletecells:(NSInteger)index{

    NSInteger row = index-10000;
    NSLog(@"row===%ld",(long)row);
    [self.selectIndex removeObject:[NSString stringWithFormat:@"%ld",row]];
    Allstroymodel *model = [self.m_DataArray objectAtIndex:row];
    NSString *ids = model.m_id;
    NSLog(@"ids==%@",ids);
    [setarrary removeObject:ids];
    NSInteger mins = model.duration;
    totalTime -=mins;
    if (totalTime<0) {
        return;
    }else{
    minLable.text = [NSString stringWithFormat:@"%ld 分钟",(long)totalTime/60];
    }
    NSUserDefaults *selectStroy = [NSUserDefaults standardUserDefaults];
    [selectStroy setObject:setarrary forKey:@"setid"];
    [selectStroy synchronize];

    
}

-(void)checkseletecells{

    NSUserDefaults *user = [NSUserDefaults standardUserDefaults ];
    NSString *checkstaue = [user objectForKey:@"checkstaue"];
    if ([checkstaue isEqualToString:@"1"]) {
        NSLog(@"时间优先");

        NSString*str = [user objectForKey:@"times"];
        NSLog(@"str1===%@",str);
        minLables.text = [NSString stringWithFormat:@"%@ 分钟",str];
    
        
    }else if ([checkstaue isEqualToString:@"2"]){
    
           NSLog(@" 个数优先");
     NSString*str = [user objectForKey:@"count"];
    
    minLables.text = [NSString stringWithFormat:@"%@ 分钟",str];
    
    
    }
}



@end
