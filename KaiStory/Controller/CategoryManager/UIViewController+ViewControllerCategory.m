

#import "UIViewController+ViewControllerCategory.h"
#import <MediaPlayer/MediaPlayer.h>
#import "AudioPlayManager.h"
#import "UIImageView+WebCache.h"
#import "Tools.h"


@implementation UIViewController (ViewControllerCategory)

- (void)setNavigationBarWithTitle:(NSString *)title titleColor:(UIColor *)color backgroundColor:(UIColor *)bgColor{
    
    [self.view setBackgroundColor:[UIColor whiteColor]];

    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        if (bgColor) {
            self.navigationController.navigationBar.barTintColor = bgColor;
        }
    }else{
        //        self.navigationController.navigationBar.tintColor = UINavigationBarColor;
    }
    
    
    if (title && title.length > 0) {
        self.title = title;
    }
    
    if (color) {
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    }
}

- (void)setNavigationBarWithImage:(UIImage *)image{
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

- (void)setLeftNavigationItemWithImage:(UIImage *)image target:(id)target action:(SEL)action{
    
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.frame = CGRectMake(0, 0, 17, 22);
    [left setImage:image forState:UIControlStateNormal];
    [left addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:left];
}

- (UIButton *)setRightNavigationItemWithImage:(UIImage *)image target:(id)target action:(SEL)action{
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(0, 0, 34, 34);
    [right setImage:image forState:UIControlStateNormal];
    [right addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    return right;
}


#pragma mark - 
#pragma mark 进入后台

- (void)callPhone:(CTCallCenter *)callCenter{
    
    if (self.callCenter) {
        self.callCenter = nil;
    }
    
    
    self.callCenter = [[CTCallCenter alloc] init];
    self.callCenter.callEventHandler = ^(CTCall* call) {
        if ([call.callState isEqualToString:CTCallStateDisconnected])
        {
            NSLog(@"Call has been disconnected");
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:ISPLAYING] boolValue] == YES) {
                [[AudioPlayManager sharedManager] resume];
            }
        }
        else if ([call.callState isEqualToString:CTCallStateConnected])
        {
            NSLog(@"Call has just been connected");
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:ISPLAYING] boolValue] == YES) {
                [[AudioPlayManager sharedManager] resume];
            }
        }
        else if([call.callState isEqualToString:CTCallStateIncoming])
        {
            NSLog(@"Call is incoming");
        }
        else if ([call.callState isEqualToString:CTCallStateDialing])
        {
            NSLog(@"call is dialing");
        }
        else
        {
            NSLog(@"Nothing is done");
        }
    };
}

- (void)nextPlay{
    
}

- (void)previousPlay{
    
}


-(void)remoteControlReceivedWithEvent:(UIEvent *)event{
    
    if (event.type == UIEventTypeRemoteControl) {
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlPlay:
//                [self playBtnTaped:_playBtn]; // 播放
                [[AudioPlayManager sharedManager] resume];
                break;
                
            case UIEventSubtypeRemoteControlPause:
//                [self playBtnTaped:_playBtn];//暂停
                [[AudioPlayManager sharedManager] pause];
                break;
                
            case UIEventSubtypeRemoteControlPreviousTrack:

                [[AudioPlayManager sharedManager] previousPlay];

                break;
                
            case UIEventSubtypeRemoteControlNextTrack:

                [[AudioPlayManager sharedManager] nextPlay];

                break;

            default:
                break;
        }
    }
}

- (void)configPlayingInfos:(NSString *)name image:(NSString *)imgUrl
{
    if (NSClassFromString(@"MPNowPlayingInfoCenter")) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:@"凯叔讲故事" forKey:MPMediaItemPropertyTitle];//歌曲名设置
        [dict setObject:@"凯叔" forKey:MPMediaItemPropertyArtist];//歌手名设置
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];
    }
}

@end
