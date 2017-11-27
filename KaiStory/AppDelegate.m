//
//  AppDelegate.m
//  KaiStory
//
//  Created by mac on 15/2/10.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "AppDelegate.h"
#import "tabbarView.h"
#import "Tools.h"
//#import "SqliteControl.h"

#import "ThreeViewController.h"

//#import "UMSocial.h"
#import "MainViewController.h"
#import "GuideViewController.h"
#import "LoginDataService.h"
//#import "UMSocialWechatHandler.h"
//#import "UMSocialQQHandler.h"
//#import "UMSocialSinaSSOHandler.h"

#import "UserShareInfo.h"


@interface AppDelegate ()
{
    NSTimer * m_Timer;
    ThreeViewController *m_ThreeView;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self SQLliteConfig];
    [[UserShareInfo sharedSingleton] addStoryListenDay];
    
    //程序第一次安装运行
    if ([Tools isFirstStartUp])
    {
        GuideViewController *guideViewControl = [[GuideViewController alloc]init];
        [self.window setRootViewController:guideViewControl];
        
    }else{
        m_Timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(ThreeViewHiden) userInfo:nil repeats:NO];
        m_ThreeView = [[ThreeViewController alloc]init];
        [self.window setRootViewController:m_ThreeView];
        [self.window makeKeyAndVisible];
    }

    [[UIApplication sharedApplication]beginReceivingRemoteControlEvents];
    [self resignFirstResponder];
    
    
//    [UMSocialData setAppKey:UMENGAPPKEY];
    
    
    //打开调试log的开关
//    [UMSocialData openLog:YES];
    
    //如果你要支持不同的屏幕方向，需要这样设置，否则在iPhone只支持一个竖屏方向
//    [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskAll];
    
    //设置微信AppId，设置分享url，默认使用友盟的网址
//    [UMSocialWechatHandler setWXAppId:WX_APP_ID appSecret:WX_APP_SECRET url:@"http://www.umeng.com/social"];
    
    //打开新浪微博的SSO开关
    //    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
//    [UMSocialSinaSSOHandler openNewSinaSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    //打开腾讯微博SSO开关，设置回调地址，只支持32位
//    [UMSocialTencentWeiboHandler openSSOWithRedirectUrl:@"http://sns.whalecloud.com/tencent2/callback"];
    
    //    //设置分享到QQ空间的应用Id，和分享url 链接
//    [UMSocialQQHandler setQQWithAppId:QQ_QZONE_ID appKey:QQ_QZONE_KEY url:@"http://www.umeng.com/social"];
    //    //设置支持没有客户端情况下使用SSO授权
//    [UMSocialQQHandler setSupportWebView:YES];
    
   
    return YES;
}

//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
//{
////    return  [UMSocialSnsService handleOpenURL:url];
//    return YES;
//}
//- (BOOL)application:(UIApplication *)application
//            openURL:(NSURL *)url
//  sourceApplication:(NSString *)sourceApplication
//         annotation:(id)annotation
//{
////    return  [UMSocialSnsService handleOpenURL:url];
//}

-(void)ThreeViewHiden{
    [m_Timer invalidate];
    [m_ThreeView ExchangeViewController];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [application beginReceivingRemoteControlEvents];
    [application beginBackgroundTaskWithExpirationHandler:nil];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//     [UMSocialSnsService  applicationDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:ISPLAYING];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


-(void)SQLliteConfig
{
    self.m_SqlControl = [SqliteControl sharedController];
    self.FirstRunning = [self.m_SqlControl openSqlite];
    NSLog(@"%id",self.FirstRunning);
    self.appConfigDataDictionary=[NSMutableDictionary dictionaryWithDictionary:[self.m_SqlControl findTableInfo:@"app_config" tablefield:nil]];
    NSLog(@"程序配置数据 %@",self.appConfigDataDictionary);
}
-(void)SQLiteTest{
    
//    NSMutableDictionary *historyDic = [NSMutableDictionary dictionary];
//    int storyId = 5;
//    NSString *StoryName = @"beijing";
//    historyDic[@"LunBo_id"] = [NSString stringWithFormat:@"%d",storyId];
//    historyDic[@"name"] =StoryName;
//
//    
//    NSArray *array00 = [[SqliteControl sharedController] selectTableInfo:@"LunBoList" tablefield:[NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:storyId] forKey:@"LunBo_id"]];
//    //    if (array00.count <= 0) {
////    BOOL sqlite = [[SqliteControl sharedController] insertTableInfo:@"LunBoList" tablefield:historyDic];
//    BOOL sqlite1 = [[SqliteControl sharedController] insertTableInfo:@"LunBoList" tablefield:historyDic];
//    //    }
//    
//    NSMutableDictionary *historyDic1 = [NSMutableDictionary dictionary];
//    int storyId1 = 5;
//    NSString *name =@"shanghai";
//    historyDic1[@"LunBo_id"] = [NSString stringWithFormat:@"%d",storyId];
//    historyDic1[@"name"] =name;
//    NSArray *array13= [[SqliteControl sharedController] selectTableInfo:@"LunBoList" tablefield:nil];
//    NSLog(@"abc======================%@",array13);
////    BOOL delete = [[SqliteControl sharedController]deleteTableInfo:@"LunBoList" tablefield:historyDic];
////    BOOL ChangeStatus = [[SqliteControl sharedController]updateTableInfo:@"LunBoList" tablefield:historyDic1];
//    BOOL ChangeStatus = [[SqliteControl sharedController]updateTableInfo:@"LunBoList" tablefield:historyDic1 withOtherField:[NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:storyId] forKey:@"LunBo_id"]];
//    
//    
//    
//    NSArray *array12= [[SqliteControl sharedController] selectTableInfo:@"LunBoList" tablefield:nil];
//    NSLog(@"abc======================%@",array12);
  NSArray *arrary = [[SqliteControl sharedController] selectTableInfo:@"Test" tablefield:nil];
    NSLog(@"arrr==%lu",(unsigned long)arrary.count);
}
//-(void)LoadThreeData{
//    NSString *appid = @"xx";
//    NSString *app_ver = @"1.0";
//    NSString *json_ver = @"0.1";
//    NSString *ln = @"33.332";
//    NSString *lat = @"199.3232";
//    
//    // http://test.api.kaishuhezi.com/online-api/res/splash/get
//    // /sys/splash/get?appid=xx&app_ver=1.0&json_ver=&lng=&lat=
//    
//    NSMutableDictionary *dir = [NSMutableDictionary dictionaryWithObjectsAndKeys:appid,@"appid",app_ver,@"app_ver",json_ver,@"json_ver",ln,@"lng",lat,@"lat",nil];
//    [LoginDataService requestAFURL1:@"http://test.api.kaishuhezi.com/online-api/res/splash/get" httpMethod:@"GET" params:dir data:nil complection:^(id result) {
//        NSString *code =[result objectForKey:@"code"];
//        NSLog(@"code=======%@",code);
//        NSString *msg = [result objectForKey:@"msg"];
//        NSLog(@"msg========%@",msg);
//        NSDictionary *result1 = [result objectForKey:@"result"];
//        NSDictionary *splash = [result1 objectForKey:@"splash"];
//        NSLog(@"result1=====%@",splash);
//        self.m_CurrentThreemodel =[[ThreeModel alloc]initWithDict:splash];
//        NSLog(@"result=======%@",result);
//    }];
//    
//}
@end
