//
//  DailyDetailControl.m
//  KaiStory
//
//  Created by mac on 15/3/23.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "DailyDetailControl.h"
#import "Tools.h"
#import "LoginDataService.h"
#import "UIColor+HexStringToColor.h"
#import "UserShareInfo.h"
#import "ShareView.h"
//#import "UMSocialDataService.h"
//#import "UMSocialSnsPlatformManager.h"

#import "SDWebImage/SDWebImageManager.h"
#import "UIImageView+WebCache.h"

#import "MyDataService.h"


@interface DailyDetailControl ()
{
    UIWebView *m_WebView;
}

@end

@implementation DailyDetailControl


-(void) initLayout
{
    int const titleMarginLeft = 20;
    int const titleMarginTop = 12 *RESIZE_RATIO;
    int const titleFontSize = 30;
    NSString* titleFontColorStr = @"656565";
    UIColor *titleFontColor = [UIColor ColorWithHexString:titleFontColorStr];
    self.artileTitleLabel =[[UILabel alloc] initWithFrame:CGRectMake(titleMarginLeft*RESIZE_RATIO, titleMarginTop, FRAME_WIDTH-2*titleMarginLeft*RESIZE_RATIO, titleFontSize*RESIZE_RATIO)];
    
    self.artileTitleLabel.font = [UIFont boldSystemFontOfSize:titleFontSize*RESIZE_RATIO];
    self.artileTitleLabel.textColor =titleFontColor;
    if( NO == [Tools isBlankString:self.m_CurrentModel.title])
    {
        self.artileTitleLabel.text = self.m_CurrentModel.title;
    }
    [self.baseContentView addSubview:self.artileTitleLabel];
    
    
    int const timeMarginLeft = 20;
    int const timeMarginTop = titleMarginTop + (titleFontSize + 8)*RESIZE_RATIO;
    int const timeFontSize = 18;
    NSString* timeFontColorStr = @"9d9e9e";
    UIColor *timeFontColor = [UIColor ColorWithHexString:timeFontColorStr];
    self.releaseLabel = [[UILabel alloc] initWithFrame:CGRectMake(timeMarginLeft*RESIZE_RATIO, timeMarginTop, FRAME_WIDTH-2*timeMarginLeft*RESIZE_RATIO, timeFontSize*RESIZE_RATIO)];
    self.releaseLabel.font = [UIFont boldSystemFontOfSize:timeFontSize*RESIZE_RATIO];
    self.releaseLabel.textColor =timeFontColor;
    if( NO == [Tools isBlankString:self.m_CurrentModel.release_date])
    {
        self.releaseLabel.text = self.m_CurrentModel.release_date;
    }
    [self.baseContentView addSubview:self.releaseLabel];
    
    
    int const webViewMarginTop = timeMarginTop + (timeFontSize + 10)*RESIZE_RATIO;
    //TODO
    m_WebView = [[UIWebView alloc]initWithFrame:CGRectMake(0,webViewMarginTop,FRAME_WIDTH,
                                                           [self getContentHeight]-webViewMarginTop)];
    
    
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:self.m_URL]];
    [self.baseContentView addSubview:m_WebView];
    [m_WebView loadRequest:request];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //int barViewHeight = 40+88;

    int const iconMarginTop = 50;
    int const iconSize=40;
    int const infoTxtFontSize = 24;
    int const infoTxtMarginTop = iconMarginTop + 4;
    int const fontLength = 50;
    NSString* infoTxtFontColor = @"4ab19a";
    UIColor *infoFontColor = [UIColor ColorWithHexString:infoTxtFontColor];
    
    int const commentIconMarginLeft = 640-346;
    int const commentFontMarginLeft = commentIconMarginLeft + iconSize +4;
    self.commentBtn = [[UIButton alloc] initWithFrame:CGRectMake(commentIconMarginLeft*RESIZE_RATIO, iconMarginTop*RESIZE_RATIO, iconSize*RESIZE_RATIO, iconSize*RESIZE_RATIO)];
    [self.commentBtn setImage:[UIImage imageNamed:@"评论-01.png"] forState:UIControlStateNormal];
    self.Comment_count = [[UILabel alloc] initWithFrame:CGRectMake(commentFontMarginLeft*RESIZE_RATIO, infoTxtMarginTop*RESIZE_RATIO, fontLength*RESIZE_RATIO, infoTxtFontSize*RESIZE_RATIO)];
    
    self.Comment_count.font = [UIFont boldSystemFontOfSize:infoTxtFontSize*RESIZE_RATIO];
    self.Comment_count.textColor =infoFontColor;
    if(NO ==  [Tools isBlankString:self.m_CurrentModel.comment_count])
    {
        self.Comment_count.text = self.m_CurrentModel.comment_count;
    }
    [self.view addSubview:self.commentBtn];
    [self.view addSubview:self.Comment_count];
    
    int const shareIconMarginLeft = 640 - 226;
    int const shareFontMarginLeft = shareIconMarginLeft+ iconSize+4;
    self.shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(shareIconMarginLeft*RESIZE_RATIO, iconMarginTop*RESIZE_RATIO, iconSize*RESIZE_RATIO, iconSize*RESIZE_RATIO)];
     [self.shareBtn setImage:[UIImage imageNamed:@"评论-02.png"] forState:UIControlStateNormal];
    
    [self.shareBtn addTarget:self action:@selector(ShareAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.Share_count = [[UILabel alloc] initWithFrame:CGRectMake(shareFontMarginLeft*RESIZE_RATIO, infoTxtMarginTop*RESIZE_RATIO, fontLength*RESIZE_RATIO, infoTxtFontSize*RESIZE_RATIO)];
    self.Share_count.font = [UIFont boldSystemFontOfSize:infoTxtFontSize*RESIZE_RATIO];
    self.Share_count.textColor =infoFontColor;
    if(NO ==  [Tools isBlankString:self.m_CurrentModel.share_count])
    {
        self.Share_count.text = self.m_CurrentModel.share_count;
    }
    [self.view addSubview:self.shareBtn];
    [self.view addSubview:self.Share_count];
    
    
    int const favorIconMarginLeft = 640 - 109;
    int const favorFontMarginLeft = favorIconMarginLeft+ iconSize + 4;
    self.favorBtn = [[UIButton alloc] initWithFrame:CGRectMake(favorIconMarginLeft*RESIZE_RATIO, iconMarginTop*RESIZE_RATIO, iconSize*RESIZE_RATIO, iconSize*RESIZE_RATIO)];
         [self.favorBtn setImage:[UIImage imageNamed:@"收藏_日课.png"] forState:UIControlStateNormal];
    [self.favorBtn setImage:[UIImage imageNamed:@"已经收藏.png"] forState:UIControlStateSelected];
    [self.favorBtn addTarget:self action:@selector(favorBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.favorCount = [[UILabel alloc] initWithFrame:CGRectMake(favorFontMarginLeft*RESIZE_RATIO, infoTxtMarginTop*RESIZE_RATIO, fontLength*RESIZE_RATIO, infoTxtFontSize*RESIZE_RATIO)];
    self.favorCount.font = [UIFont boldSystemFontOfSize:infoTxtFontSize*RESIZE_RATIO];
    self.favorCount.textColor =infoFontColor;
    if(NO ==  [Tools isBlankString:self.m_CurrentModel.favor_count])
    {
        self.favorCount.text = self.m_CurrentModel.favor_count;
    }
    [self.view addSubview:self.favorBtn];
    [self.view addSubview:self.favorCount];
    
    [self initLayout];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if([[UserShareInfo sharedSingleton].lovedDailyArray containsObject:  self.m_DailyID  ])
    {
        self.favorBtn.selected = YES;
        NSInteger currentFavorCount =[self.favorCount.text integerValue];
        self.favorCount.text = [NSString stringWithFormat:@"%d",currentFavorCount+1];
    }
    else
    {
        self.favorBtn.selected = NO;
    }
}

-(void)favorBtnClick :(id)sender
{
    NSInteger currentFavorCount =[self.favorCount.text integerValue];
    if(self.favorBtn.selected)
    {
      
        [[UserShareInfo sharedSingleton] removeLoveDaily: self.m_DailyID ];
        currentFavorCount = currentFavorCount-1 > 0 ? currentFavorCount-1: 0;
        self.favorCount.text = [NSString stringWithFormat:@"%ld",currentFavorCount];
    }else
    {
        [[UserShareInfo sharedSingleton] addLoveDaily:  self.m_DailyID  ];
        self.favorCount.text = [NSString stringWithFormat:@"%ld",currentFavorCount+1];
        NSString *dailyModelStr = [[NSKeyedArchiver archivedDataWithRootObject:self.m_CurrentModel] base64Encoding];
        NSString *dailyKey = [NSString stringWithFormat:@"DAILYINFO_%@",self.m_DailyID ];
        [Tools setCacheJson:dailyModelStr forKey:dailyKey];
    }
    self.favorBtn.selected = !self.favorBtn.selected;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    
}

-(void)backBtnAction:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^(){}];
}
-(void)ShareAction:(id)sender
{
    ShareView *shareView = [[ShareView alloc]initWithFrameRect:CGRectMake(0, 64, FRAME_WIDTH, FRAME_HEIGHT - 64)];
    shareView.m_shareDelegate = self;
    [self.view addSubview:shareView];

}
//-(void)SelectShare : (NSInteger)index
//{
//       NSString *shareText = @"友盟社会化组件可以让移动应用快速具备社会化分享、登录、评论、喜欢等功能，并提供实时、全面的社会化数据统计分析服务。http://sports.sina.com.cn/nba/?sinatracker=baidu_ala_sports_nba_general&dpc=1";
//    //分享内嵌文字
//    UIImage *shareImage = [UIImage imageNamed:@"小熊.png"];        //分享内嵌图片
//    
//    NSLog(@"URL=======%@",self.m_CurrentModel.img_url);
//    
//    NSURL *url = [NSURL URLWithString:self.m_CurrentModel.img_url];
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    UIImage *image = [UIImage imageWithData:data];
//
//    
//       [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeDefault url:@"http://weibo.com/5597152432/profile?topnav=1&wvr=6"];
//    
//    switch (index) {
//        case 55:
//            NSLog(@"微信分享");
//
//               [UMSocialData defaultData].extConfig.wechatSessionData.title = @"微信好友title";
//               [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://baidu.com";
//                [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:shareText image:image location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
//                    if (response.responseCode == UMSResponseCodeSuccess) {
//                        NSLog(@"分享成功！");
//                    }
//                }];
//            break;
//        case 56:
//            NSLog(@"QQ空间");
//            [UMSocialData defaultData].extConfig.qzoneData.title = @"Qzone分享title";
//            [UMSocialData defaultData].extConfig.qzoneData.url = @"http://baidu.com";
//            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQzone] content:shareText image:shareImage location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
//                if (response.responseCode == UMSResponseCodeSuccess) {
//                    NSLog(@"分享成功！");
//                }
//            }];
//            break;
//        case 57:
//            NSLog(@"新浪微博");        
//            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:shareText image:shareImage location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
//                if (response.responseCode == UMSResponseCodeSuccess) {
//                    NSLog(@"分享成功！");
//                }
//            }];
//            break;
//        case 58:
//            NSLog(@"朋友圈");
//            [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"微信好友title";
//            [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://baidu.com";
//            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:shareText image:shareImage location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
//                if (response.responseCode == UMSResponseCodeSuccess) {
//                    NSLog(@"分享成功！");
//                }
//            }];
//            break;
//            
//        default:
//            break;
//    }
//}

@end
