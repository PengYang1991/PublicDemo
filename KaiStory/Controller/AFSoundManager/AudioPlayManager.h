//
//  AudioPlayManager.h
//  AudioPlayer
//
//  Created by mac on 15/2/26.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "Story.h"
#import "StoryModel.h"
#import "AudioPlayItem.h"


@interface AudioPlayManager : NSObject
{
    StoryModel *story;
    int PlayIndex;
    NSString *playFile;
    BOOL isNet;
}
typedef void (^progressBlock)(int percentage, CGFloat elapsedTime, CGFloat timeRemaining, NSError *error, BOOL finished);

@property (nonatomic,assign)float progress;
@property (strong,nonatomic)NSString *playedTime;
@property (strong,nonatomic)NSString *totalTime;
@property (nonatomic,assign)float totalTimeFloat;
@property (nonatomic,assign)BOOL toPlay;


@property NSMutableArray *playList;
//2015年04月25日添加，由于全局只有一张播放列表，那么记录当前播放内容在播放列表当中的位置
@property NSInteger currentIndex;
@property NSInteger currentPlayId;
@property AudioPlayItem* currentPlayItem;
@property NSTimeInterval playBeginTime;

//获取单例
+(instancetype)sharedManager;

- (void)startPlayLocal:(NSString*) localFilePath;
- (void)startPlayStreamingRemote:(NSString*) remoteUrl;

//2015年04月25日 添加
//点击播放一个故事
- (void)playAItem:(StoryModel*) playItem addToListOrNot:(BOOL) add2ListFlag;
- (void)playAItemInList:(NSUInteger) index;
//为了防止状态异常，在每个故事点击的时候检查发出暂停请求的故事跟正在播放的故事是否是同一个
- (void)pauseAItem:(StoryModel*) pauseItem;
//添加一个播放列表，且播放这个列表中的故事
- (void)PlayAList:(NSMutableArray *)subPlayList;
//将一个故事添加到播放单
- (void)addToPlayList:(StoryModel*)playItem;

- (void)moveToSeconds:(CGFloat) destSecond;
- (void)pause;
- (void)resume;
- (void)stop;
- (void)restart;


- (void)previousPlay;
- (void)nextPlay;
@end
