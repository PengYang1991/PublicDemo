//
//  UserShareInfo.m
//  KaiStory
//
//  Created by mac on 15/3/25.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "UserShareInfo.h"
#import "Tools.h"

@implementation UserShareInfo
+ (UserShareInfo *)sharedSingleton{
    static dispatch_once_t pred;
    
    static UserShareInfo *sharedSingleton;
    
    dispatch_once(&pred,^{sharedSingleton=[[self alloc] initSingleton];} );
    
    return sharedSingleton;
}
- (id)initSingleton
{
    if(self=[super init]){
        
        [self loadPreferences];
        [self loadLovedStoryArray];
        [self loadLovedDailyArray];
        [self loadHistoryList];
        [self loadStoryListenInfo];
        [self loadLovedAlbumArray];
    }
    return self;
}

- (void) addLoveDaily:(NSString*)dailyUrl
{
    if(![self.lovedDailyArray containsObject:dailyUrl])
    {
        [self.lovedDailyArray addObject:dailyUrl];
        [self saveLovedDailyArray];
    }
}
- (void) removeLoveDaily:(NSString*)dailyUrl
{
    if([self.lovedDailyArray containsObject:dailyUrl])
    {
        [self.lovedDailyArray removeObject:dailyUrl];
        [self saveLovedDailyArray];
    }
}
- (void)loadLovedDailyArray
{
    self.lovedDailyArray = [[NSMutableArray alloc]init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSData *userData = [prefs objectForKey:@"LOVED_DAILY"];
    if (userData != nil)
    {
        NSArray* lovedStoryIdArray = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        [self.lovedDailyArray addObjectsFromArray:lovedStoryIdArray];
    }
}
- (void)saveLovedDailyArray
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:[NSKeyedArchiver archivedDataWithRootObject:self.lovedDailyArray] forKey:@"LOVED_DAILY"];
    [prefs synchronize];
}


- (void) addLoveStory:(StoryModel*)storyItem
{
    if(![self.lovedStoryArray containsObject:storyItem.m_id])
    {
        [Tools saveStoryItem:storyItem];
        [self.lovedStoryArray addObject:storyItem.m_id];
        [self saveLovedStoryArray];
    }
}
- (void) removeLoveStory:(NSString*)storyId
{
   if([self.lovedStoryArray containsObject:storyId])
   {
       [self.lovedStoryArray removeObject:storyId];
       [self saveLovedStoryArray];
   }
}
- (void)loadLovedStoryArray
{
    self.lovedStoryArray = [[NSMutableArray alloc]init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSData *userData = [prefs objectForKey:@"LOVED_STORY"];
    if (userData != nil)
    {
        NSArray* lovedStoryIdArray = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        [self.lovedStoryArray addObjectsFromArray:lovedStoryIdArray];
    }
}
- (void)saveLovedStoryArray
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:[NSKeyedArchiver archivedDataWithRootObject:self.lovedStoryArray] forKey:@"LOVED_STORY"];
    [prefs synchronize];
}

- (void) addLoveAlbum:(KSAlbumModel *)albumItem
{
    if(![self.lovedStoryArray containsObject:albumItem.modelID])
    {
        [Tools saveAlbumItem:albumItem];
        [self.lovedAlbumArray addObject:albumItem.modelID];
        [self saveLovedAlbumArray];
    }
}
- (void) removeLoveAlbum:(NSString*)albumId
{
    if([self.lovedAlbumArray containsObject:albumId])
    {
        [self.lovedAlbumArray removeObject:albumId];
        [self saveLovedAlbumArray];
    }
}
- (void)loadLovedAlbumArray
{
    self.lovedAlbumArray = [[NSMutableArray alloc]init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSData *userData = [prefs objectForKey:@"LOVED_ALBUM"];
    if (userData != nil)
    {
        NSArray* lovedAlbumIdArray = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        [self.lovedAlbumArray addObjectsFromArray:lovedAlbumIdArray];
    }
}
- (void)saveLovedAlbumArray
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:[NSKeyedArchiver archivedDataWithRootObject:self.lovedAlbumArray] forKey:@"LOVED_ALBUM"];
    [prefs synchronize];
}


- (void) addHistoryItem:(NSString*)storyId{
    [self.historyList addObject:storyId];
    [self saveHistoryList];
}

- (void)removeFromHistoryList:(NSUInteger)indexInList
{
    if([self.historyList count] > indexInList)
    {
        [self.historyList removeObjectAtIndex:indexInList];
        [self saveHistoryList];
    }
}

- (void)loadHistoryList
{

    self.historyList = [[NSMutableArray alloc]init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSData *userData = [prefs objectForKey:@"HISTORY_STORY"];
    if (userData != nil)
    {
        NSArray* historyArray = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        [self.historyList addObjectsFromArray:historyArray];
    }
}

- (void)saveHistoryList
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:[NSKeyedArchiver archivedDataWithRootObject:self.historyList] forKey:@"HISTORY_STORY"];
    [prefs synchronize];
}

- (void)savePreferences
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:[NSKeyedArchiver archivedDataWithRootObject:self.m_UserInfoItem] forKey:@"USER_INFO"];
    [prefs synchronize];
}
- (UserInfo*)loadPreferences
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSData *userData = [prefs objectForKey:@"USER_INFO"];
    self.m_UserInfoItem = nil;
    if (userData != nil)
    {
        self.m_UserInfoItem = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    }
    return self.m_UserInfoItem;
}


- (void)loadStoryListenInfo
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    self.storyListenCount = [prefs integerForKey:@"STORY_LISTEN_COUNT"];
    self.storyListenSecond = [prefs integerForKey:@"STORY_LISTEN_SECOND"];
    self.storyLastListenDate = [prefs integerForKey:@"STORY_LAST_LISTEN_DATE"];
    self.storyListenDay = [prefs integerForKey:@"STORY_LISTEN_DAY"];
}

- (void)addStoryListenCount
{
    self.storyListenCount += 1;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:self.storyListenCount forKey:@"STORY_LISTEN_COUNT"];
    [prefs synchronize];
}

- (void)addStoryListenSecond:(NSInteger)second
{
    self.storyListenSecond += second;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:self.storyListenSecond forKey:@"STORY_LISTEN_SECOND"];
    [prefs synchronize];
}

- (void)addStoryListenDay
{
    NSInteger currentSecond = [[NSDate date] timeIntervalSince1970];
    if(currentSecond - self.storyLastListenDate > 24*60*60)
    {
        self.storyLastListenDate = currentSecond;
        self.storyListenDay += 1;
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setInteger:self.storyLastListenDate forKey:@"STORY_LAST_LISTEN_DATE"];
        [prefs setInteger:self.storyListenDay forKey:@"STORY_LISTEN_DAY"];
        [prefs synchronize];
    }
}

@end
