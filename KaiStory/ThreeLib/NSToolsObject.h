//
//  NSToolsObject.h
//  Cars Circle
//  验证工具类
//  1.NSString 为空(nil)的验证
//  2.邮箱验证
//  3.电话号验证
//  4.身份证验证
//  Created by 刘登坛(iZealot) on 13-5-31.
//  Copyright (c) 2013年 liudengtan@126.com All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSToolsObject : NSObject
//  1.NSString 为空(nil)的验证
+ (BOOL)isEmptyOrNull:(NSString *)string;
//  2.邮箱验证
+ (BOOL)isValidateEmail:(NSString *)email;
//  3.电话号验证
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
//  4.身份证验证
+ (BOOL)isIdCard:(NSString *)sPaperId;
//  5.浮点数验证(未实现)
//+ (BOOL)isFloatingNumber:(NSString *)fnumber;
/**
 生成当前时间字符串
 @returns 当前时间字符串
 */
+ (NSString*)getCurrentTimeString;

/**
 获取缓存路径
 @returns 缓存路径
 */
+ (NSString*)getCacheDirectory;

/**
 判断文件是否存在
 @param _path 文件路径
 @returns 存在返回yes
 */
+ (BOOL)fileExistsAtPath:(NSString*)_path;

/**
 删除文件
 @param _path 文件路径
 @returns 成功返回yes
 */
+ (BOOL)deleteFileAtPath:(NSString*)_path;
//返回day天后的日期(若day为负数,则为|day|天前的日期)
+ (NSString *)dateAfterDay:(int)day;
+ (NSString *)dateAfterDay2:(int)day;
#pragma mark -

/**
 生成文件路径
 @param pathName 文件名
 @param pathType 文件类型
 @returns 文件路径
 */
+(NSString *)getPathString:(NSString *)pathName type:(NSString *)pathType;

/**
 获取当前系统日期
 @returns 月日
 */
+(NSString *)getSystemDate;
+(NSString *)getSystemDateyyyy;
/**
NSDate 转 NSString
@param date 要转的日期
@returns 转后的日期字符
*/
+(NSString *)dateToString:(NSDate *)date;
/**
 @param strdate 日期字符
 @returns 转换后的日期
 */
+(NSDate *)stringToDate:(NSString *)strdate;
+(BOOL)isNetWorkStatus;
//秒转换为时分秒
+(NSString *)getTimeHMS:(int)ss;
+(NSString *)getErroCodeString:(int)code;
@end
