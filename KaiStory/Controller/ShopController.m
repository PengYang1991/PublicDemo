//
//  ShopController.m
//  KaiStory
//
//  Created by mac on 15/2/6.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "ShopController.h"
#import "Tools.h"
#import "UIColor+HexStringToColor.h"
#import "DefineControllerViewController.h"
#import "Wheelcell.h"

@interface ShopController (){
    UITableView *tableViews;
    UITableView *countTable;
    UIImageView *timeImageView;
    UIImageView *countImageView ;
    NSString *checkstring;

}
@end
@implementation ShopController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.baseContentView.userInteractionEnabled = NO;
    [self createTitleView];
}

- (void)createTitleView{
    NSInteger imageHeight = 1000;
    NSInteger imageWidth = 640;
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64,
                                                                          imageWidth*RESIZE_RATIO, imageHeight*RESIZE_RATIO)];
    imageview.image = [UIImage imageNamed:@"小熊"];
    [self.view insertSubview:imageview belowSubview:self.customButton];
    //创建自定义定制按钮
    NSInteger witdh = 525;
    NSInteger leftwith = 60;
    NSInteger butop = 26;
    NSInteger fButtonHeight = 73;
    NSInteger titletop = 560;
    self.customButton.frame = CGRectMake(leftwith*RESIZE_RATIO, 64 + titletop*RESIZE_RATIO, witdh*RESIZE_RATIO, fButtonHeight*RESIZE_RATIO);
    [self.customButton setTitle:@"自定义哄睡" forState:UIControlStateNormal];
    [self.customButton addTarget:self action:@selector(defineAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.sleepRecomend.frame = CGRectMake(leftwith*RESIZE_RATIO,
                                          self.customButton.frame.origin.y+fButtonHeight*RESIZE_RATIO+butop*RESIZE_RATIO,
                                          witdh*RESIZE_RATIO,
                                          fButtonHeight*RESIZE_RATIO);
    
    [self.sleepRecomend setTitle:@"哄睡推荐" forState:UIControlStateNormal];
    
    self.mySleepRecomend.frame = CGRectMake(leftwith*RESIZE_RATIO,
                                            self.sleepRecomend.frame.origin.y+fButtonHeight*RESIZE_RATIO+butop*RESIZE_RATIO,
                                            witdh*RESIZE_RATIO,
                                            fButtonHeight*RESIZE_RATIO);
    [self.mySleepRecomend setTitle:@"我的推荐" forState:UIControlStateNormal];
    
    
}


- (void)defineAction:(id)sender{
    flickView.hidden = NO;
    backButon.hidden = NO;
    NSLog(@"自定义哄睡");
    UIView *flackView = [self creatFlickView];
    [self.view addSubview:flackView];
}

//创建弹出框
- (UIView*)creatFlickView{
    if (flickView==nil||backButon==nil) {
        NSInteger fltop =182;
        NSInteger flleft = 50;
        NSInteger flwidth = 541;
        NSInteger flheight = 778;
        
        flickView = [[UIView alloc]initWithFrame:CGRectMake(flleft*RESIZE_RATIO,fltop*RESIZE_RATIO, flwidth*RESIZE_RATIO, flheight*RESIZE_RATIO)];
        
        UIImageView*imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, flwidth*RESIZE_RATIO, flheight*RESIZE_RATIO)];
        
        imageview.image = [UIImage imageNamed:@"beijing"];
        [flickView insertSubview:imageview aboveSubview:self.view];
        
        NSInteger leftbutton = 30;
        NSInteger btheight = 38;
        NSInteger btWitdh = 21;
        NSInteger btBottom = 20;
        backButon = [UIButton buttonWithType:UIButtonTypeCustom];
        backButon.frame = CGRectMake(leftbutton,
                                     64-btBottom*RESIZE_RATIO-btheight*RESIZE_RATIO,
                                     btWitdh*RESIZE_RATIO, btheight*RESIZE_RATIO);
        [self.view addSubview:backButon];
        [backButon addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [backButon setBackgroundImage:[UIImage imageNamed:@"返回上一页.png"] forState:UIControlStateNormal];
        [self creatpriorityView];
        [self creatCountPriority];
    }
    return flickView;
}
- (void)cancelAction:(id)sender{
    
    [flickView removeFromSuperview];
    backButon.hidden = YES;
}
//创建时间优先的view
- (void)creatpriorityView{
    NSInteger timeTop = 200;
    NSInteger timeleft = 60;
    NSInteger timewidth = 424;
    NSInteger timeheight = 132;
    images = [[UIImageView alloc]initWithFrame:CGRectMake(timeleft*RESIZE_RATIO,
                                                          timeTop*RESIZE_RATIO, timewidth*RESIZE_RATIO, timeheight*RESIZE_RATIO)];
    
    images.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer  alloc]initWithTarget:self action:@selector(tapAction:)];
    [images addGestureRecognizer:tap];
    images.image = [UIImage imageNamed:@"anniuxuanze"];
    [flickView addSubview:images];
    
    NSInteger lableft = 70;
    NSInteger latop = 56;
    NSInteger lawidth = 110;
    NSInteger  laheight =20;
    NSInteger  labsize = 26;
    timeLabe = [[UILabel alloc]initWithFrame:CGRectMake(lableft*RESIZE_RATIO,
                                                        latop*RESIZE_RATIO,
                                                        lawidth*RESIZE_RATIO,
                                                        laheight*RESIZE_RATIO)];
    timeLabe.text = @"时间优先";
    timeLabe.textAlignment = NSTextAlignmentCenter;
    timeLabe.font = [UIFont systemFontOfSize:labsize*RESIZE_RATIO];
    timeLabe.textColor = [UIColor whiteColor];
    [images addSubview:timeLabe];
    
    NSInteger imaLeft = lableft+lawidth+36;
    NSInteger imatop = 8;
    NSInteger imawidth = 73;
    NSInteger imaheight =117;
    timeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(imaLeft*RESIZE_RATIO,
                                                                 imatop*RESIZE_RATIO,
                                                                 imawidth*RESIZE_RATIO,
                                                                 imaheight*RESIZE_RATIO)];
    timeImageView.userInteractionEnabled = YES;
    timeImageView.image = [UIImage imageNamed:@"zhuanlun"];
    [images  addSubview:timeImageView];
    
    NSInteger minleft = imaLeft+imawidth+36;
    NSInteger mintop = 58;
    NSInteger minwidth = 30;
    NSInteger  minlaheight =20;
    NSInteger  minlabsize = 14;
    mintimeLabe = [[UILabel alloc]initWithFrame:CGRectMake(minleft*RESIZE_RATIO,
                                                           mintop*RESIZE_RATIO,
                                                           minwidth*RESIZE_RATIO,
                                                           minlaheight*RESIZE_RATIO)];
    mintimeLabe.text = @"分钟";
    mintimeLabe.textAlignment = NSTextAlignmentCenter;
    mintimeLabe.font = [UIFont systemFontOfSize:minlabsize*RESIZE_RATIO];
    mintimeLabe.textColor = [UIColor whiteColor];
    [images addSubview:mintimeLabe];
    array = [NSMutableArray arrayWithObjects:@" ",@"5",@"10",@"15",@"20",@"25",@"30",@"35",@"40",@"45",@"50",@"55",@"60",@" ", nil];
    
    NSInteger width = 73;
    NSInteger height = 112;
    tableViews = [[UITableView alloc]initWithFrame:CGRectMake(imaLeft*RESIZE_RATIO,imatop*RESIZE_RATIO,
                                                              width*RESIZE_RATIO, height*RESIZE_RATIO) style:UITableViewStylePlain];
    tableViews.backgroundView = timeImageView;
    tableViews.backgroundColor = [UIColor clearColor];
    NSLog(@"117*RESIZE_RATIO/3*2==%f",116*RESIZE_RATIO/3*2);
    tableViews.layer.cornerRadius = 16;
    tableViews.layer.masksToBounds = YES;
    tableViews.delegate = self;
    tableViews.dataSource = self;
    if ([tableViews respondsToSelector:@selector(setSeparatorInset:)]){
        [tableViews setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableViews respondsToSelector:@selector(setLayoutMargins:)]){
        [tableViews setLayoutMargins:UIEdgeInsetsZero];
        NSArray *arrary = [tableViews  subviews];
        NSLog(@"aooon==%lu",(unsigned long)arrary.count);
    }
    
    tableViews.contentOffset = CGPointMake(0,116*RESIZE_RATIO/3*2);
    [tableViews registerClass:[Wheelcell class] forCellReuseIdentifier:@"abc"];
    
    [images  addSubview:tableViews];
    
}
//创建个数优先的view
-(void)creatCountPriority{
    NSInteger timeTop = 200+117+48;
    NSInteger timeleft = 60;
    NSInteger timewidth = 424;
    NSInteger timeheight = 132;
    countimage= [[UIImageView alloc]initWithFrame:CGRectMake(timeleft*RESIZE_RATIO,
                                                             timeTop*RESIZE_RATIO, timewidth*RESIZE_RATIO, timeheight*RESIZE_RATIO)];
    countimage.image = [UIImage imageNamed:@"anniuxuanze"];
    countimage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer  alloc]initWithTarget:self action:@selector(countAction:)];
    [countimage addGestureRecognizer:tap];
    
    [flickView addSubview:countimage];
    
    NSInteger lableft = 70;
    NSInteger latop = 56;
    NSInteger lawidth = 110;
    NSInteger  laheight =20;
    NSInteger  labsize = 26;
    countLabe = [[UILabel alloc]initWithFrame:CGRectMake(lableft*RESIZE_RATIO,
                                                         latop*RESIZE_RATIO,
                                                         lawidth*RESIZE_RATIO,
                                                         laheight*RESIZE_RATIO)];
    countLabe.text = @"个数优先";
    countLabe.textAlignment = NSTextAlignmentCenter;
    countLabe.font = [UIFont systemFontOfSize:labsize*RESIZE_RATIO];
    countLabe.textColor = [UIColor whiteColor];
    [countimage addSubview:countLabe];
    
    NSInteger imaLeft = lableft+lawidth+36;
    NSInteger imatop = 8;
    NSInteger imawidth = 73;
    NSInteger imaheight =117;
    countImageView = [[UIImageView alloc]initWithFrame:CGRectMake(imaLeft*RESIZE_RATIO,
                                                                  imatop*RESIZE_RATIO,
                                                                  imawidth*RESIZE_RATIO,
                                                                  imaheight*RESIZE_RATIO)];
    countImageView.userInteractionEnabled = YES;
    countImageView.image = [UIImage imageNamed:@"zhuanlun"];
    [countimage  addSubview:countImageView];
    
    NSInteger minleft = imaLeft+imawidth+36;
    NSInteger mintop = 58;
    NSInteger minwidth = 30;
    NSInteger  minlaheight =20;
    NSInteger  minlabsize = 14;
    selfLabe = [[UILabel alloc]initWithFrame:CGRectMake(minleft*RESIZE_RATIO,
                                                        mintop*RESIZE_RATIO,
                                                        minwidth*RESIZE_RATIO,
                                                        minlaheight*RESIZE_RATIO)];
    selfLabe.text = @"个";
    selfLabe.textAlignment = NSTextAlignmentCenter;
    selfLabe.font = [UIFont systemFontOfSize:minlabsize*RESIZE_RATIO];
    selfLabe.textColor = [UIColor whiteColor];
    [countimage addSubview:selfLabe];
    
    NSInteger width = 73;
    NSInteger heights = 112;
    countTable= [[UITableView alloc]initWithFrame:CGRectMake(imaLeft*RESIZE_RATIO,imatop*RESIZE_RATIO,
                                                             width*RESIZE_RATIO,
                                                             heights*RESIZE_RATIO)
                                            style:UITableViewStylePlain];
    countTable.backgroundView = countImageView;
    countTable.backgroundColor = [UIColor clearColor];
    [countTable setSeparatorInset:UIEdgeInsetsZero];
    
    if ([countTable respondsToSelector:@selector(setSeparatorInset:)]){
        [countTable setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([countTable respondsToSelector:@selector(setLayoutMargins:)]){
        [countTable setLayoutMargins:UIEdgeInsetsZero];
        NSArray *arrary = [countTable  subviews];
        NSLog(@"aooon==%lu",(unsigned long)arrary.count);
    }
    
    [countTable registerClass:[Wheelcell class] forCellReuseIdentifier:@"abc"];
    countTable.contentOffset = CGPointMake(0,116*RESIZE_RATIO/3*2);
    
    countTable.layer.cornerRadius = 10;
    countTable.layer.masksToBounds = YES;
    countTable.delegate = self;
    countTable.dataSource = self;
    countArrary = [NSMutableArray arrayWithObjects:@" ",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@" ", nil];
    [countTable  reloadData];
    [countimage addSubview:countTable];
    
    NSInteger leftbutton = 60;
    NSInteger bttop =timeTop+132+70;
    NSInteger btheight = 70;
    NSInteger btWitdh = 424;
    backButons = [UIButton buttonWithType:UIButtonTypeCustom];
    backButons.frame = CGRectMake(leftbutton*RESIZE_RATIO,
                                  bttop*RESIZE_RATIO,
                                  btWitdh*RESIZE_RATIO,
                                  btheight*RESIZE_RATIO);
    [backButons setTitle:@"确定" forState:UIControlStateNormal];
    [flickView addSubview:backButons];
    [backButons addTarget:self action:@selector(certain:) forControlEvents:UIControlEventTouchUpInside];
    [backButons setBackgroundImage:[UIImage imageNamed:@"queding"] forState:UIControlStateNormal];
    
    
    NSInteger left = 423;
    NSInteger top =48;
    NSInteger height = 30;
    NSInteger Witdh = 100;
    UIButton * jumpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    jumpButton.frame = CGRectMake(left*RESIZE_RATIO,
                                  top*RESIZE_RATIO,
                                  Witdh*RESIZE_RATIO,
                                  height*RESIZE_RATIO);
    [jumpButton setTitle:@"跳过" forState:UIControlStateNormal];
    jumpButton .titleLabel.font = [UIFont systemFontOfSize:labsize*RESIZE_RATIO];
    [flickView addSubview:jumpButton];
    [jumpButton addTarget:self action:@selector(jumpAction:) forControlEvents:UIControlEventTouchUpInside];
}
//跳过事件
- (void)jumpAction:(id)sender{
    
    DefineControllerViewController *define = [[DefineControllerViewController alloc]initWithConfig:@"哄睡" withBackBtn:YES];
    [self.navigationController pushViewController:define animated:YES];
    
}
#pragma tableView协议方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:tableViews]) {
        return  array.count;
    }else{
        return countArrary.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Wheelcell *cell = [tableView dequeueReusableCellWithIdentifier:@"abc"];
    if (!cell) {
        cell = [[Wheelcell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"abc"];
        
    }
    NSInteger lablesize = 22;
    NSInteger bigsize = 32;
    if ([tableView isEqual:tableViews]) {
        cell.lables.text = array[indexPath.row];
        NSLog(@"skkk==%@",cell.lables.text);
        cell.lables.textColor = [UIColor ColorWithHexString:@"e1e3e3"];
        cell.lables.textAlignment = NSTextAlignmentCenter;
    }else{
        cell.lables.text = countArrary[indexPath.row];
        
    }
    
    cell.lables.textAlignment = NSTextAlignmentCenter;
    cell.lables.font = [UIFont systemFontOfSize:lablesize*RESIZE_RATIO];
    cell.lables.textColor = [UIColor ColorWithHexString:@"e1e3e3"];
    NSLog(@"50.456250==%f",tableView.contentOffset.y);
    NSLog(@"116*RESIZE_RATIO/3*2==%f",(int)116*RESIZE_RATIO/3*2);
    if (tableView.contentOffset.y == (int)(116*RESIZE_RATIO/3*2)) {
        
        NSArray *arr = [tableView visibleCells];
        NSLog(@"arr==%lu",(unsigned long)arr.count);
        if (arr.count==3) {
            Wheelcell *cells = [arr objectAtIndex:2];
            cells.lables.textColor = [UIColor ColorWithHexString:@"46b098"];;
            cells.lables.font = [UIFont systemFontOfSize:bigsize*RESIZE_RATIO];
        }
        
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 116*RESIZE_RATIO/3;
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    UITableView *tableView = (UITableView*)scrollView;
    if ([tableView isEqual:tableViews]) {
        [self tapAction:tableViews];
    }else{
        
        [self countAction:countTable];
        
    }
    NSInteger lablesize = 22;
    NSInteger bigsize = 32;
    int index = (int)scrollView.contentOffset.y/(int)(scrollView.frame.size.height/3);
    if((int)scrollView.contentOffset.y%117*RESIZE_RATIO/3/2<117*RESIZE_RATIO/3/2){
        
        scrollView.contentOffset = CGPointMake(0, index*(117*RESIZE_RATIO/3));
        UITableView *tableView = (UITableView*)scrollView;
        NSLog(@"%ld",tableView.visibleCells.count);
        if ([tableView visibleCells].count==3) {
            Wheelcell *cell = [[tableView visibleCells] objectAtIndex:1];
            cell.lables.font = [UIFont systemFontOfSize:bigsize*RESIZE_RATIO];
            cell.lables.textColor = [UIColor ColorWithHexString:@"46b098"];
            [self checkString:cell.lables.text table:tableView];
            
        }
        
        Wheelcell *cell1 = [[tableView visibleCells] firstObject];
        cell1.lables.font = [UIFont systemFontOfSize:lablesize*RESIZE_RATIO];
        cell1.lables.textColor = [UIColor ColorWithHexString:@"e1e3e3"];
        Wheelcell *cell2 = [[tableView visibleCells] lastObject];
        cell2.lables.font = [UIFont systemFontOfSize:lablesize*RESIZE_RATIO];
        cell2.lables.textColor = [UIColor ColorWithHexString:@"e1e3e3"];
        
    }else if((int)scrollView.contentOffset.y%117*RESIZE_RATIO/3/2>=117*RESIZE_RATIO/3/2){
        scrollView.contentOffset = CGPointMake(0, (index+1)*(117*RESIZE_RATIO/3));
        UITableView *tableView = (UITableView*)scrollView;
        if ([tableView visibleCells].count==3) {
            Wheelcell *cell = [[tableView visibleCells] objectAtIndex:1];
            cell.lables.font = [UIFont systemFontOfSize:bigsize*RESIZE_RATIO];
            cell.lables.textColor = [UIColor ColorWithHexString:@"46b098"];
            [self checkString:cell.lables.text table:tableView];
            
        }
        
        Wheelcell *cell1 = [[tableView visibleCells] firstObject];
        cell1.lables.font = [UIFont systemFontOfSize:lablesize *RESIZE_RATIO];
        cell1.lables.textColor = [UIColor ColorWithHexString:@"e1e3e3"];
        Wheelcell *cell2 = [[tableView visibleCells] lastObject];
        cell2.lables.font = [UIFont systemFontOfSize:lablesize*RESIZE_RATIO];
        cell2.lables.textColor = [UIColor ColorWithHexString:@"e1e3e3"];
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger lablesize = 22;
    NSInteger bigsize = 32;
    int index = (int)scrollView.contentOffset.y/(int)(scrollView.frame.size.height/3);
    if((int)scrollView.contentOffset.y%117*RESIZE_RATIO/3/2<(int)(117*RESIZE_RATIO/3/2)){
        scrollView.contentOffset = CGPointMake(0, index*(117*RESIZE_RATIO/3));
        UITableView *tableView = (UITableView*)scrollView;
        NSLog(@"snnn==%ld",[tableView visibleCells].count);
        NSLog(@"%ld",tableView.visibleCells.count);
        if ([tableView visibleCells].count==3) {
            Wheelcell *cell = [[tableView visibleCells] objectAtIndex:1];
            cell.lables.font = [UIFont systemFontOfSize:bigsize*RESIZE_RATIO];
            cell.lables.textColor = [UIColor ColorWithHexString:@"46b098"];
            [self checkString:cell.lables.text table:tableView];
        }
        
        Wheelcell *cell1 = [[tableView visibleCells] firstObject];
        cell1.lables.font = [UIFont systemFontOfSize:lablesize*RESIZE_RATIO];
        cell1.lables.textColor = [UIColor ColorWithHexString:@"e1e3e3"];
        Wheelcell *cell2 = [[tableView visibleCells] lastObject];
        cell2.lables.font = [UIFont systemFontOfSize:lablesize*RESIZE_RATIO];
        cell2.lables.textColor = [UIColor ColorWithHexString:@"e1e3e3"];
        
    }else if((int)scrollView.contentOffset.y%117*RESIZE_RATIO/3/2>=117*RESIZE_RATIO/3/2){
        
        scrollView.contentOffset = CGPointMake(0, (index+1)*(117*RESIZE_RATIO/3));
        UITableView *tableView = (UITableView*)scrollView;
        if ([tableView visibleCells].count==3) {
            Wheelcell *cell = [[tableView visibleCells] objectAtIndex:1];
            cell.lables.font = [UIFont systemFontOfSize:bigsize*RESIZE_RATIO];
            cell.lables.textColor = [UIColor ColorWithHexString:@"46b098"];
            [self checkString:cell.lables.text table:tableView];
        }
        
        Wheelcell *cell1 = [[tableView visibleCells] firstObject];
        cell1.lables.font = [UIFont systemFontOfSize:lablesize *RESIZE_RATIO];
        cell1.lables.textColor = [UIColor blackColor];
        Wheelcell *cell2 = [[tableView visibleCells] lastObject];
        cell2.lables.font = [UIFont systemFontOfSize:lablesize*RESIZE_RATIO];
        cell2.lables.textColor = [UIColor blackColor];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)tapAction:(id)sender{
    countImageView.image = [UIImage imageNamed:@"zhuanlun"];
    timeImageView.image = [UIImage imageNamed:@"zhuanlun2"];
    countimage.image = [UIImage imageNamed:@"anniuxuanze"];
    countLabe.textColor = [UIColor whiteColor];
    selfLabe.textColor = [UIColor whiteColor];
    [backButons setBackgroundImage:[UIImage imageNamed:@"queding2"] forState:UIControlStateNormal];
    [backButons setTitleColor:[UIColor ColorWithHexString:@"46b098"] forState:UIControlStateNormal];
    images.image = [UIImage imageNamed:@"anniuxuanze2"];
    timeLabe.textColor = [UIColor ColorWithHexString:@"46b098"];
    mintimeLabe.textColor = [UIColor ColorWithHexString:@"46b098"];
}
-(void)countAction:(id)sender{
    countImageView.image = [UIImage imageNamed:@"zhuanlun2"];
    timeImageView.image = [UIImage imageNamed:@"zhuanlun"];
    [backButons setBackgroundImage:[UIImage imageNamed:@"queding2"] forState:UIControlStateNormal];
    [backButons setTitleColor:[UIColor ColorWithHexString:@"46b098"] forState:UIControlStateNormal];
    images.image = [UIImage imageNamed:@"anniuxuanze"];
    timeLabe.textColor = [UIColor whiteColor];
    mintimeLabe.textColor = [UIColor whiteColor];
    countimage.image =[UIImage imageNamed:@"anniuxuanze2"];
    countLabe.textColor = [UIColor ColorWithHexString:@"46b098"];
    selfLabe.textColor = [UIColor ColorWithHexString:@"46b098"];
    
}
- (void)certain:(id)sender{
    if (checkstring==nil) {
        NSLog(@"您还没制定哄睡方案");
    }else{
        DefineControllerViewController *define = [[DefineControllerViewController alloc]initWithConfig:@"哄睡" withBackBtn:YES];
        [self.navigationController pushViewController:define animated:YES];
    }
    
}
//选去故事时间或者故事个数

- (void)checkString:(NSString *)strt table:(UITableView*)tabes{
        NSLog(@"sdfsd===%@,sssss==%@",checkstring,tabes);
    if ([tabes isEqual: tableViews]) {
        NSLog(@"sdfsd===%@,sssss==%@",checkstring,tabes);
        NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
        [userdefault setObject:@"1" forKey:@"checkstaue"];
        [userdefault setObject:strt forKey:@"times"];
         checkstring = strt;
    }else {
        checkstring = strt;
        NSLog(@"个数优先");
        NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
        [userdefault setObject:@"2" forKey:@"checkstaue"];
        [userdefault setObject:strt forKey:@"count"];


    }
    
}

@end
