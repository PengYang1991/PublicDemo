//
//  Tools.h
//  
//
//  Created by wuxiang on 13-5-31.
//  Copyright (c) 2013年 wuxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sys/utsname.h>
#import <UIKit/UIKit.h>
#import "StoryModel.h"
#import "KSAlbumModel.h"

#define Http_Test 0
//#define Http_Formal 0
//#define Http_Location 0

#ifdef Http_Test
#define HttpBaseUrl @"http://t.v1.android.kaishuhezi.com"
#endif

#ifdef Http_Formal
#define HttpBaseUrl @"http://v1.android.kaishuhezi.com"
#endif

#ifdef Http_Location
#define HttpBaseUrl @"http://192.168.1.128:8080/kaishuhezi-android-api"
#endif


//首页发现的宏定义宽高
#define LunboHeight 344
#define ClassHeight 266
#define StoryHeight  520

// 引导页张数
#define GuideTimes 4

#define VALUEFORNSLOG 1
#define MainBandle  [ UIScreen mainScreen].bounds
#define FRAME_WIDTH [UIScreen mainScreen].bounds.size.width


#define FRAME_HEIGHT   [UIScreen mainScreen].bounds.size.height
#define FRAME_WIDTH    [UIScreen mainScreen].bounds.size.width
#define RESIZE_RATIO   FRAME_WIDTH/640
#define FONT_RESIZE_RATIO RESIZE_RATIO*72/96
#define TABBAR_HEIGHT  129

#define DRIVER_COUNT  ([UIscreen mainscreen].height>480?7:6)
//#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)


#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)


//放大版的iphone6等于Iphone5的分辨率

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)




#define iOS7 (([[[UIDevice currentDevice] systemVersion] intValue] > 6) ? YES : NO)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UINavigationBarHeight 64
#define UITabBarHeight 49
#define CGRectMakeWithAnnotation(x, y, width, height) (CGRectMake((64*x)/145, (64*y)/145, (64*width)/145, (64*height)/145))


//测试用数据
//#define Birth_test @"2010-8-25"


//Keys
#define USERINFO @"UserInfo" //用户信息Key
#define LOGINSTATE @"LoginState"//登陆状态Key
#define ISPLAYING @"playing"//是否正在播放Key
#define PLAYINGMP3ID @"playingMP3"//正在播放的音频的ID
#define BIRTHDAY @"Birthday" //生日Key
#define PlayingMP3List @"playingList"


#define PLAYSTATE @"playState"//notification通知播放Key
#define ACCESS_TOKEN @"access_token"//token



#define UMENGAPPKEY @"54a1478bfd98c5c64c000a0c"
#define WX_APP_ID @"wxe4883eb8c3567ce7"
#define WX_APP_SECRET @"81840e0ea3547a0deb0ec24d84f381e6"
#define QQ_QZONE_ID @"1103276736"
#define QQ_QZONE_KEY @"Uop3UsOcgcooi3Wh"


//#define CODE 0 //0加密   1不加密


#define AlertFrame CGRectMake(FRAME_WIDTH/2-70,FRAME_HEIGHT/2-50,140,60)

//#if[[[UIDevice currentDevice] systemVersion] floatValue]<7.0
//#define FRAME_WIDTH [UIScreen mainScreen].bounds.size.height
//#else
//#define FRAME_WIDTH [UIScreen mainScreen].bounds.size.height
//#endif
//#define Init  float versions=[[[UIDevice currentDevice] systemVersion] floatValue];
//#define  VERSION   versions
//#define VERSIONSUPER   7
//#if     VERSION <VERSIONSUPER
//#define FRAME_HEIGHT [UIScreen mainScreen].bounds.size.height-20
//#else
//
//#endif


@interface Tools : NSObject
+(float)widthWithFontLenthUIlabel:(UILabel *)uilabel;
+(void)nsLogStart:(id)logValue andString:(NSString *)string;
+ (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;
+ (float) heightForChineseString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;
+(NSString *)JSONString:(NSString *)aString;
+(float)viewHeight:(UIView *)viewmain;
+(NSString *)timescempTotime:(NSString *)timescemp;
+(UIColor*)stringRPGForUIColor:(NSString *)color;
//16进制color转UIColor
+(UIColor *)colorWithHexString:(NSString *)color;
+(NSString *)activitTimeFromStarTime:(NSString *)startTime EndTime:(NSString *)endTime;
+(NSString *)intervalSinceNow: (NSString *) theDate;
+ (NSString *)timerFireMethodWithTme:(NSString *)stattime;
+(BOOL)judgeTimeForNow:(NSString *)time;
//改变数据源数值 key 所需对比字段 value对比的值 array数据源 changekey需要改变的键 changeValue需要改变的值
+(NSMutableArray *)changeNetWorkDataWithKey:(NSString *)key
                                      value:(NSString *)value
                                netWorkData:(NSMutableArray *)array
                                  changeKey:(NSString *)changeKey
                                changeValue:(NSString *)changeValue;
+(BOOL)saveImage:(UIImage *)currentImage withName:(NSString *)fullPath;
+(BOOL)deleteImage:(NSString *)imagePath;
+(NSString *)makeImageName;
+(NSString *)readTimeChangeToTimescerm:(NSString *)time;
+(NSString *)activityTypeChangeToNum:(NSString *)name;

//删除数据流传过来的值中的标示符反斜杠
+(NSString *)strForJsonNormalFromServerJson:(NSString *)str;
//判断 数据流传过来的值是否为所需要的code值
+(BOOL)isRecevieStr:(NSString *)log;
//现在时间 2013-08-26 10:52:37
+(NSString *)dateNowToStr;
//数据库查询 数组转字符串   key = value , key = valuewhere id = XX
+(NSString *)dicChangeToStringForUpdate:(NSMutableDictionary *)dic;
//数据库查询 数组转字符串   key = value , key = value 
+(NSString *)dicChangeToStringForUpdateWithOtherField:(NSMutableDictionary *)dic;
//数据库查询 数组转字符串  where key = value
+(NSString *)dicChangeToStringForSelectWhere:(NSMutableDictionary *)dic;
//数据库插入 字典转字符串 放在数组 array[0]=(string)keys array[1]=(string)value key,key  value,value
+(NSMutableArray*)dictionryChangeToString:(NSMutableDictionary *)dic;
//数据库插入 字典转字符串 放在数组 array[0]=(string)keys array[1]=(string)value key,key  "value","value"
+(NSMutableArray*)dictionryChangeToInsertString:(NSMutableDictionary *)dic;
//数据库插入 字典转字符串 放在数组 array[0]=(string)keys array[1]=(string)value 并把Value中的双引号去除
+(NSMutableArray*)dictionryChangeToInsertStringAndChangeDoublePointToOnePoint:(NSMutableDictionary *)dic;
//数据库删除 数组转字符串   key = value AND key = value
+(NSString *)dicChangeToStringForDeleteWhere:(NSMutableDictionary *)dic;
//发送数据由字典转字符串    -无反斜杠
+(NSString *)sendDataWithDic:(NSDictionary *)datadic;
//发送数据由字典转字符串    -无反斜杠
+(NSString *)sendDataWithStr:(NSDictionary *)datadic;
//发送数据由数组转字符串    -无反斜杠 无data serviceCode
+(NSString *)sendDataWithDictonary:(NSDictionary *)dictionary;
+(void )subStringWithFirstAndLast:(NSMutableString *)str;
//获取时间数
+(NSArray *)chineseDateFormeters;
+(NSString *)getCurrentTime;
//双引号改单引号
+(NSString *)strDeleteDoubleTagWithStr:(NSString *)str;
//2013-09-05 15:25 现在时间
+(NSString *)strDateTimeForNow;
//2013-09-05 现在时间
+(NSString *)strDateForNow;
//发送数据由数组转字符串    -无反斜杠
+(NSString *)sendDataWithArray:(NSArray *)array;
// 字符串 04 转 int 4
+(int)strChangeToInt:(NSString *)str;
//正则表达式验证
+ (BOOL) regularUserInputText : (NSString *) str RegularString:(NSString *)regular;
/**
 *	@brief	浏览头像
 *
 *	@param 	oldImageView 	头像所在的imageView
 */
+(void)showImage:(UIImageView*)avatarImageView;
/**
 *	@brief	获取手机型号
 *
 *	@return	中文手机型号
 */
+ (NSString*)doDevicePlatform;
+ (BOOL) isBlankString:(NSString *)string;
/**
 * @brief 获取经度
 * @return 字符串化的经度
 **/
+ (NSString*) getLongitude;
/**
 * @brief 获取纬度
 * @return 字符串化的纬度
 **/
+ (NSString*) getLatitude;

+ (BOOL) checkTimeExpire:(NSString*)timeKey ExpireSeconds:(int) expireSeconds;
+ (BOOL) setUpdateTime:(NSString*)timeKey;

+ (NSString*) getCacheJson:(NSString*)jsonKey;
+ (NSDictionary* )getCacheJsonDict:(NSString*)jsonKey;
+ (BOOL) setCacheJson:(NSString*) jsonStr forKey:(NSString*) jsonKey;

+ (NSString*) getRawData:(NSString*) rawKey;
+ (BOOL) setRawData:(NSString*) rawData forKey:(NSString*) rawKey;
+(UIImage*) replaceColor:(UIColor*)oldColor withColor:(UIColor*)newColor inImage:(UIImage*)destImg;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+(NSString *)NSDictionaryToString:(id)result;
+(id)StringToNSDictionary:(NSString *)jsonStr;

+(void) saveStoryItem:(StoryModel*) storyItem;
+(StoryModel*) getStoryItem:(NSString*) storyId;

+(void) saveAlbumItem:(KSAlbumModel*) albumItem;
+(KSAlbumModel*) getAlbumItem:(NSString*) albumID;

+(void) setBabySex:(NSInteger) babySex;
+(NSInteger) getBabySex;

+(void) setBabyAge:(NSInteger) babyAge;
+(NSInteger) getBabyAge;

+(BOOL) isFirstStartUp;
+(void) setNotFirstStartUp;
@end
