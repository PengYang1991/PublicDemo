//
//  Tools.m
//  Jello
//
//  Created by wuxiang on 13-5-31.
//  Copyright (c) 2013年 wuxiang. All rights reserved.
//

#import "Tools.h"
#import <Foundation/NSObject.h>
#import "sys/sysctl.h"
#import <UIKit/UIKit.h>
#import "SqliteControl.h"
@implementation Tools
static CGRect oldframe;
+(void)nsLogStart:(id)logValue andString:(NSString *)string
{
    if (VALUEFORNSLOG==1) {
        NSLog(@"%@ %@",string,logValue);
    }
}




+(float)widthWithFontLenthUIlabel:(UILabel *)uilabel
{
    CGSize theStringSize = [uilabel.text sizeWithFont:uilabel.font
                                    constrainedToSize:uilabel.frame.size
                                        lineBreakMode:uilabel.lineBreakMode];
    uilabel.frame = CGRectMake(uilabel.frame.origin.x,
                               uilabel.frame.origin.y,
                               theStringSize.width+10, theStringSize.height);
    return theStringSize.width;
}
//根据字大小 字符串长度 以及控件宽度计算 拉长的高度
+ (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:0];
    
    return sizeToFit.height;
}
+ (float) heightForChineseString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    NSMutableString *chineseString=[NSMutableString stringWithString:@""];
    for (int i = 0; i<[value length]; i++) {
        unichar ch = [value characterAtIndex:i];
        if (0x4e00 < ch  && ch < 0x9fff)
        {
            [chineseString appendFormat:@"你"];
        }
    }
    //    NSLog(@"chineseString %@",chineseString);
    CGSize sizeToFit = [chineseString sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:0];
    
    return sizeToFit.height;
}
//计算View高 根据控件高
+(float)viewHeight:(UIView *)viewmain
{
    int scrollViewHeight=0;
    for (UIView* view in viewmain.subviews){
        scrollViewHeight += view.frame.size.height;
    }
    return scrollViewHeight;
}
//根据color字符串转换UIColor
+(UIColor*)stringRPGForUIColor:(NSString *)color
{
    NSArray *array=[color componentsSeparatedByString:@","];
    float colorR=[(NSString *)[array objectAtIndex:0] floatValue]/255;
    float colorG=[(NSString *)[array objectAtIndex:1] floatValue]/255;
    float colorB=[(NSString *)[array objectAtIndex:2] floatValue]/255;
    UIColor *retColor=[UIColor colorWithRed:colorR green:colorG blue:colorB alpha:100];
    return retColor;
}
//16进制color转UIColor
+ (UIColor *)colorWithHexString:(NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}
//特殊字符替换
+(NSString *)JSONString:(NSString *)aString {
    NSMutableString *s = [NSMutableString stringWithString:aString];
    //[s replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    //[s replaceOccurrencesOfString:@"/" withString:@"\\/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\n" withString:@"\\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\b" withString:@"\\b" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\f" withString:@"\\f" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\r" withString:@"\\r" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\t" withString:@"\\t" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    return [NSString stringWithString:s];
}


+(NSString *)timescempTotime:(NSString *)timescemp
{
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timescemp intValue]];
    NSString *time=[NSString stringWithFormat:@"%@",confromTimesp];
    [time substringFromIndex:20];
    
    return time;
}
+(NSString *)activitTimeFromStarTime:(NSString *)startTime EndTime:(NSString *)endTime
{
    NSString *start=[self activityTimecompent:startTime];
    NSString *end=[self activityTimecompent:endTime];
    
    NSString *com=[NSString stringWithFormat:@"活动时间:%@ - %@",start,end];
    
    return com;
}

+(NSString *)activityTimecompent:(NSString *)time
{
    NSArray *timeArray=[time componentsSeparatedByString:@" "];
    NSString *str1=[self stringCompmentWithString:[timeArray objectAtIndex:0] tag:@"-" index:1];
    NSString *str2=[self stringCompmentWithString:[timeArray objectAtIndex:0] tag:@"-" index:2];
    NSString *str3=[self stringCompmentWithString:[timeArray objectAtIndex:1] tag:@":" index:0];
    NSString *str4=[self stringCompmentWithString:[timeArray objectAtIndex:1] tag:@":" index:1];
    
    NSString *com=[NSString stringWithFormat:@"%@.%@/%@:%@",str1,str2,str3,str4];
    
    return com;
}
+(NSString *)stringCompmentWithString:(NSString *)string tag:(NSString *)tag index:(int)i
{
    NSArray *array=[string componentsSeparatedByString:tag];
    
    NSString *str=(NSString *)[array objectAtIndex:i];
    return str;
}
+(NSString *)intervalSinceNow: (NSString *) theDate
{
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[date dateFromString:theDate];
    
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    
    NSTimeInterval cha=late-now;
    
    if (cha/3600<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
        
    }
    if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    if (cha/86400>1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@天前", timeString];
        
    }
    return timeString;
}
+ (NSString *)timerFireMethodWithTme:(NSString *)stattime
{//:(NSTimer*)theTimer
    //NSDateFormatter *dateformatter = [[[NSDateFormatter alloc]init] autorelease];//定义NSDateFormatter用来显示格式
    //[dateformatter setDateFormat:@"yyyy MM dd hh mm ss"];//设定格式
    NSCalendar *cal = [NSCalendar currentCalendar];//定义一个NSCalendar对象
    NSDateComponents *shibo = [[NSDateComponents alloc] init];//初始化目标时间（好像是世博会的日期）
    NSArray *timeArray=[stattime componentsSeparatedByString:@" "];
    //NSLog(@"timeArray %i",[(NSString *)[self stringCompmentWithString:[timeArray objectAtIndex:0] tag:@"-" index:1] intValue]);
    //使用NSTimer实现倒计时
    [shibo setYear:[(NSString *)[self stringCompmentWithString:[timeArray objectAtIndex:0] tag:@"-" index:0] intValue]];
    [shibo setMonth:[(NSString *)[self stringCompmentWithString:[timeArray objectAtIndex:0] tag:@"-" index:1] intValue]];
    [shibo setDay:[(NSString *)[self stringCompmentWithString:[timeArray objectAtIndex:0] tag:@"-" index:2] intValue]];
    [shibo setHour:[(NSString *)[self stringCompmentWithString:[timeArray objectAtIndex:1] tag:@":" index:0] intValue]];
    [shibo setMinute:[(NSString *)[self stringCompmentWithString:[timeArray objectAtIndex:1] tag:@":" index:1] intValue]];
    [shibo setSecond:[(NSString *)[self stringCompmentWithString:[timeArray objectAtIndex:1] tag:@":" index:2] intValue]];
    
    NSDate *todate = [cal dateFromComponents:shibo];//把目标时间装载入date
    // NSString *ssss = [dateformatter stringFromDate:dd];
    // NSLog([NSString stringWithFormat:@"shibo shi:%@",ssss]);
    
    NSDate *today = [NSDate date];//得到当前时间
    // NSString *sss = [dateformatter stringFromDate:today];
    // NSLog([NSString stringWithFormat:@"xianzai shi:%@",sss]);
    //用来得到具体的时差
    //unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    unsigned int unitFlags =  NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *d = [cal components:unitFlags fromDate:today toDate:todate options:0];
    //NSString *str= [NSString stringWithFormat:@"%d年%d月%d日%d时%d分%d秒",[d year],[d month], [d day], [d hour], [d minute], [d second]];
    NSString *str= [NSString stringWithFormat:@"%d日%d时%d分%d秒" ,(int)[d day], (int)[d hour], (int)[d minute], (int)[d second]];
    
    return str;
}
+(BOOL)judgeTimeForNow:(NSString *)time
{
    NSString *jude=[self timerFireMethodWithTme:time];
    NSString *yn=[jude substringToIndex:1];
    if ([yn isEqualToString:@"-"]) {
        return NO;
    }else{
        return YES;
    }
}
//改变数据源数值 key 所需对比字段 value对比的值 array数据源 changekey需要改变的键 changeValue需要改变的值
+(NSMutableArray *)changeNetWorkDataWithKey:(NSString *)key
                                      value:(NSString *)value
                                netWorkData:(NSMutableArray *)array
                                  changeKey:(NSString *)changeKey
                                changeValue:(NSString *)changeValue
{
    for (NSMutableDictionary *dic in array) {
        if ([[dic objectForKey:key] isEqualToString:value]) {
            [dic setObject:changeValue forKey:changeKey];
            NSLog(@"%@",[dic objectForKey:key]);
        }
    }
    return array;
    
}
+(BOOL)saveImage:(UIImage *)currentImage withName:(NSString *)fullPath{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    [imageData writeToFile:fullPath atomically:NO];
    // 将图片写入文件
    NSFileManager * fileManage=[NSFileManager defaultManager];
    if ([fileManage fileExistsAtPath:fullPath]) {
        return YES;
    }
    return NO;
}
+(BOOL)deleteImage:(NSString *)imagePath{
    
    NSFileManager * fileManage=[NSFileManager defaultManager];
    if ([fileManage fileExistsAtPath:imagePath]) {
        [fileManage removeItemAtPath:imagePath error:nil];
        
        return YES;
    }
    return NO;
}
+(NSString *)makeImageName{
    NSTimeInterval time=[[NSDate date]timeIntervalSince1970];
    NSString * imageName= [ NSString stringWithFormat:@"%f.png" ,time];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    return fullPath;
}
+(NSString *)readTimeChangeToTimescerm:(NSString *)time
{
    
    //    NSString* timeStr = @"2019-5-2 8:2";
    NSString *timeStr=time;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:timeStr]; //------------将字符串按formatter转成nsdate
    //    NSLog(@"date %@",date);
    //    时间转时间戳的方法:
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    //    NSLog(@"timeSp:%@",timeSp); //时间戳的值
    return timeSp;
    
}
+(NSString *)activityTypeChangeToNum:(NSString *)name
{
    if ([name isEqualToString:@"学校"]) {
        return @"3";
    }
    if ([name isEqualToString:@"咖啡厅"]) {
        return @"2";
    }
    if ([name isEqualToString:@"酒吧"]) {
        return @"1";
    }
    if ([name isEqualToString:@"夜店"]) {
        return @"4";
    }
    if ([name isEqualToString:@"商场"]) {
        return @"5";
    }
    
    return nil;
    
}
//数据库插入 字典转字符串 放在数组 array[0]=(string)keys array[1]=(string)value
+(NSMutableArray*)dictionryChangeToString:(NSMutableDictionary *)dic
{
    NSArray *keys=[dic allKeys];
    NSArray *values=[dic allValues];
    NSMutableString *strKeys=[[NSMutableString alloc]init];
    NSMutableString *strValues=[[NSMutableString alloc]init];
    NSMutableArray *field=[NSMutableArray arrayWithCapacity:2];
    for (NSString * str in keys) {
        [strKeys appendFormat:@"%@,",str];
    }
    for (NSString * str in values) {
        [strValues appendFormat:@"%@,",str];
    }
    int keysLong=(int)[strKeys length];
    int valuesLong=(int)[strValues length];
    [strKeys deleteCharactersInRange:NSMakeRange(keysLong-1, 1)];
    [strValues deleteCharactersInRange:NSMakeRange(valuesLong-1, 1)];
    [field addObject:strKeys];
    [field addObject:strValues];
    return field;
}
//数据库插入 字典转字符串 放在数组 array[0]=(string)keys array[1]=(string)value
+(NSMutableArray*)dictionryChangeToInsertString:(NSMutableDictionary *)dic
{
    NSArray *keys=[dic allKeys];
    NSArray *values=[dic allValues];
    NSMutableString *strKeys=[[NSMutableString alloc]init];
    NSMutableString *strValues=[[NSMutableString alloc]init];
    NSMutableArray *field=[NSMutableArray arrayWithCapacity:2];
    for (NSString * str in keys) {
        [strKeys appendFormat:@"%@,",str];
    }
    
    for (NSString * str in values) {
        
        [strValues appendFormat:@"\"%@\",",str];
        
        
    }
    [strKeys appendString:@"createTime"];
    [strValues appendFormat:@"\"%@\"",[self strDateForNow]];
    //    int keysLong=(int)[strKeys length];
    //    int valuesLong=(int)[strValues length];
    //    [strKeys deleteCharactersInRange:NSMakeRange(keysLong-1, 1)];
    //    [strValues deleteCharactersInRange:NSMakeRange(valuesLong-1, 1)];
    [field addObject:strKeys];
    [field addObject:strValues];
    return field;
}
//数据库插入 字典转字符串 放在数组 array[0]=(string)keys array[1]=(string)value
+(NSMutableArray*)dictionryChangeToInsertStringAndChangeDoublePointToOnePoint:(NSMutableDictionary *)dic
{
    NSArray *keys=[dic allKeys];
    NSArray *values=[dic allValues];
    NSMutableString *strKeys=[[NSMutableString alloc]init];
    NSMutableString *strValues=[[NSMutableString alloc]init];
    NSMutableArray *field=[NSMutableArray arrayWithCapacity:2];
    for (NSString * str in keys) {
        [strKeys appendFormat:@"%@,",str];
    }
    for (NSString * str in values) {
        //        NSLog(@"dictionryChangeToInsertString %@",str);
        
        [strValues appendFormat:@"\"%@\",",[Tools strDeleteDoubleTagWithStr:[NSString stringWithFormat:@"%@",str]]];
        
    }
    int keysLong=(int)[strKeys length];
    int valuesLong=(int)[strValues length];
    [strKeys deleteCharactersInRange:NSMakeRange(keysLong-1, 1)];
    [strValues deleteCharactersInRange:NSMakeRange(valuesLong-1, 1)];
    [field addObject:strKeys];
    [field addObject:strValues];
    return field;
}
//数据库查询 数组转字符串   key = value  AND key = value
+(NSString *)dicChangeToStringForSelectWhere:(NSMutableDictionary *)dic
{
    NSArray *keys=[dic allKeys];
    NSArray *values=[dic allValues];
    NSMutableString *strSql=[[NSMutableString alloc]init];
    
    for (int i = 0 ; i<[keys count]; i++) {
        [strSql appendFormat:@" %@ = \"%@\" AND",[keys objectAtIndex:i],[values objectAtIndex:i]];
    }
    //    NSLog(@"=====>%@",strSql);
    //warning 增加判断
    if (strSql.length>6) {
        [strSql deleteCharactersInRange:NSMakeRange([strSql length]-3, 3)];
    }
    
    
    
    return strSql;
}
//数据库删除 数组转字符串   key = value AND key = value
+(NSString *)dicChangeToStringForDeleteWhere:(NSMutableDictionary *)dic
{
    NSArray *keys=[dic allKeys];
    NSArray *values=[dic allValues];
    NSMutableString *strSql=[[NSMutableString alloc]init];
    
    for (int i = 0 ; i<[keys count]; i++) {
        [strSql appendFormat:@" %@ = \"%@\" AND",[keys objectAtIndex:i],[values objectAtIndex:i]];
    }
    [strSql deleteCharactersInRange:NSMakeRange([strSql length]-3, 3)];
    
    return strSql;
}
//判断 数据流传过来的值是否为所需要的code值
+(BOOL)isRecevieStr:(NSString *)log
{
    //    NSLog(@"isRecevieStr %@",log);
    if ([log hasPrefix:@"{\"code"]) {
        log=[log substringWithRange:NSMakeRange(2, 4)];
        NSLog(@"isRecevieStr %@",log);
        return YES;
    }
    return NO;
}
//现在时间 2013-08-26 10:52:37
+(NSString *)dateNowToStr
{
    NSDate *data=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    [formatter setTimeZone:timeZone];
    NSString *nowtimeStr = [formatter stringFromDate:data];
    return nowtimeStr;
}
//数据库查询 数组转字符串   key = value , key = value where id = XX
+(NSString *)dicChangeToStringForUpdate:(NSMutableDictionary *)dic
{
    NSArray *keys=[dic allKeys];
    NSArray *values=[dic allValues];
    NSMutableString *strSql=[[NSMutableString alloc]init];
    for (int i = 0 ; i<[keys count]; i++) {
        if ([[keys objectAtIndex:i]isEqual:@"id"]) {
            continue;
        }
        [strSql appendFormat:@" %@ = \"%@\" ,",[keys objectAtIndex:i],[values objectAtIndex:i]];
    }
    
    [strSql deleteCharactersInRange:NSMakeRange([strSql length]-1, 1)];
    [strSql appendFormat:@" WHERE id = %@",[dic objectForKey:@"id"]];
    return strSql;
}
//数据库查询 数组转字符串   key = value , key = value
+(NSString *)dicChangeToStringForUpdateWithOtherField:(NSMutableDictionary *)dic
{
    NSArray *keys=[dic allKeys];
    NSArray *values=[dic allValues];
    NSMutableString *strSql=[[NSMutableString alloc]init];
    for (int i = 0 ; i<[keys count]; i++) {
        [strSql appendFormat:@" %@ = \"%@\" ,",[keys objectAtIndex:i],[values objectAtIndex:i]];
    }
    [strSql deleteCharactersInRange:NSMakeRange([strSql length]-1, 1)];
    return strSql;
}
//发送数据由字典转字符串    -无反斜杠
+(NSString *)sendDataWithDic:(NSDictionary *)datadic
{
    NSArray *keys=[datadic allKeys];
    NSArray *values=[datadic allValues];
    NSMutableString *strSql=[[NSMutableString alloc]init];
    for (int i = 0 ; i<[keys count]; i++) {
        if ([[keys objectAtIndex:i]isEqual:@"serviceCode"]) {
            continue;
        }
        if ([[values objectAtIndex:i]hasPrefix:@"-"]) {
            //            NSLog(@"[[values objectAtIndex:i] length] %i",[[values objectAtIndex:i] length]);
            [strSql appendFormat:@"\\\"%@\\\":%@,",[keys objectAtIndex:i],[[values objectAtIndex:i] substringWithRange:NSMakeRange(1, [[values objectAtIndex:i] length]-1)]];
        }else{
            [strSql appendFormat:@"\\\"%@\\\":\\\"%@\\\",",[keys objectAtIndex:i],[values objectAtIndex:i]];
        }
        
    }
    if ([strSql length]>1) {
        [strSql deleteCharactersInRange:NSMakeRange([strSql length]-1, 1)];
        [strSql setString:[NSString stringWithFormat:@"{\"data\":\"{%@}\",\"serviceCode\":\"%@\"}",strSql,datadic[@"serviceCode"]]];
    }else{
        [strSql setString:[NSString stringWithFormat:@"{\"data\":\"\",\"serviceCode\":\"%@\"}",datadic[@"serviceCode"]]];
    }
    
    
    //    NSLog(@"strSql %@",strSql);
    return strSql;
}
//发送数据由数组转字符串    -无反斜杠 无data serviceCode
+(NSString *)sendDataWithArray:(NSArray *)array
{
    NSMutableString *strSql=[[NSMutableString alloc]initWithString:@"["];
    for (NSDictionary *datadic in array) {
        NSArray *keys=[datadic allKeys];
        NSArray *values=[datadic allValues];
        for (int i = 0 ; i<[keys count]; i++) {
            if (i==0) {
                [strSql appendString:@"{"];
            }
            if ([[values objectAtIndex:i]hasPrefix:@"-"]) {
                [strSql appendFormat:@"\\\"%@\\\":%@,",[keys objectAtIndex:i],[[values objectAtIndex:i]substringWithRange:NSMakeRange(1, [(NSString *)values length])]];
            }else{
                [strSql appendFormat:@"\\\"%@\\\":\\\"%@\\\",",[keys objectAtIndex:i],[values objectAtIndex:i]];
            }
            if (i==[keys count]-1) {
                [strSql deleteCharactersInRange:NSMakeRange([strSql length]-1, 1)];
                [strSql appendString:@"},"];
            }
        }
        
    }
    [strSql deleteCharactersInRange:NSMakeRange([strSql length]-1, 1)];
    [strSql appendString:@"]"];
    return strSql;
}//发送数据由数组转字符串    -无反斜杠 无data serviceCode
+(NSString *)sendDataWithDictonary:(NSDictionary *)dictionary
{
    NSMutableString *strSql=[[NSMutableString alloc]initWithString:@"{"];
    NSArray *keys=[dictionary allKeys];
    NSArray *values=[dictionary allValues];
    for (int i = 0 ; i<[keys count]; i++) {
        
        if ([[values objectAtIndex:i]hasPrefix:@"-"]) {
            [strSql appendFormat:@"\\\"%@\\\":%@,",[keys objectAtIndex:i],[[values objectAtIndex:i]substringWithRange:NSMakeRange(1, 1)]];
        }else{
            [strSql appendFormat:@"\\\"%@\\\":\\\"%@\\\",",[keys objectAtIndex:i],[values objectAtIndex:i]];
        }
        
    }
    [strSql deleteCharactersInRange:NSMakeRange([strSql length]-1, 1)];
    [strSql appendString:@"}"];
    return strSql;
}
//发送数据由字典转字符串    -无反斜杠
+(NSString *)sendDataWithDicOutServiceCode:(NSDictionary *)datadic
{
    NSArray *keys=[datadic allKeys];
    NSArray *values=[datadic allValues];
    NSMutableString *strSql=[[NSMutableString alloc]init];
    for (int i = 0 ; i<[keys count]; i++) {
        
        if ([[values objectAtIndex:i]hasPrefix:@"-"]) {
            [strSql appendFormat:@"\\\"%@\\\":%@,",[keys objectAtIndex:i],[[values objectAtIndex:i]substringWithRange:NSMakeRange(1, 1)]];
        }else{
            [strSql appendFormat:@"\\\"%@\\\":\\\"%@\\\",",[keys objectAtIndex:i],[values objectAtIndex:i]];
        }
        
    }
    if ([strSql length]>1) {
        [strSql deleteCharactersInRange:NSMakeRange([strSql length]-1, 1)];
        [strSql setString:[NSString stringWithFormat:@"{\"data\":\"{%@}\",\"serviceCode\":\"%@\"}",strSql,datadic[@"serviceCode"]]];
    }else{
        [strSql setString:[NSString stringWithFormat:@"{\"data\":\"\",\"serviceCode\":\"%@\"}",datadic[@"serviceCode"]]];
    }
    
    
    //    NSLog(@"strSql %@",strSql);
    return strSql;
}
//发送数据由字典转字符串    -无反斜杠
+(NSString *)sendDataWithStr:(NSDictionary *)datadic
{
    NSString *strSql=[NSString stringWithFormat:@"{\"data\":\"%@\",\"serviceCode\":\"%@\"}",datadic[@"data"],datadic[@"serviceCode"]];
    
    return strSql;
}

//删除数据流传过来的值中的标示符反斜杠 LogIn
+(NSString *)strForJsonNormalFromServerJson:(NSString *)str
{
    
    str =[str stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    NSString *changeStr=[Tools strForJsonNormalFromServerJsonDeleteFlag:(NSMutableString *)str];
    
    
    return changeStr;
}
//删除数据流传过来的值中的标示符转成json
+(NSMutableString *)strForJsonNormalFromServerJsonDeleteFlag:(NSMutableString *)str

{
    NSRange range=[str rangeOfString:@":\"{"];//获取字符串"Deaf"字串的范围
    
    if (range.length!=0) {
        [str replaceCharactersInRange:range withString:@":{"];
    }
    range=[str rangeOfString:@"}\"}"];//获取字符串"Deaf"字串的范围
    if (range.length!=0) {
        [str replaceCharactersInRange:range withString:@"}}"];
    }
    range=[str rangeOfString:@"]\"}"];//获取字符串"Deaf"字串的范围
    if (range.length!=0) {
        [str replaceCharactersInRange:range withString:@"]}"];
    }
    
    range=[str rangeOfString:@":\"["];//获取字符串"Deaf"字串的范围
    
    if (range.length!=0) {
        [str replaceCharactersInRange:range withString:@":["];
    }
    
    range=[str rangeOfString:@"]\""];//获取字符串"Deaf"字串的范围
    if (range.length!=0) {
        [str replaceCharactersInRange:range withString:@"]"];
        
    }
    range=[str rangeOfString:@"]\"}"];//获取字符串"Deaf"字串的范围
    if (range.length!=0) {
        [str replaceCharactersInRange:range withString:@"]}"];
    }
    
    
    //    NSLog(@"STRM %@",str);
    return str;
}

//截取字符串开头结尾
+(void )subStringWithFirstAndLast:(NSMutableString *)str
{
    
    NSRange range=[str rangeOfString:@"\\\""];//获取字符串"Deaf"字串的范围
    //    NSLog(@"range %i",range.location);
    if (range.length!=0) {
        [str replaceCharactersInRange:range withString:@"\""];
        //        NSLog(@"STRM %@",strM);
        [Tools subStringWithFirstAndLast:str];
    }
}
//array 0 年 1 月 2天
+(NSArray *)chineseDateFormeters
{
    NSMutableArray *array=[[NSMutableArray alloc]init];
    NSMutableArray *yearArray=[[NSMutableArray alloc]init];
    NSMutableArray *monthArray=[[NSMutableArray alloc]init];
    NSMutableArray *dayArray=[[NSMutableArray alloc]init];
    for(int i = 1;i<32;i++){
        if (i<13) {
            [monthArray addObject:[NSString stringWithFormat:@"%i",i]];
        }
        [dayArray addObject:[NSString stringWithFormat:@"%i",i]];
    }
    for (int i = 2013; i>1933; i--) {
        [yearArray addObject:[NSString stringWithFormat:@"%i",i]];
    }
    [array addObject:[yearArray mutableCopy]];
    [array addObject:[monthArray mutableCopy]];
    [array addObject:[dayArray mutableCopy]];
    return array;
}
+(NSString *)getCurrentTime
{
    
    NSDate *nowUTC = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    
    return [dateFormatter stringFromDate:nowUTC];
    
}
+(NSString *)strDeleteDoubleTagWithStr:(NSString *)str
{
    //    if (str>=0) {
    //        return str;
    //    }
    for (int i = 0; i<[str length]; i++) {
        //截取字符串中的每一个字符
        NSString *s = [str substringWithRange:NSMakeRange(i, 1)];
        //        NSLog(@"string is %@",s);
        if ([s isEqualToString:@"\""]) {
            NSRange range = NSMakeRange(i, 1);
            //将字符串中的“m”转化为“w”
            str = [str stringByReplacingCharactersInRange:range withString:@"'"];
            
        }
    }
    return str;
}
//2013-09-05 现在时间
+(NSString *)strDateTimeForNow
{
    NSDate* date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    return [formatter stringFromDate:date];
    
}
//2013-09-05 现在时间
+(NSString *)strDateForNow
{
    NSDate* date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    return [formatter stringFromDate:date];
}
// 字符串 04 转 int 4
+(int)strChangeToInt:(NSString *)str
{
    
    if ([str length]>2&&![str hasPrefix:@"0"]) {
        return 1;
    }else if([str length]==0){
        return 1;
    }
    else{
        NSMutableString *string=[NSMutableString stringWithFormat:@"%@",str];
        [string deleteCharactersInRange:NSMakeRange(0, 1)];
        
        return (int)[string integerValue];
    }
    
}
//正则表达式验证
+ (BOOL) regularUserInputText : (NSString *) str RegularString:(NSString *)regular
{
    
    //    NSString *patternStr = @"^[\u0391-\uFFE5A-Za-z0-9_]{2,20}$";
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:regular
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:str
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, str.length)];
    
    
    if(numberofMatch > 0)
    {
        NSLog(@"%@ isNumbericString: YES", str);
        return YES;
    }
    
    return NO;
}
+(void)showImage:(UIImageView *)avatarImageView{
    UIImage *image=avatarImageView.image;
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    oldframe=[avatarImageView convertRect:avatarImageView.bounds toView:window];
    backgroundView.backgroundColor=[UIColor whiteColor];
    backgroundView.alpha=0;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:oldframe];
    imageView.image=image;
    imageView.tag=1;
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        backgroundView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}

+(void)hideImage:(UITapGestureRecognizer*)tap{
    UIView *backgroundView=tap.view;
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=oldframe;
        backgroundView.alpha=0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}
+ (NSString*)doDevicePlatform

{
    
    size_t size;
    
    int nR = sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    
    char *machine = (char *)malloc(size);
    
    nR = sysctlbyname("hw.machine", machine, &size, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    
    free(machine);
    
    //    NSLog(@"platform %@",platform);
    
    if ([platform isEqualToString:@"iPhone1,1"]) {
        
        platform = @"iPhone";
        
    } else if ([platform isEqualToString:@"iPhone1,2"]) {
        
        platform = @"iPhone 3G";
        
    } else if ([platform isEqualToString:@"iPhone2,1"]) {
        
        platform = @"iPhone 3GS";
        
    } else if ([platform isEqualToString:@"iPhone3,1"]) {
        
        platform = @"iPhone 4";
        
    } else if ([platform isEqualToString:@"iPhone4,1"]) {
        
        platform = @"iPhone 4S";
        
    } else if ([platform isEqualToString:@"iPod4,1"]) {
        
        platform = @"iPod touch 4";
        
    } else if ([platform isEqualToString:@"iPad3,2"]) {
        
        platform = @"iPad 3 3G";
        
    } else if ([platform isEqualToString:@"iPad3,1"]) {
        
        platform = @"iPad 3 WiFi";
        
    } else if ([platform isEqualToString:@"iPad2,2"]) {
        
        platform = @"iPad 2 3G";
        
    } else if ([platform isEqualToString:@"iPad2,1"]) {
        
        platform = @"iPad 2 WiFi";
        
    }else if ([platform isEqualToString:@"i386"]||[platform isEqualToString:@"x86_64"]) {
        
        platform = @"iPhone Simulator";
        
    }else if ( [[platform substringToIndex:7] isEqualToString:@"iPhone5"]) {
        
        platform = @"iPhone 5";
        
    }else if ([[platform substringToIndex:4] isEqualToString:@"iPad"]){
        
        platform = @"iPad";
        
    }else if ( [[platform substringToIndex:6] isEqualToString:@"iPhone"]) {
        
        platform = @"iPhone";
        
    }else if( [[platform substringToIndex:6] isEqualToString:@"iTouch"]){
        platform = @"iTouch";
    }else{
        platform = @"iPhone";
    }
    
    NSLog(@"platform %@",platform);
    return platform;
    
}
+(BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+ (NSString*) getLongitude{
    // TODO
    return @"";
}

+ (NSString*) getLatitude{
    // TODO
    return @"";
}

// 2015年04月15日 yanzehua
// 对于各个页面的更新请求，统一记录了上一次请求的时间，用于判断当前是否需要更新
+ (BOOL) checkTimeExpire:(NSString*)timeKey ExpireSeconds:(int) expireSeconds
{
    NSMutableDictionary* whereDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [whereDict setValue:timeKey forKey:@"key"];
    NSDictionary* resultDict =[[SqliteControl sharedController] findTableInfo:@"rawTable" tablefield:whereDict];
    NSString* lastUpdateTimeStr = (NSString*)[resultDict objectForKey:@"value"];
    int lastUpdateTimeInt = [lastUpdateTimeStr intValue];
    NSLog(@"LastUpdateTimeInt %d",lastUpdateTimeInt);
    // 获取当前时间
    int currentTimeInt = [[NSDate date] timeIntervalSince1970];
    NSLog(@"currentTimeInt %d",currentTimeInt);
    
    if(currentTimeInt - lastUpdateTimeInt > expireSeconds)
    {
        return YES;
    }
    return NO;
}

+ (NSString*) getCacheJson:(NSString*)jsonKey
{
    NSMutableDictionary* whereDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [whereDict setValue:jsonKey forKey:@"key"];
    NSDictionary* resultDict =[[SqliteControl sharedController] findTableInfo:@"rawTable" tablefield:whereDict];
    //NSLog(@"getCacheJson %@",resultDict);
    NSString* jsonStr = [resultDict objectForKey:@"value"];
    for (int i = 0; i<[jsonStr length]; i++) {
        //截取字符串中的每一个字符
        NSString *s = [jsonStr substringWithRange:NSMakeRange(i, 1)];
        if ([s isEqualToString:@"$"]) {
            NSRange range = NSMakeRange(i, 1);
            //将字符串中的$转化为“
            jsonStr =  [jsonStr stringByReplacingCharactersInRange:range withString:@"\""];
            
        }
    }
    return jsonStr;
}

+(NSDictionary* )getCacheJsonDict:(NSString*)jsonKey{
    NSString* jsonStr = [Tools getCacheJson:jsonKey];
    if(NO == [Tools isBlankString:jsonStr] )
    {
        NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        return dic;
    }
    return nil;
}

+ (BOOL) setUpdateTime:(NSString*)timeKey
{
    NSMutableDictionary* whereDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [whereDict setValue:timeKey forKey:@"key"];
    // 获取当前时间
    NSDate* currentDate = [NSDate date];
    int interval = [currentDate timeIntervalSince1970];
    NSString *currentDateStr = [NSString stringWithFormat:@"%d", interval];
    NSMutableDictionary* updateDict =[[NSMutableDictionary alloc] initWithCapacity:10];
    [updateDict setValue:currentDateStr forKey:@"value"];
    return [[SqliteControl sharedController] updateTableInfo:@"rawTable" tablefield:updateDict withOtherField:whereDict];
}


+ (BOOL) setCacheJson:(NSString*) jsonStr forKey:(NSString*) jsonKey
{
    for (int i = 0; i<[jsonStr length]; i++) {
        //截取字符串中的每一个字符
        NSString *s = [jsonStr substringWithRange:NSMakeRange(i, 1)];
        if ([s isEqualToString:@"\""]) {
            NSRange range = NSMakeRange(i, 1);
            //将字符串中的“转化为$
            jsonStr =  [jsonStr stringByReplacingCharactersInRange:range withString:@"$"];
            
        }
    }
    
    NSMutableDictionary* whereDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [whereDict setValue:jsonKey forKey:@"key"];
    NSString* oldRecord = [Tools getCacheJson:jsonKey];
    // 如果没有旧的数据，则发生插入行为
    if ([Tools isBlankString:oldRecord]) {
        NSMutableDictionary* insertDict =[[NSMutableDictionary alloc] initWithCapacity:10];
        [insertDict setValue:jsonKey forKey:@"key"];
        [insertDict setValue:jsonStr forKey:@"value"];
        [insertDict setValue:@"0" forKey:@"version"];
        return [[SqliteControl sharedController]insertTableInfo:@"rawTable" tablefield:insertDict];
    }
    else // 如果有旧的数据，则发生更新行为
    {
        NSMutableDictionary* updateDict =[[NSMutableDictionary alloc] initWithCapacity:10];
        [updateDict setValue:jsonStr forKey:@"value"];
        
        return [[SqliteControl sharedController] updateTableInfo:@"rawTable" tablefield:updateDict withOtherField:whereDict];
    }
}

+ (NSString*) getRawData:(NSString*) rawKey
{
    NSMutableDictionary* whereDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [whereDict setValue:rawKey forKey:@"key"];
    NSDictionary* resultDict =[[SqliteControl sharedController] findTableInfo:@"rawTable" tablefield:whereDict];
    NSLog(@"getRawData %@",resultDict);
    return [resultDict objectForKey:@"value"];
}

+ (BOOL) setRawData:(NSString*) rawData forKey:(NSString*) rawKey
{
    NSMutableDictionary* whereDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [whereDict setValue:rawKey forKey:@"key"];
    NSMutableDictionary* updateDict =[[NSMutableDictionary alloc] initWithCapacity:10];
    [updateDict setValue:rawData forKey:@"value"];
    return [[SqliteControl sharedController] updateTableInfo:@"rawTable" tablefield:updateDict withOtherField:whereDict];
}

+(UIImage*) replaceColor:(UIColor*)oldColor withColor:(UIColor*)newColor inImage:(UIImage*)destImg

{
    CGImageRef destImgRef = [destImg CGImage];
    NSUInteger width = CGImageGetWidth(destImgRef);
    NSUInteger height = CGImageGetHeight(destImgRef);
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    //整体图片的bytes值
    NSUInteger bytesTotal = bytesPerRow * height;
    
    unsigned char *rawData = (unsigned char*) calloc(bytesTotal, sizeof(unsigned char));
    NSUInteger  bitsPerComponent=8;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //创建绘图的Context
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGColorSpaceRelease(colorSpace);
    
    //把原始图绘制上去
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), destImgRef);
    CGColorRef cgOldColor = [oldColor CGColor];
    const CGFloat *oldComponents = CGColorGetComponents(cgOldColor);
    float rOld = oldComponents[0]*255;
    float gOld = oldComponents[1]*255;
    float bOld = oldComponents[2]*255;
    float transOld = oldComponents[3]*255;
    NSLog(@"OldColor %f %f %f %f", rOld,gOld,bOld,transOld);
    
    
    CGColorRef cgNewColor = [newColor CGColor];
    const CGFloat *newComponents = CGColorGetComponents(cgNewColor);
    float rNew = newComponents[0]*255;
    float gNew = newComponents[1]*255;
    float bNew = newComponents[2]*255;
    float transNew = newComponents[3]*255;
    NSLog(@"New %f %f %f %f", rNew,gNew,bNew,transNew);
    //遍历所有的像素点,进行颜色的替换
    
    int byteIndex = 0;
    
    NSLog(@"Total bytes %ld",bytesTotal);
    
    while (byteIndex < bytesTotal) {
        unsigned char red   = rawData[byteIndex];
        unsigned char green = rawData[byteIndex + 1];
        unsigned char blue  = rawData[byteIndex + 2];
        unsigned char alpha = rawData[byteIndex + 3];
        // NSLog(@"R:%d,G:%d,B:%d,Alpha:%d",red,green,blue,rawData[byteIndex + 3]);
        if (  (float)alpha >= transOld-200 && (float)alpha <= transOld+200){
            rawData[byteIndex] = rNew;
            rawData[byteIndex + 1] = gNew;
            rawData[byteIndex + 2] = bNew;
            rawData[byteIndex + 3] = 255;
            
        }
        if(red!=0 || green!=0 || blue!=0)
        {
            NSLog(@"Color %d %d %d",red,green,blue);
        }
        byteIndex += 4;
    }
    //返回新的Image
    UIImage *result = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    free(rawData);
    return result;
}
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(!err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    NSLog(@"json解析失败：%@",dic);
    return dic;
}

+(NSString *)NSDictionaryToString:(id)result
{
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString* serialStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"SerialStr is %@",serialStr);
    for (int i = 0; i<[serialStr length]; i++) {
        //截取字符串中的每一个字符
        NSString *s = [serialStr substringWithRange:NSMakeRange(i, 1)];
        if ([s isEqualToString:@"\""]) {
            NSRange range = NSMakeRange(i, 1);
            //将字符串中的“m”转化为“w”
            serialStr =  [serialStr stringByReplacingCharactersInRange:range withString:@"$"];
            
        }
    }
    return serialStr;
}
+(id)StringToNSDictionary:(NSString *)jsonStr
{
    for (int i = 0; i<[jsonStr length]; i++)
    {
        //截取字符串中的每一个字符
        NSString *s = [jsonStr substringWithRange:NSMakeRange(i, 1)];
        if ([s isEqualToString:@"$"]) {
            NSRange range = NSMakeRange(i, 1);
            //将字符串中的“m”转化为“w”
            jsonStr =  [jsonStr stringByReplacingCharactersInRange:range withString:@"\""];
            
        }
    }
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    
    return dic;
}


+(void) saveStoryItem:(StoryModel*) storyItem
{
    NSString *modelStr = [[NSKeyedArchiver archivedDataWithRootObject:storyItem] base64Encoding];
    NSString *modelKey = [NSString stringWithFormat:@"STORYINFO_%@",storyItem.m_id ];
    [Tools setCacheJson:modelStr forKey:modelKey];
}
+(StoryModel*) getStoryItem:(NSString*) storyId
{
    NSString* modelKey = [NSString stringWithFormat:@"STORYINFO_%@",storyId];
    NSString* modelStr = [Tools getCacheJson:modelKey];
    NSData* modelData = [[NSData alloc]initWithBase64Encoding:modelStr];
    StoryModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:modelData];
    return model;
}

+(void) saveAlbumItem:(KSAlbumModel*) albumItem
{
    NSString *modelStr = [[NSKeyedArchiver archivedDataWithRootObject:albumItem] base64Encoding];
    NSString *modelKey = [NSString stringWithFormat:@"ALBUMINFO_%@",albumItem.modelID ];
    [Tools setCacheJson:modelStr forKey:modelKey];
}
+(KSAlbumModel*) getAlbumItem:(NSString*) albumID
{
    NSString* modelKey = [NSString stringWithFormat:@"ALBUMINFO_%@",albumID];
    NSString* modelStr = [Tools getCacheJson:modelKey];
    NSData* modelData = [[NSData alloc]initWithBase64Encoding:modelStr];
    KSAlbumModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:modelData];
    return model;
}
//设置宝宝性别
+(void) setBabySex:(NSInteger) babySex
{
    [[NSUserDefaults standardUserDefaults] setInteger:babySex forKey:@"babySex"];
}
+(NSInteger) getBabySex
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"babySex"];
}
// 设置宝宝年龄
+(void) setBabyAge:(NSInteger) babyAge
{
    [[NSUserDefaults standardUserDefaults] setInteger:babyAge forKey:@"babyAge"];
}
+(NSInteger) getBabyAge
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"babyAge"];
}
+(BOOL) isFirstStartUp{
   NSInteger tagInteger = [[NSUserDefaults standardUserDefaults] integerForKey:@"FirstStartApp"];
   if(0 == tagInteger)
       return YES;
    else
        return NO;
}
+(void) setNotFirstStartUp{
    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"FirstStartApp"];
}
@end
