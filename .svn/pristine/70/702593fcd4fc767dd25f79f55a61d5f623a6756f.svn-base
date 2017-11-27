//
//  GuideViewController.m
//  KaiStory
//
//  Created by mac on 15/3/23.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "GuideViewController.h"
#import "Tools.h"
#import "babyCardView.h"
#import "MainViewController.h"

@interface GuideViewController ()

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.m_ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, FRAME_WIDTH, FRAME_HEIGHT)];
    self.m_ScrollView.contentSize = CGSizeMake(FRAME_WIDTH * GuideTimes, FRAME_HEIGHT);
    self.m_ScrollView.showsHorizontalScrollIndicator = NO;
    self.m_ScrollView.showsVerticalScrollIndicator = NO;
    self.m_ScrollView.pagingEnabled = YES;
    self.m_ScrollView.bounces = NO;
    self.m_ScrollView.delegate = self;
    [self.view addSubview:self.m_ScrollView];
    
    for (int i= 0; i<GuideTimes; i++) {
        UIImageView *imageView= [[UIImageView alloc]initWithFrame:CGRectMake(i*FRAME_WIDTH, 0, FRAME_WIDTH, FRAME_HEIGHT)];
        if(i<GuideTimes-1)
        {
            NSString *name = [NSString stringWithFormat:@"guide-%d",i+1];
            imageView.image =[UIImage imageNamed:name];
        }else
        {
            imageView.image =[UIImage imageNamed:@"BG"];
        }
        [self.m_ScrollView addSubview:imageView];
    }
    self.m_pageControl = [[pageController alloc]initWithFrame:CGRectMake(0, FRAME_HEIGHT - 50, FRAME_WIDTH, 20)];
    self.m_pageControl.numberOfPages = GuideTimes;
    self.m_pageControl.currentPage = 0;
    [self.view addSubview:self.m_pageControl];
    
    self.babyNameView = [[BabyCardView alloc]initWithFrame:CGRectMake((GuideTimes - 1)*FRAME_WIDTH, 0, FRAME_WIDTH, FRAME_HEIGHT)];
    [self.babyNameView.enterBtn addTarget:self action:@selector(EnterApp) forControlEvents:UIControlEventTouchUpInside];
    [self.m_ScrollView addSubview:self.babyNameView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)EnterApp
{
    //标记不再是首次进入。
    [Tools setNotFirstStartUp];
    
    //存储性别和年龄
    [Tools setBabyAge:self.babyNameView.age];
    [Tools setBabySex:self.babyNameView.sex];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //进入页面
    MainViewController *mainViewContr = [[MainViewController alloc]init];
    [self presentViewController:mainViewContr animated:YES completion:^{
        
    }];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int CurrentPage = fabs(self.m_ScrollView.contentOffset.x)/self.m_ScrollView.frame.size.width;
    self.m_pageControl.currentPage = CurrentPage;
}

@end
