//
//  ClassViewController.m
//  KaiStory
//
//  Created by mac on 15/4/14.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "ClassViewController.h"
#import "LoginDataService.h"
#import "ClassModel.h"
#import "ClassPropertyView.h"
#import "KSStoryListController.h"
#import "Tools.h"


@interface ClassViewController ()
{
    ClassListVIew *classview;
    ClassPropertyView *propertyview;
}

@end

@implementation ClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSInteger displayAreaHeight = [super getContentHeight];
    
    scorllView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, FRAME_WIDTH, displayAreaHeight)];
    scorllView.contentSize = CGSizeMake(FRAME_WIDTH,FRAME_HEIGHT*2);
    scorllView.showsHorizontalScrollIndicator = YES;
    scorllView.showsVerticalScrollIndicator = YES;
    [self.view addSubview:scorllView];
    self.dataSoure = [NSMutableArray array];
    self.propertyViewArray  = [NSMutableArray array];
    self.propertyListArray  =[NSMutableArray array];
    
    
    
    NSLog(@"Result===========%f",RESIZE_RATIO);
    NSLog(@"Width============%f",FRAME_WIDTH);
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DisplayPorpertyList:) name:@"DisplayPorperty" object:self.m_updateIndex];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(HidenPorpertyList:) name:@"HidenPorperty" object:self.m_updateIndex];
    
    
    [self LoadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)LoadData{
    NSString *moreURL = @"http://test.api.kaishuhezi.com/api/res/property/value/list?";
    
    NSString *app_ver = @"1.0";
    NSString *page_num = @"2";
    NSString *page_size = @"10";
    NSString *json_ver = @"0.1";
    NSString *ln = @"33.332";
    NSString *lat = @"199.3232";
    NSString *cid = @"100000";
    NSMutableDictionary *dir = [NSMutableDictionary dictionaryWithObjectsAndKeys:app_ver,@"app_ver",page_num,@"page_num",page_size,@"page_size",json_ver,@"json_ver",ln,@"lng",lat,@"lat",cid,@"cid",nil];
    [LoginDataService requestAFURL1:moreURL httpMethod:@"POST" params:dir data:nil complection:^(id result) {
        NSLog(@"result==========%@",result);
//        NSString *code = [result valueForKey:@"code"];
//        NSString *msg = [result valueForKey:@"msg"];
        NSDictionary *Result = [result valueForKey:@"result"];
//        NSString *version = [Result valueForKey:@"version"];
        NSDictionary *view_content = [Result valueForKey:@"view_content"];
        NSDictionary *show_data = [view_content valueForKey:@"show_data"];
        NSDictionary *show_category_more = [show_data valueForKey:@"show_category_more"];
        NSLog(@"abc==========%@",show_category_more);
        NSArray *uuy = [NSArray arrayWithArray:[show_data objectForKey:@"show_category_more"]];
        NSLog(@"show_data========%@",uuy);
        
        
        NSInteger i = 0;
        CGFloat titleheight = 30;
        CGFloat Listheight = 240;
        CGFloat currentLoaction = 0.0;
        CGFloat contentViewHeight = 0;
        for (NSDictionary *dic in uuy)
        {
            ClassModel *model = [[ClassModel alloc]initWithDict:dic];
            NSArray * tt = [model.property_value_list copy];
            for (NSDictionary *dict in tt)
            {
                PropertyModel *Model = [[PropertyModel alloc]initWithDict:dict];
                [model.propertyList addObject:Model];
            }
            NSLog(@"=========%ld",(unsigned long)model.propertyList.count);
            classview = [[ClassListVIew alloc]initWithFrameRect:CGRectMake(0, 0,FRAME_WIDTH, titleheight) dataSource:model :i];
            classview.tag = i;

            int number = model.propertyList.count;
            int row = 0;
            
            row = (number +2)/3;
            Listheight = row *110;
            classview.propertyview = [[ClassPropertyView alloc]initWithFrameRect:CGRectMake(0, 0, FRAME_WIDTH, Listheight*RESIZE_RATIO) dataSource:model:i];
            classview.propertyview.EnterClassDetailDelegate = self;
            if (i==0 || i==1)
            {
                classview.isDisplay = 1;
                [classview setFrame:CGRectMake(0, currentLoaction, FRAME_WIDTH, titleheight)];
                currentLoaction = currentLoaction +titleheight;
                [scorllView addSubview:classview];
                [classview.propertyview setFrame:CGRectMake(0, currentLoaction, FRAME_WIDTH, classview.propertyview.frame.size.height)];
                [scorllView addSubview:classview.propertyview];
                classview.rightBtn.selected = YES;
                currentLoaction = currentLoaction +classview.propertyview.frame.size.height;
                contentViewHeight += (titleheight + classview.propertyview.frame.size.height);
                
            }else
            {
                [classview setFrame:CGRectMake(0, currentLoaction, FRAME_WIDTH, titleheight)];
                currentLoaction = currentLoaction + titleheight;
                [scorllView addSubview:classview];
                classview.rightBtn.selected = NO;
                contentViewHeight += titleheight;
            }
           
            [self.propertyViewArray addObject:classview];
            [self SetViewData];
            
            model.m_Index = i;
            [self.dataSoure addObject:model];
            
            i= i+1;

        }
        scorllView.contentSize = CGSizeMake(FRAME_WIDTH,contentViewHeight);
//        NSLog(@"=========%ld",self.dataSoure.count);
    }];
}
-(void)SetViewData{
    for (ClassListVIew *view in self.propertyViewArray) {
        NSLog(@"Class.tag==========%ld",(long)view.tag);
    }
    for (ClassPropertyView * view in self.propertyListArray) {
         NSLog(@"PropertyView.tag==========%ld",(long)view.tag);
        if (view.tag == 2) {
            NSLog(@"PropertyView.name==========%@",view);
        }
        
    }
    
}



-(void)ISDisplay:(NSInteger)index
{
   

}


-(void)DisplayPorpertyList:(NSNotification *)sender{
    
    NSString *updateIndex  = sender.object;
    NSInteger index = [updateIndex integerValue];
//    NSLog(@"Display Index %ld", index);
    CGFloat currentLocation = 0.0;
    CGFloat titleheight = 30;
//    CGFloat Listheight = 200;
    CGFloat middValue = 0.0;
    
    for ( ClassListVIew  *view in self.propertyViewArray)
    {
        
        if (view.tag ==index)
        {
            NSLog(@"abc");
            NSLog(@"ListProperty=======%f",view.propertyview.frame.size.height);
            
            
            currentLocation = view.frame.origin.y +titleheight;
            [view.propertyview setFrame:CGRectMake(0, currentLocation, FRAME_WIDTH, view.propertyview.frame.size.height)];
            [scorllView addSubview:view.propertyview];
            currentLocation = currentLocation + view.propertyview.frame.size.height;
            view.isDisplay = 1;
            middValue = view.propertyview.frame.size.height;
            scorllView.contentSize = CGSizeMake(FRAME_WIDTH,scorllView.contentSize.height+view.propertyview.frame.size.height);
            NSLog(@"abc======%ld,%f",(long )view.tag,scorllView.contentSize.height);
        }
        
        if(view.tag > index)
        {
            [view setFrame:CGRectMake(0, view.frame.origin.y + middValue, FRAME_WIDTH, titleheight)];
            currentLocation = view.frame.origin.y + view.propertyview.frame.size.height +titleheight;
            if (view.isDisplay == 1)
            {

                [view.propertyview  setFrame:CGRectMake(0, view.frame.origin.y  +titleheight, FRAME_WIDTH, view.propertyview.frame.size.height)];
            }
        }
        
    }


    NSLog(@"显示第几行＝＝＝＝＝＝＝%f",currentLocation);
   
}

-(void)HidenPorpertyList:(NSNotification *)sender
{
    NSString *updateIndex  = sender.object;
   
    NSInteger index = [updateIndex integerValue];
    CGFloat currentLocation = 0.0;
    CGFloat titleheight = 30;
//    CGFloat Listheight = 200;
    CGFloat middValue = 0.0;
    
    for (ClassListVIew *listView in self.propertyViewArray)
    {
        if (listView.tag ==index)
        {
            currentLocation = listView.frame.origin.y + titleheight;
            [listView.propertyview removeFromSuperview];
            middValue = listView.propertyview.frame.size.height;
            scorllView.contentSize = CGSizeMake(FRAME_WIDTH,scorllView.contentSize.height-listView.propertyview.frame.size.height);
            NSLog(@"隐藏第几行＝＝＝＝＝＝＝%@,%f",updateIndex,scorllView.contentSize.height);
        }
        if (listView.tag >index)
        {
            currentLocation = listView.frame.origin.y;
            [listView setFrame:CGRectMake(0, currentLocation - middValue, FRAME_WIDTH, titleheight)];
            currentLocation  = listView.frame.origin.y +titleheight;
            [listView.propertyview setFrame:CGRectMake(0, currentLocation, FRAME_WIDTH, listView.propertyview.frame.size.height)];
            currentLocation  = listView.propertyview.frame.origin.y +listView.propertyview.frame.size.height;
        }

    }

}

-(void)dealloc{
//    [[UIApplication sharedApplication]removeObserver:self forKeyPath:@"DisplayPorperty"];
//    [[UIApplication sharedApplication]removeObserver:self forKeyPath:@"HidenPorperty"];
}
-(void)EnterStoryDetail:(PropertyModel *)propertymodel
{
    NSLog(@"故事名字＝＝＝＝＝＝＝＝ %@",propertymodel.property_vaule_name);
    KSStoryListController* controller = [[KSStoryListController alloc]initWithConfig:propertymodel.property_vaule_name withBackBtn:YES withFootBar:YES];
    controller.requestUrl = propertymodel.open_url;
    controller.requestParams = propertymodel.open_params;
    [self presentViewController:controller animated:YES completion:^{}];
}

-(void)backBtnAction:(id)sender{
     [self dismissViewControllerAnimated:YES completion:^(){}];
}
@end
