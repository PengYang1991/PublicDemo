//
//  AFSoundManager.m
//  AFSoundManager-Demo
//
//  Created by Alvaro Franco on 4/16/14.
//  Copyright (c) 2014 AlvaroFranco. All rights reserved.
//

#import "AFSoundManager.h"

#import "AppDelegate.h"
//#import "Coder.h"

@interface AFSoundManager ()<AVAudioPlayerDelegate, AVAudioSessionDelegate>

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic) int type;
@property (nonatomic) int status;
@property (nonatomic, assign) int isNet;
@property (nonatomic, assign) BOOL isLocal;

@end

@implementation AFSoundManager

+(instancetype)sharedManager {
    
    static AFSoundManager *soundManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        soundManager = [[self alloc]init];
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
        [soundManager initAudioPlayer];
    });
    
    return soundManager;
}



- (void)initAudioPlayer{
//    _audioPlayer = [[AVAudioPlayer alloc] init];
//    AVQueuePlayer
//    _avQueuePlyer = [[AVQueuePlayer alloc] init];
    _isNet = -1;
}

-(void)startPlayingLocalFileWithName:(NSString *)filePath andBlock:(progressBlock)block ToPlay:(void(^)(BOOL toPlay))playBlock{
    
//    NSString *filePath = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle]resourcePath], name];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    NSError *error = nil;
    
    [self checkPay];
    if (_audioPlayer) {
        [_audioPlayer stop];
        _audioPlayer = nil;
//        _timer=nil;
    }
    if (_player) {
        [_player pause];
        _player = nil;
//        _timer=nil;
    }
    if (_timer) {
        _timer=nil;
    }
//    if (CODE == 0) {
//        Coder *coder = [[Coder alloc] init];
//        _audioPlayer = [[AVAudioPlayer alloc] initWithData:[coder ZHdecoderWithData:[NSData dataWithContentsOfURL:fileURL] Key:CoderKey] error:&error];
////        _avQueuePlyer.items =
//        
//    }else {
//        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&error];
//    }
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&error];
    if (playBlock) {
        playBlock([_audioPlayer prepareToPlay]);
    }
    _audioPlayer.delegate = self;
    [_audioPlayer prepareToPlay];
    [_audioPlayer play];
    
    __block int percentage = 0;
    _isNet = 1;
    _isLocal = YES;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 block:^{
            if (_isNet == 1) {
                if (_isLocal == YES) {
                    percentage = ((CMTimeGetSeconds(_player.currentItem.currentTime) * 100)/CMTimeGetSeconds(_player.currentItem.duration));
                    if(percentage >= 100)
                    {
                        percentage = 100;
                    }
                    if (percentage != 100) {
                        int timeRemaining = _audioPlayer.duration ;//- _audioPlayer.currentTime;
//                        block(percentage, _audioPlayer.currentTime, CMTimeGetSeconds(_audioPlayer.currentItem.duration), error, NO);
                        block(percentage, _audioPlayer.currentTime, timeRemaining, error, NO);
                    } else {
                        
                        int timeRemaining = _audioPlayer.duration ;//- _audioPlayer.currentTime;
//                        block(percentage, CMTimeGetSeconds(_audioPlayer.currentItem.currentTime), CMTimeGetSeconds(_audioPlayer.currentItem.duration), error, NO);
                        block(100, _audioPlayer.currentTime, timeRemaining, error, YES);
                        
                        [_timer invalidate];
                    }
                    
                }

            }
        } repeats:YES];
    
}


- (void)checkPay{
    if (_player != nil) {
        _player = nil;
        [_timer pauseTimer];
    }
    if (_audioPlayer.isPlaying) {
        [_audioPlayer stop];
        [_timer pauseTimer];
    }
}

-(void)startStreamingRemoteAudioFromURL:(NSString *)url andBlock:(progressBlock)block {
    
    NSURL *streamingURL = [NSURL URLWithString:url];
    NSError *error = nil;
    
    [self checkPay];
    
    if (_player) {
        [_player pause];
        _player = nil;
//        _timer=nil;
    }
    if (_audioPlayer) {
        [_audioPlayer stop];
        _audioPlayer = nil;
//        _timer=nil;
    }
    if (_timer) {
        _timer=nil;
    }
    
    _player = [[AVPlayer alloc]initWithURL:streamingURL];
    [_player play];
    
    if (!error) {
        __block float percentage = 0;
        _isNet = 2;
        _isLocal = NO;
            _timer = [NSTimer scheduledTimerWithTimeInterval:1 block:^{
                if (_isNet == 2) {
                    if (_isLocal == NO) {
                        percentage = ((CMTimeGetSeconds(_player.currentItem.currentTime) * 100)/CMTimeGetSeconds(_player.currentItem.duration));
                        if(percentage >= 100)
                        {
                            percentage = 100;
                        }
                        if (percentage != 100) {
                            block(percentage, CMTimeGetSeconds(_player.currentItem.currentTime), CMTimeGetSeconds(_player.currentItem.duration), error, NO);
                        } else {
                            [_timer invalidate];
                            block(100, CMTimeGetSeconds(_player.currentItem.currentTime), CMTimeGetSeconds(_player.currentItem.duration), error, YES);
                        }

                    }
                }
            } repeats:YES];
        
    } else {
        [_audioPlayer stop];
    }
    
}

-(NSDictionary *)retrieveInfoForCurrentPlaying {
    
    if (_audioPlayer.url) {
        
        NSArray *parts = [_audioPlayer.url.absoluteString componentsSeparatedByString:@"/"];
        NSString *filename = [parts objectAtIndex:[parts count]-1];
        
        NSDictionary *info = @{@"name": filename, @"duration": [NSNumber numberWithInt:_audioPlayer.duration], @"elapsed time": [NSNumber numberWithInt:_audioPlayer.currentTime], @"remaining time": [NSNumber numberWithInt:(_audioPlayer.duration - _audioPlayer.currentTime)], @"volume": [NSNumber numberWithFloat:_audioPlayer.volume]};
        
        return info;
    } else {
        return nil;
    }
}

-(void)pause {
    [_audioPlayer pause];
    [_player pause];
    [_timer pauseTimer];
}

-(void)resume {
    [_audioPlayer play];
    [_player play];
    [_timer resumeTimer];
}

-(void)resumeBlock:(progressBlock)block{
    [_audioPlayer play];
    [_player play];
    [_timer resumeTimer];
    
    
    NSError *error = nil;
    if (!error) {
        
        __block int percentage = 0;
        _isNet = 3;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 block:^{
            if (_isNet == 3) {
                if (_isLocal == YES) {
                    if (percentage != 100) {
                        
                        percentage = (int)((_audioPlayer.currentTime * 100)/_audioPlayer.duration);
                        int timeRemaining = _audioPlayer.duration ;//- _audioPlayer.currentTime;
                        
                        block(percentage, _audioPlayer.currentTime, timeRemaining, error, NO);
                    } else {
                        
                        int timeRemaining = _audioPlayer.duration ;//- _audioPlayer.currentTime;
                        
                        block(100, _audioPlayer.currentTime, timeRemaining, error, YES);
                        
                        [_timer invalidate];
                    }
                }else{
                    if (percentage != 100) {
                        
                        percentage = (int)((CMTimeGetSeconds(_player.currentItem.currentTime) * 100)/CMTimeGetSeconds(_player.currentItem.duration));
                        //                int timeRemaining = CMTimeGetSeconds(_player.currentItem.duration) - CMTimeGetSeconds(_player.currentItem.currentTime);
                        
                        block(percentage, CMTimeGetSeconds(_player.currentItem.currentTime), CMTimeGetSeconds(_player.currentItem.duration), error, NO);
                    } else {
                        
                        //                int timeRemaining = CMTimeGetSeconds(_player.currentItem.duration) - CMTimeGetSeconds(_player.currentItem.currentTime);
                        
                        block(100, CMTimeGetSeconds(_player.currentItem.currentTime), CMTimeGetSeconds(_player.currentItem.duration), error, YES);
                        [_timer invalidate];
                    }
                }
                
            }
        } repeats:YES];
    } else {
        
        block(0, 0, 0, error, YES);
        [_audioPlayer stop];
    }
}

-(void)stop {
    [_audioPlayer stop];
    _audioPlayer = nil;
    _player = nil;
    
    [_timer pauseTimer];
}

-(void)restart {
    [_audioPlayer setCurrentTime:0];
    
    int32_t timeScale = _player.currentItem.asset.duration.timescale;
    [_player seekToTime:CMTimeMake(0.000000, timeScale)];
}

-(void)moveToSecond:(int)second {
    [_audioPlayer setCurrentTime:second];
    
    int32_t timeScale = _player.currentItem.asset.duration.timescale;
    [_player seekToTime:CMTimeMakeWithSeconds((Float64)second, timeScale) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
}

-(void)moveToSection:(CGFloat)section {
    int audioPlayerSection = _audioPlayer.duration * section;
    [_audioPlayer setCurrentTime:audioPlayerSection];
    
    int32_t timeScale = _player.currentItem.asset.duration.timescale;
    Float64 playerSection = CMTimeGetSeconds(_player.currentItem.duration) * section;
    [_player seekToTime:CMTimeMakeWithSeconds(playerSection, timeScale) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
}

-(void)changeSpeedToRate:(CGFloat)rate {
    _audioPlayer.rate = rate;
    _player.rate = rate;
    
}

-(void)changeVolumeToValue:(CGFloat)volume {
    _audioPlayer.volume = volume;
    _player.volume = volume;
}

-(void)startRecordingAudioWithFileName:(NSString *)name andExtension:(NSString *)extension shouldStopAtSecond:(NSTimeInterval)second {
    
    _recorder = [[AVAudioRecorder alloc]initWithURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@.%@", [NSHomeDirectory() stringByAppendingString:@"/Documents"], name, extension]] settings:nil error:nil];
    
    if (second == 0 && !second) {
        [_recorder record];
    } else {
        [_recorder recordForDuration:second];
    }
}

-(void)pauseRecording {
    
    if ([_recorder isRecording]) {
        [_recorder pause];
    }
}

-(void)resumeRecording {
    
    if (![_recorder isRecording]) {
        [_recorder record];
    }
}

-(void)stopAndSaveRecording {
    [_recorder stop];
}

-(void)deleteRecording {
    [_recorder deleteRecording];
}

-(NSInteger)timeRecorded {
    return [_recorder currentTime];
}

-(BOOL)areHeadphonesConnected {
    
    AVAudioSessionRouteDescription *route = [[AVAudioSession sharedInstance]currentRoute];
        
    BOOL headphonesLocated = NO;
    
    for (AVAudioSessionPortDescription *portDescription in route.outputs) {
        
        headphonesLocated |= ([portDescription.portType isEqualToString:AVAudioSessionPortHeadphones]);
    }
    
    return headphonesLocated;
}

-(void)forceOutputToDefaultDevice {
    
    [AFAudioRouter initAudioSessionRouting];
    [AFAudioRouter switchToDefaultHardware];
}

-(void)forceOutputToBuiltInSpeakers {
    
    [AFAudioRouter initAudioSessionRouting];
    [AFAudioRouter forceOutputToBuiltInSpeakers];
}

#pragma mark - AV Player Delegate

-(void)audioPlayerBeginInterruption:(AVAudioPlayer *)player{
    
    NSLog(@"audioPlayerBeginInterruption%@",player);
    
    UIBackgroundTaskIdentifier bgTask = 0;
    
    if([UIApplication sharedApplication].applicationState== UIApplicationStateBackground) {
        NSLog(@"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx后台播放");
        //[player play];
        UIApplication*app = [UIApplication sharedApplication];
        UIBackgroundTaskIdentifier newTask = [app beginBackgroundTaskWithExpirationHandler:nil];
        if(bgTask!= UIBackgroundTaskInvalid) {
            [app endBackgroundTask: bgTask];
        }
         bgTask = newTask;
    }else {
        NSLog(@"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx前台播放");
        //[player play];
    }
    
//    if ([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)]) {
//        if (bgTaskId != UIBackgroundTaskInvalid) {
//            bgTaskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:NULL];
//        }
//    }
}

-(void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags{
     NSLog(@"audioPlayerEndInterruption%@ ",player);
    [player prepareToPlay];
    [player play];
}

@end

@implementation NSTimer (Blocks)

+(id)scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats {
    
    void (^block)() = [inBlock copy];
    id ret = [self scheduledTimerWithTimeInterval:inTimeInterval target:self selector:@selector(executeSimpleBlock:) userInfo:block repeats:inRepeats];
//    id ret = [[self alloc] initWithFireDate:nil interval:inTimeInterval target:self selector:@selector(executeSimpleBlock:) userInfo:block repeats:inRepeats];
    return ret;
}

+(id)timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats {
    
    void (^block)() = [inBlock copy];
    id ret = [self timerWithTimeInterval:inTimeInterval target:self selector:@selector(executeSimpleBlock:) userInfo:block repeats:inRepeats];
    
    return ret;
}

+(void)executeSimpleBlock:(NSTimer *)inTimer {
    
    if ([inTimer userInfo]) {
        void (^block)() = (void (^)())[inTimer userInfo];
        block();
    }
}

@end

@implementation NSTimer (Control)

static NSString *const NSTimerPauseDate = @"NSTimerPauseDate";
static NSString *const NSTimerPreviousFireDate = @"NSTimerPreviousFireDate";

-(void)pauseTimer {
    
    objc_setAssociatedObject(self, (__bridge const void *)(NSTimerPauseDate), [NSDate date], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, (__bridge const void *)(NSTimerPreviousFireDate), self.fireDate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.fireDate = [NSDate distantFuture];
}

-(void)resumeTimer {
    
    NSDate *pauseDate = objc_getAssociatedObject(self, (__bridge const void *)NSTimerPauseDate);
    NSDate *previousFireDate = objc_getAssociatedObject(self, (__bridge const void *)NSTimerPreviousFireDate);
    
    const NSTimeInterval pauseTime = -[pauseDate timeIntervalSinceNow];
    self.fireDate = [NSDate dateWithTimeInterval:pauseTime sinceDate:previousFireDate];
}

@end
