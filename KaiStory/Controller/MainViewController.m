//
//  MainViewController.m
//  KaiStory
//
//  Created by mac on 15/2/7.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "MainViewController.h"
#import "BaseNavigationContr.h"
#import "BaseViewContr.h"
#import "tabbarView.h"

#import "CustomController.h"
#import "BabyPlayerController.h"
#import "ShopController.h"
#import "BabyController.h"
#import "FirstController.h"
#import "StoryModel.h"
#import "SqliteControl.h"





#define theApp ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface MainViewController ()
{
    StoryModel *storyItem;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    for (UIView *uv in self.tabBar.subviews)
    {
        [uv removeFromSuperview];
    }
    
    storyItem = [[StoryModel alloc]init];
    
    // Do any additional setup after loading the view from its nib.
    NSMutableArray *_ViewControllers = [NSMutableArray array];
    
    self.firstController = [[FirstController alloc]initWithConfig:@"发现" withBackBtn:NO];
    [self.firstController setTitle:@"首页"];
    BaseNavigationContr *FirstNavigation = [[BaseNavigationContr alloc]initWithRootViewController:self.firstController];
    [FirstNavigation setNavigationBarHidden:YES];
    [_ViewControllers addObject:FirstNavigation];
#pragma mark - 商城
    self.ShopContr = [[ShopController alloc]initWithConfig:@"哄睡" withBackBtn:NO];
    BaseNavigationContr *ShopNavigation = [[BaseNavigationContr alloc]initWithRootViewController:self.ShopContr];
    [self.ShopContr setTitle:@"商城"];
    [ShopNavigation setNavigationBarHidden:YES];
    [_ViewControllers addObject:ShopNavigation];

    #pragma mark - 播放器
        self.PlayerContr = [[BabyPlayerController alloc]initWithConfig:@"播放器" withBackBtn:YES];
        BaseNavigationContr *PlayerNavigation = [[BaseNavigationContr alloc]initWithRootViewController:self.PlayerContr];
        [self.PlayerContr setTitle:@"播放器"];
    [PlayerNavigation setNavigationBarHidden:YES];
//        [_ViewControllers addObject:PlayerNavigation];

#pragma mark - 定制
    self.CustomContr = [[CustomController alloc]initWithConfig:@"日课" withBackBtn:NO];
    [self.CustomContr setTitle:@"定制"];
    BaseNavigationContr *CustomNavigation = [[BaseNavigationContr alloc]initWithRootViewController:self.CustomContr];
    [CustomNavigation setNavigationBarHidden:YES];
    [_ViewControllers addObject:CustomNavigation];
    
    #pragma mark - 我
        self.MyContr = [[BabyController alloc]initWithConfig:@"宝宝" withBackBtn:NO];
        [self.MyContr setTitle:@"我"];
        BaseNavigationContr *MyNavigation = [[BaseNavigationContr alloc]initWithRootViewController:self.MyContr];
    [MyNavigation setNavigationBarHidden:YES];
        [_ViewControllers addObject:MyNavigation];
    
    self.m_ViewControllers = [NSArray arrayWithArray:_ViewControllers];
    //self.tabBarController.viewControllers = self.m_ViewControllers;
    self.viewControllers = self.m_ViewControllers;
    
    self.m_tabbarView = [[tabbarView alloc]initWithFrame:CGRectMake(0,FRAME_HEIGHT-TABBAR_HEIGHT*RESIZE_RATIO,FRAME_WIDTH,TABBAR_HEIGHT*RESIZE_RATIO)];
    self.m_tabbarView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.m_tabbarView];
    self.m_tabbarView.delegate = self;
    
    [self setSelectedIndex:0];
    self.m_tabbarView.m_MainBt.selected = YES;
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(HideTabbarView) name:@"HideTabbar" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ShowTabbarView) name:@"ShowTabbar" object:nil];
    
    
}
-(void)HideTabbarView{
    self.m_tabbarView.hidden = YES;
    self.tabBar.hidden = YES;
    
}
-(void)ShowTabbarView{
    self.m_tabbarView.hidden = NO;
    self.tabBar.hidden = NO;
}

-(void)touchBtnAtIndex:(NSInteger)index
{
    switch (index) {
            
        case 1:
            [self setSelectedIndex:0];
            break;
        case 2:
           [self setSelectedIndex:1];
            break;
        case 3:
           storyItem.m_id = @"－1";
           //self.PlayerContr.story = storyItem;
            [self presentViewController:self.PlayerContr animated:YES completion:^{
                
            }];
            break;
        case 4:
            [self setSelectedIndex:2];
            break;
        default:
            [self setSelectedIndex:3];
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)GuideViewLoad
{
    
}

-(void)dealloc{
    [[UIApplication sharedApplication]removeObserver:self forKeyPath:@"HideTabbar"];
    [[UIApplication sharedApplication]removeObserver:self forKeyPath:@"ShowTabbar"];
}


@end
