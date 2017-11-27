//
//  NSToolsObject.m
//  Cars Circle
//
//  Created by 刘登坛(iZealot) on 13-5-31.
//  Copyright (c) 2013年 liudengtan@gmail.com All rights reserved.
//

#import "NSToolsObject.h"
#import "Reachability.h"
@implementation NSToolsObject
#pragma mark NSString 为空(nil)的验证
+ (BOOL)isEmptyOrNull:(NSString *)string{
    if (string == nil) {
        return YES;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
#pragma mark  Email验证
+ (BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma mark 电话号验证
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,181
     22         */
    NSString * CT = @"^1((33|53|81|8[09])[0-9]|349)\\d{7}$";
    
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        
        || ([regextestcu evaluateWithObject:mobileNum] == YES)
        
        || ([regextestphs evaluateWithObject:mobileNum] == YES))
        
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
#pragma mark 验证身份证是否合法
/**
 * 功能:验证身份证是否合法
 * 参数:输入的身份证号
 */
+ (BOOL)isIdCard:(NSString *)sPaperId
{
    //判断位数
    if ([sPaperId length] < 15 ||[sPaperId length] > 18) {
        return NO;
    }
    NSString *carid = sPaperId;
    long lSumQT =0;
    //加权因子
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    //校验码
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    //将15位身份证号转换成18位
    NSMutableString *mString = [NSMutableString stringWithString:sPaperId];
    if ([sPaperId length] == 15) {
        [mString insertString:@"19" atIndex:6];
        long p = 0;
        const char *pid = [mString UTF8String];
        for (int i=0; i<=16; i++)
        {
            p += (pid[i]-48) * R[i];
        }
        int o = p%11;
        NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
        
    }
    //判断地区码
    NSString * sProvince = [carid substringToIndex:2];
    
    if (![self areaCode:sProvince]) {
        
        return NO;
    }
    //判断年月日是否有效
    /*
    //年份
    int strYear = [[self getStringWithRange:carid Value1:6 Value2:4] intValue];
    //月份
    int strMonth = [[self getStringWithRange:carid Value1:10 Value2:2] intValue];
    //日
    int strDay = [[self getStringWithRange:carid Value1:12 Value2:2] intValue];
     */
    //年份
    int strYear = [[carid substringWithRange:NSMakeRange(6, 4)]intValue];
    //月份
    int strMonth = [[carid substringWithRange:NSMakeRange(10, 2)]intValue];
    //日
    int strDay = [[carid substringWithRange:NSMakeRange(12, 2)]intValue];
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",strYear,strMonth,strDay]];
    if (date == nil) {
        
        return NO;
    }
    
    const char *PaperId  = [carid UTF8String];
    
    //检验长度
    if( 18 != strlen(PaperId)) return -1;
    //校验数字
    for (int i=0; i<18; i++)
    {
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) )
        {
            return NO;
        }
    }
    //验证最末的校验码
    for (int i=0; i<=16; i++)
    {
        lSumQT += (PaperId[i]-48) * R[i];
    }
    if (sChecker[lSumQT%11] != PaperId[17] )
    {
        return NO;
    }
    
    return YES;
}
/**
 * 功能:判断是否在地区码内
 * 参数:地区码
 */
+(BOOL)areaCode:(NSString *)code
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"国外" forKey:@"91"];
    
    if ([dic objectForKey:code] == nil) {
        
        return NO;
    }
    return YES;
}
/**
 * 功能:获取指定范围的字符串
 * 参数:字符串的开始小标
 * 参数:字符串的结束下标
 */
/*
+(NSString *)getStringWithRange:(NSString *)str Value1:(int)value1 Value2:(int )value2;
{
    return [str substringWithRange:NSMakeRange(value1, value2)];
}*/

/**
 * 功能:验证一个数是否是浮点数
 * 参数:浮点数
 
#pragma mark 验证一个数是否是浮点数
+ (BOOL)isFloatingNumber:(NSString *)fnumber{
    NSString *floatRegex = @"/^-?([1-9]\\d*\\.\\d*|0\\.\\d*[1-9]\\d*|0?\\.0+|0)$/";
    NSPredicate *floatTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", floatRegex];
    return [floatTest evaluateWithObject:fnumber];
}*/

/**
 生成当前时间字符串
 @returns 当前时间字符串
 */
//获取当前时间 作为录音的名称
+(NSString *) getCurrentTimeString
{
    //用时间命名//
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy_MM_dd_HHmmss"];
    
    NSString *timeString = [NSString stringWithString:[dateFormatter stringFromDate:date]];
    return timeString;
}

//获取存储路径字符串函数 参数：录音名称 存储类型
+(NSString *)getPathString:(NSString *)pathName type:(NSString *)pathType
{
    //获取路径//
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentDirectory=[paths objectAtIndex:0];
    
    //获取存储URL//
    NSString *soundFilePath = [[documentDirectory stringByAppendingPathComponent:pathName] stringByAppendingPathExtension:pathType];
    return soundFilePath;
}
/**
 获取缓存路径
 @returns 缓存路径
 */
+ (NSString*)getCacheDirectory
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    return [paths objectAtIndex:0];
}

/**
 判断文件是否存在
 @param _path 文件路径
 @returns 存在返回yes
 */
+ (BOOL)fileExistsAtPath:(NSString*)_path
{
    return [[NSFileManager defaultManager] fileExistsAtPath:_path];
}

/**
 删除文件
 @param _path 文件路径
 @returns 成功返回yes
 */
+ (BOOL)deleteFileAtPath:(NSString*)_path
{
    return [[NSFileManager defaultManager] removeItemAtPath:_path error:nil];
}

/**
 获取当前系统日期
 @returns 月日
 */
+(NSString *)getSystemDate{
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"MM月dd日"];
    return [dateformatter stringFromDate:senddate];
}
+(NSString *)getSystemDateyyyy{
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    return [dateformatter stringFromDate:senddate];
}
/**
 @param strdate 日期字符
 @returns 转换后的日期
 */
+(NSDate *)stringToDate:(NSString *)strdate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *retdate = [dateFormatter dateFromString:strdate];
    return retdate;
}
/**
 NSDate 转 NSString
 @param date 要转的日期
 @returns 转后的日期字符
 */
+(NSString *)dateToString:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}
//返回day天后的日期(若day为负数,则为|day|天前的日期)
+ (NSString *)dateAfterDay:(int)day
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // Get the weekday component of the current date
    // NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    // to get the end of week for a particular date, add (7 - weekday) days
    [componentsToAdd setDay:day];
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:[NSDate date] options:0];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM月dd日"];
    NSString *strDate = [dateFormatter stringFromDate:dateAfterDay];
    
    return strDate;
}
//返回day天后的日期(若day为负数,则为|day|天前的日期)
+ (NSString *)dateAfterDay2:(int)day
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // Get the weekday component of the current date
    // NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    // to get the end of week for a particular date, add (7 - weekday) days
    [componentsToAdd setDay:day];
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:[NSDate date] options:0];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:dateAfterDay];
    
    return strDate;
}
+(BOOL)isNetWorkStatus{
    NetworkStatus networkStatus = [Reachability reachabilityForInternetConnection].currentReachabilityStatus;
    if (networkStatus == NotReachable) {
        return NO;
    }
    return YES;
}
+(NSString *)getTimeHMS:(int)m{
    int shi,fen,miao;
    /*
    if(m/3600<24){
            shi = m/3600;
            
            fen = m/60%60;
            miao = m%60;
            //printf("\n%02d:%02d:%02d:\n",shi,fen,miao);
        return [NSString stringWithFormat:@"%d时%d分%d秒",shi,fen,miao];
    }else {
        shi = m/3600;
        fen = m/60%60;
        miao = m%60;
        //printf("\n%02d:%02d:%02d:\n",shi,fen,miao);
        return [NSString stringWithFormat:@"%d时%d分%d秒",shi,fen,miao];
    }
    */
    shi = m/3600;
    fen = m/60%60;
    miao = m%60;
    
    return [NSString stringWithFormat:@"%d:%d:%d",shi,fen,miao];
}


+(NSString *)getErroCodeString:(int)code{
    NSString *codeString=@"";
    switch (code) {
        case 10001:
        {
            codeString=@"字段不能为空";
        }
            break;
        case 10002:
        {
            codeString=@"手机格式错误";
        }
            break;
        case 10003:
        {
            codeString=@"手机号已经存在,请换一个";
        }
            break;
        case 10004:
        {
            codeString=@"邮箱格式不正确";
        }
            break;
        case 10005:
        {
            codeString=@"邮箱已存在,请换一个";
        }
            break;
        case 10006:
        {
            codeString=@"验证码错误";
        }
            break;
        case 10007:
        {
            codeString=@"短信发送失败,请检查后重试";
        }
            break;
        case 10008:
        {
            codeString=@"手机号不存在";
        }
            break;
        case 10009:
        {
            codeString=@"提示用户登录超时,请重新登录";
        }
            break;
        case 10010:
        {
            codeString=@"登录失败,用户名或密码错误";
        }
            break;
        case 10011:
        {
            codeString=@"邮箱不存在";
        }
            break;
        case 10012:
        {
            codeString=@"邮件发送失败,请检查后重试";
        }
            break;
        case 10013:
        {
            codeString=@"原始密码错误,请检查后重试";
        }
            break;
        case 10014:
        {
            codeString=@"两次密码不一致";
        }
            break;
        case 10015:
        {
            codeString=@"更新失败";
        }
            break;
        case 10016:
        {
            codeString=@"已收藏过了";
        }
            break;
        case 10017:
        {
            codeString=@"收藏失败";
        }
            break;
            
        default:
            break;
    }
    return codeString;
}
@end
