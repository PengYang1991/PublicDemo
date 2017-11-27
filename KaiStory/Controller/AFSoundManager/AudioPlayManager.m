//
//  AudioPlayManager.m
//  AudioPlayer
//
//  Created by mac on 15/2/26.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "AudioPlayManager.h"
#import "AFSoundManager.h"
#import "Tools.h"
#import "SqliteControl.h"
#import "UserShareInfo.h"
#import "KSDownloader.h" 
#import <MediaPlayer/MPMediaItem.h>
#import <MediaPlayer/MPNowPlayingInfoCenter.h>

@implementation AudioPlayManager

+(instancetype)sharedManager{
    static AudioPlayManager *soundManger =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        soundManger = [[self alloc]init];
        [soundManger initCreate];
    });
    return soundManger;
}

-(void)initCreate{
    [self loadPlayList];
    story = [[StoryModel alloc]init];
    PlayIndex = 0;
    self.toPlay = NO;
    
    self.currentIndex = -1;
    self.currentPlayItem = nil;
    self.currentPlayId = -1;
}
- (void)startPlayLocal:(NSString*) localFilePath
{
    [[AFSoundManager sharedManager] stop];
    [[AFSoundManager sharedManager] startPlayingLocalFileWithName:localFilePath andBlock:^(int percentage, CGFloat elapsedTime, CGFloat timeRemaining, NSError *error, BOOL finished) {
        if (timeRemaining > 0) {
            self.totalTimeFloat = timeRemaining;
            self.totalTime = [NSString stringWithFormat:@"%@",[self timeFormatted:(int)timeRemaining]];
        }
        if (percentage >= 0) {
            self.progress = percentage;
        }
        if (elapsedTime >0) {
            self.playedTime = [NSString stringWithFormat:@"%@",[self timeFormatted:(int)elapsedTime]];
        }
        if (finished) {
            self.currentPlayItem.isFinished = YES;
           
            [self nextPlay];
        }
        if (error) {
            NSLog(@"There has been an error playing the remote file: %@", [error description]);
        }
    } ToPlay:^(BOOL toPlay) {
        //        self.toPlay = YES;
    }];
}
- (void)startPlayStreamingRemote:(NSString*) remoteUrl {
    [[AFSoundManager sharedManager] stop];
    playFile = @"文件";
    [[AFSoundManager sharedManager] startStreamingRemoteAudioFromURL:remoteUrl andBlock:^(int percentage, CGFloat elapsedTime, CGFloat timeRemaining, NSError *error, BOOL finished) {
        //        NSLog(@">>>[line:%d]%s",__LINE__,__FUNCTION__);
        if (timeRemaining > 0) {
            self.totalTimeFloat = (float)timeRemaining;
            self.totalTime = [NSString stringWithFormat:@"%@",[self timeFormatted:(int)timeRemaining]];
        }
        if (percentage >= 0) {
            self.progress = percentage;
        }
        
        if (elapsedTime >0) {
            self.playedTime = [NSString stringWithFormat:@"%@",[self timeFormatted:(int)elapsedTime]];
        }
        
        if (finished) {
            self.currentPlayItem.isFinished = YES;
            
            [self nextPlay];
        }
        if (error) {
            NSLog(@"There has been an error playing the remote file: %@", [error description]);
        }
    }];

}


- (void)resume{
    [self accumulatePlayTime];
    [[AFSoundManager sharedManager] resumeBlock:^(int percentage, CGFloat elapsedTime, CGFloat timeRemaining, NSError *error, BOOL finished) {
        self.totalTimeFloat = timeRemaining;
        self.progress = percentage;
        self.playedTime = [NSString stringWithFormat:@"%@",[self timeFormatted:(int)elapsedTime]];
        self.totalTime = [NSString stringWithFormat:@"%@",[self timeFormatted:(int)timeRemaining]];
        
        if (finished) {
            [self nextPlay];
        }
        if (!error) {
            
        } else {
            NSLog(@"There has been an error playing the remote file: %@", [error description]);
        }
        
    }];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:ISPLAYING];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:[story.m_id intValue]] forKey:PLAYINGMP3ID];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:PLAYSTATE object:[NSNumber numberWithBool:YES]];
    
    self.currentPlayItem.isPlay = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CURRENT_PLAY_ID"
                                                        object:nil];
    
}

- (void)pauseAItem:(StoryModel*) pauseItem
{

    NSInteger pauseId = [pauseItem.m_id integerValue];
    if([self.currentPlayItem.story.m_id integerValue] == pauseId)
    {
        [self pause];
    }
}

- (void)pause{
    [self resetPlayTime];
    [[AFSoundManager sharedManager] pause];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:ISPLAYING];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:PLAYSTATE object:[NSNumber numberWithBool:NO]];
    self.currentPlayId = -1;
    self.currentPlayItem.isPlay = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CURRENT_PLAY_ID"
                                                        object:nil];
}
- (void)stop{
    [[AFSoundManager sharedManager] stop];
    self.currentPlayId = -1;
    self.currentPlayItem.isPlay = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CURRENT_PLAY_ID"
                                                        object:nil];
}
- (void)previousPlay{
    if (self.playList.count > 0) {
        self.currentIndex -= 1;
        if (self.currentIndex < 0) {
            self.currentIndex = (int)(self.playList.count -1);
        }
        else
        {
            [self playAItemInList:self.currentIndex];
        }
    }
}

- (void)nextPlay{
    if (self.playList.count > 0) {
        self.currentIndex += 1;
        if (self.currentIndex >= self.playList.count) {
            self.currentIndex = self.playList.count-1;
        }
        else
        {
            [self playAItemInList:self.currentIndex];
        }
    }
}


- (NSString *)timeFormatted:(int)totalSeconds
{
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60);
    return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
}


-(void)playAItemInList:(NSUInteger) index
{
    self.currentIndex = index;
    NSString* storyIDStr = [self.playList objectAtIndex:index];
    StoryModel* storyItem = [Tools getStoryItem:storyIDStr];
    [self playAItem:storyItem addToListOrNot:NO];
}

-(void)accumulatePlayTime
{
    if(0 == self.playBeginTime)
    {
        self.playBeginTime = [[NSDate date] timeIntervalSinceReferenceDate];
    }else
    {
        NSTimeInterval curInterval = [[NSDate date]timeIntervalSinceReferenceDate];
        [[UserShareInfo sharedSingleton] addStoryListenSecond: (curInterval-self.playBeginTime) ];
        self.playBeginTime = [[NSDate date] timeIntervalSinceReferenceDate];
    }
}

-(void)resetPlayTime
{
    if(0 != self.playBeginTime)
    {
        NSTimeInterval curInterval = [[NSDate date]timeIntervalSinceReferenceDate];
        [[UserShareInfo sharedSingleton] addStoryListenSecond: (curInterval-self.playBeginTime) ];
    }
    self.playBeginTime = 0;
}

//点击播放一个故事
- (void)playAItem:(StoryModel*) playItem addToListOrNot:(BOOL) add2ListFlag
{
    if (NSClassFromString(@"MPNowPlayingInfoCenter"))
    {
        NSMutableDictionary *info = [NSMutableDictionary dictionary];
        // 标题(音乐名称)
        //forKey:MPMediaItemPropertyTitle
        info[MPMediaItemPropertyTitle] = playItem.name;
        //info[MPMediaItemPropertyArtwork] = [[MPMediaItemArtwork alloc] initWithImage:[UIImage imageNamed:music.icon]];
        // 唯一的API,单例,nowPlayingInfo字典
        [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = info;
    }
    
    [self accumulatePlayTime];
    self.currentPlayId =[playItem.m_id integerValue];
    NSLog(@"PLAY %ld",self.currentPlayId);
    [Tools saveStoryItem:playItem];
    
    if(nil == self.currentPlayItem)
    {
        self.currentPlayItem = [[AudioPlayItem alloc]init];
    }
    //判断当前正在播放的内容是什么，如果是同一个内容(且该内容还没有播放完毕)，则继续播放
    if( [self.currentPlayItem.story.m_id integerValue]== self.currentPlayId &&
       ! self.currentPlayItem.isFinished )
    {
        [self resume];
        return;
    }else
    {
        //播放一个不同的故事，需要增加收听的故事个数
        [[UserShareInfo sharedSingleton] addStoryListenCount];
        
        // 追加到用户的历史信息列表中
        [[UserShareInfo sharedSingleton] addHistoryItem:playItem.m_id];
        
        //如果是新的内容，判断是否要追加到播放列表当中
        if(add2ListFlag)
        {
            [self addToPlayList:playItem];
            self.currentIndex = self.playList.count -1 ;
        }
        
        //选择播放方式
        //TODO 此处需要结合下载对文件的管理进行整体update
        NSString* localPath = [[KSDownloader shareInstance]getFinishedFile:playItem.m_id];
        //如果没有这个记录，则说明一定是网络播放
        if([Tools isBlankString:localPath])
        {
            [self startPlayStreamingRemote:playItem.media_url];
            
        }else
        {
            [self startPlayLocal:localPath];
        }
    }
    
    self.currentPlayItem.story = playItem;
    self.currentPlayItem.isPlay = YES;
    self.currentPlayItem.isFinished = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CURRENT_PLAY_ID"
                                                        object:nil  ];
}

- (void)addToPlayList:(StoryModel*)playItem
{
    [Tools saveStoryItem:playItem];
    [self.playList addObject:playItem.m_id];
    [self savePlayList];
}

//添加一个播放列表，且播放这个列表中的故事
- (void)PlayAList:(NSMutableArray *)subPlayList
{
    
}

- (void)moveToSeconds:(CGFloat) destSecond
{
    [[AFSoundManager sharedManager] moveToSecond:destSecond];
    self.currentPlayItem.isFinished = NO;
    if(self.currentPlayItem.isPlay)
    {
        [self resume];
    }
}

- (void)loadPlayList
{
    self.playList = [[NSMutableArray alloc]init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSData *userData = [prefs objectForKey:@"PLAY_LIST"];
    if (userData != nil)
    {
        NSArray* playIdArray = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        [self.playList addObjectsFromArray:playIdArray];
    }
}
- (void)savePlayList
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:[NSKeyedArchiver archivedDataWithRootObject:self.playList] forKey:@"PLAY_LIST"];
    [prefs synchronize];
}

@end
