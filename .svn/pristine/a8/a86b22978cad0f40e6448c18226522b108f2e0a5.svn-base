//
//  ThreeViewController.m
//  KaiStory
//
//  Created by mac on 15/3/23.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "ThreeViewController.h"
#import "MyDataService.h"
#import "CustomAlertView.h"
#import "ThreeModel.h"
#import "UIImageView+WebCache.h"

#import "Tools.h"

#import "MainViewController.h"
#import "GuideViewController.h"

#import "UserShareInfo.h"
#import "UserInfo.h"



@interface ThreeViewController ()
{
    UIImageView *m_imageView;
    BOOL isLoadFlag;
    NSTimer * m_Timer;
}

@end

@implementation ThreeViewController
- (void)viewWillAppear:(BOOL)animated   {
    [super viewWillAppear:animated];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"findload" object:self];




}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    isLoadFlag = NO;
    
    // Do any additional setup after loading the view from its nib.
    m_imageView =[[UIImageView alloc]init];
    [m_imageView setFrame:CGRectMake(0, 0,FRAME_WIDTH , FRAME_HEIGHT)];
    [self.view addSubview:m_imageView];
    
    NSString* splashDefault = [Tools getRawData:@"SPLASH_DEFAULT"];
    
    //如果没有设置过default数据，则采用默认的三秒页图片
    if([Tools isBlankString:splashDefault])
    {
        [m_imageView setImage:[UIImage imageNamed:@"三秒页"]];
    }else
    {
        // 如果设置过default数据，采用default数据
        NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        UIImage *loadImg = [self loadImage:@"SPLASH_DEFAULT" ofType:@"png" inDirectory:documentsDirectoryPath];
        [m_imageView setImage:loadImg];
    }
    
    NSDate* today = [NSDate date];
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    fmt.dateFormat = @"yyyy-MM-dd";
    self.todayStr = [fmt stringFromDate:today];
    
    NSString* cacheDate = [Tools getRawData:@"SPLASH_CACHE_DATE"];
    if(![self.todayStr isEqualToString:cacheDate])
    {
        NSLog(@"Today not request Splash");
        [self LoadData];
    }else
    {
        NSLog(@"Today already request Splash");
    }
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
    
    NSString *appid = @"xx";
    NSString *app_ver = @"1.0";
    NSString *json_ver = @"0.1";
    NSString *ln = @"33.332";
    NSString *lat = @"199.3232";
   
    NSMutableDictionary *dir = [NSMutableDictionary dictionaryWithObjectsAndKeys:appid,@"appid",app_ver,@"app_ver",json_ver,@"json_ver",ln,@"lng",lat,@"lat",nil];
    [MyDataService requestAFURL:@"/res/splash/get" httpMethod:@"GET" params:dir data:nil complection:^(id result) {
 
        NSString *code =[NSString stringWithFormat:@"%@",[result objectForKey:@"code"]];
        if( [code isEqualToString:@"200"] )
        {
             NSLog(@"Code is %@",code);
            
            NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            
            NSDictionary *result1 = [result objectForKey:@"result"];
            NSDictionary *splash = [result1 objectForKey:@"splash"];
            ThreeModel *model =[[ThreeModel alloc]initWithDict:splash];
            NSString* splashImgUrlStr = model.splash_img;
            NSString* versionStr = model.version;
            NSLog(@"SplashImg: %@; verionStr %@", splashImgUrlStr,versionStr);
            NSString* splashCached = [Tools getRawData:@"SPLASH_CACHE"];
            NSString* splashDefault = [Tools getRawData:@"SPLASH_DEFAULT"];
            NSLog(@"Cache: %@; default %@", splashCached,splashDefault);
            
            if([versionStr isEqualToString:@"default"])
            {
                if([splashDefault isEqualToString:splashImgUrlStr])
                {
                    UIImage *loadImg = [self loadImage:@"SPLASH_DEFAULT" ofType:@"png" inDirectory:documentsDirectoryPath];
                    [m_imageView setImage:loadImg];
                    [Tools setRawData:self.todayStr forKey:@"SPLASH_CACHE_DATE"];
                }
                else
                {
                    UIImage *SaveImage = [self getImageFromURL:splashImgUrlStr];
                    [self saveImage:SaveImage withFileName:@"SPLASH_DEFAULT" ofType:@"png" inDirectory:documentsDirectoryPath];
                    [Tools setRawData:splashImgUrlStr forKey:@"SPLASH_DEFAULT"];
                    [m_imageView setImage:SaveImage];
                    [Tools setRawData:self.todayStr forKey:@"SPLASH_CACHE_DATE"];
                    isLoadFlag = YES;
                }
            }else
            {
                if([splashCached isEqualToString:splashImgUrlStr])
                {
                    UIImage *loadImg = [self loadImage:@"SPLASH_CACHE" ofType:@"png" inDirectory:documentsDirectoryPath];
                    [m_imageView setImage:loadImg];
                    [Tools setRawData:self.todayStr forKey:@"SPLASH_CACHE_DATE"];
                }
                else
                {
                    UIImage *SaveImage = [self getImageFromURL:splashImgUrlStr];
                    [self saveImage:SaveImage withFileName:@"SPLASH_CACHE" ofType:@"png" inDirectory:documentsDirectoryPath];
                    [Tools setRawData:splashImgUrlStr forKey:@"SPLASH_CACHE"];
                    [m_imageView setImage:SaveImage];
                    [Tools setRawData:self.todayStr forKey:@"SPLASH_CACHE_DATE"];
                    isLoadFlag = YES;
                }
            }
        }

    }]; 
}
-(void)ExchangeViewController
{
    if(isLoadFlag)
    {
        isLoadFlag = NO;
        NSLog(@"LOAD SUCCESS");
        m_Timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(ExchangeViewController) userInfo:nil repeats:NO];
    }else
    {
        [m_Timer invalidate];
        MainViewController *mainViewContr = [[MainViewController alloc]init];
        [self presentViewController:mainViewContr animated:YES completion:^{}];
    }
}

-(UIImage *) getImageFromURL:(NSString *)fileURL {
    UIImage * result;
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    return result;
}

-(void) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
    if ([[extension lowercaseString] isEqualToString:@"png"]) {
        [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
    } else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"]) {
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
    } else {
        NSLog(@"文件后缀不认识");
    }
}


-(UIImage *) loadImage:(NSString *)fileName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
    UIImage * result = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.%@", directoryPath, fileName, extension]];
    return result;
}


@end
