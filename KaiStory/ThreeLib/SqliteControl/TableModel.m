
#import "TableModel.h"

@implementation TableModel

+(NSDictionary *)createAppConfigData
{
    //表名 app_config
    NSMutableDictionary *createDic=[[NSMutableDictionary alloc]initWithCapacity:10];
    [createDic setValue:@"integer Primary Key AUTOINCREMENT" forKey:@"id"];
    [createDic setValue:@"text" forKey:@"phone_id"];
    [createDic setValue:@"text" forKey:@"app_version"];
    [createDic setValue:@"text" forKey:@"has_info"];
    [createDic setValue:@"text" forKey:@"createTime"];
    
    return createDic;
}

+(NSDictionary *)createStoryInfo{
    //表名 StoryInfo
    
    NSMutableDictionary *createDic=[[NSMutableDictionary alloc]initWithCapacity:10];
    
    [createDic setValue:@"integer Primary Key AUTOINCREMENT" forKey:@"id"];
    [createDic setValue:@"text" forKey:@"author"];
    [createDic setValue:@"text" forKey:@"banner_url"];
    [createDic setValue:@"text" forKey:@"buy_url"];
    [createDic setValue:@"text" forKey:@"cover_url"];
    [createDic setValue:@"text" forKey:@"download_count"];
    [createDic setValue:@"text" forKey:@"duration"];
    [createDic setValue:@"text" forKey:@"favor_count"];
    [createDic setValue:@"text" forKey:@"icon_url"];
    [createDic setValue:@"text" forKey:@"m_id"];
    [createDic setValue:@"text" forKey:@"image_provider"];
    [createDic setValue:@"text" forKey:@"is_buy"];
    [createDic setValue:@"text" forKey:@"is_pay"];
    [createDic setValue:@"text" forKey:@"media_url"];
    [createDic setValue:@"text" forKey:@"name"];
    [createDic setValue:@"text" forKey:@"open_method"];
    [createDic setValue:@"text" forKey:@"open_params"];
    [createDic setValue:@"text" forKey:@"open_type"];
    [createDic setValue:@"text" forKey:@"open_url"];
    [createDic setValue:@"text" forKey:@"play_count"];
    [createDic setValue:@"text" forKey:@"price"];
    [createDic setValue:@"text" forKey:@"product_id"];
    [createDic setValue:@"text" forKey:@"publisher"];
    [createDic setValue:@"text" forKey:@"release_time"];
    [createDic setValue:@"text" forKey:@"source"];
    [createDic setValue:@"text" forKey:@"translater"];
    [createDic setValue:@"text" forKey:@"createTime"];
    
    return createDic;
}

+(NSDictionary *)createCategoryInfo{
    //表名 CategoryInfo
    NSMutableDictionary *createDic=[[NSMutableDictionary alloc]initWithCapacity:10];
    
    [createDic setValue:@"integer Primary Key AUTOINCREMENT" forKey:@"id"];
     [createDic setValue:@"text" forKey:@"m_id"];
     [createDic setValue:@"text" forKey:@"name"];
     [createDic setValue:@"text" forKey:@"icon_url"];
     [createDic setValue:@"text" forKey:@"banner_url"];
     [createDic setValue:@"text" forKey:@"open_params"];
     [createDic setValue:@"text" forKey:@"open_method"];
     [createDic setValue:@"text" forKey:@"createTime"];
    return createDic;
}

+(NSDictionary *)createDownloadStoryList{
    //表名 DownloadStoryList
    
    NSMutableDictionary *createDic=[[NSMutableDictionary alloc]initWithCapacity:10];
    [createDic setValue:@"integer Primary Key AUTOINCREMENT" forKey:@"id"];
    [createDic setValue:@"text" forKey:@"story_id"];
    [createDic setValue:@"text" forKey:@"product_id"];
    [createDic setValue:@"text" forKey:@"load_statu"];  //下载状态  0：下载完成  1：正在下载  2:暂停
    [createDic setValue:@"text" forKey:@"recieved_bytes"];  //接收
    [createDic setValue:@"text" forKey:@"total_bytes"];  //总共
    [createDic setValue:@"text" forKey:@"remark"];
    [createDic setValue:@"text" forKey:@"media_url"];
    [createDic setValue:@"text" forKey:@"createTime"];
    
    return createDic;
}

+(NSDictionary *)createDownloadCategoryList{
    //表名 DownloadCategoryList
    
    NSMutableDictionary *createDic=[[NSMutableDictionary alloc]initWithCapacity:10];
    [createDic setValue:@"integer Primary Key AUTOINCREMENT" forKey:@"id"];
    [createDic setValue:@"text" forKey:@"category_id"];
    [createDic setValue:@"text" forKey:@"createTime"];
    
    return createDic;
}

+(NSDictionary *)createPlayListCategory{
    //表名 PlayListCategory
    
    NSMutableDictionary *createDic=[[NSMutableDictionary alloc]initWithCapacity:10];
    [createDic setValue:@"integer Primary Key AUTOINCREMENT" forKey:@"id"];
    [createDic setValue:@"text" forKey:@"name"];
    [createDic setValue:@"text" forKey:@"createTime"];
    
    return createDic;
}

+(NSDictionary *)createPlayList{
    //表名 PlayList
    
    NSMutableDictionary *createDic=[[NSMutableDictionary alloc]initWithCapacity:10];
    [createDic setValue:@"integer Primary Key AUTOINCREMENT" forKey:@"id"];
    [createDic setValue:@"text" forKey:@"story_id"];
    [createDic setValue:@"text" forKey:@"list_category_id"];
    [createDic setValue:@"text" forKey:@"createTime"];
    
    return createDic;
}

+(NSDictionary *)createPlayStatus{
    //表名 PlayStatus
    
    NSMutableDictionary *createDic=[[NSMutableDictionary alloc]initWithCapacity:10];
    [createDic setValue:@"integer Primary Key AUTOINCREMENT" forKey:@"id"];
    [createDic setValue:@"text" forKey:@"currentTime"];
    [createDic setValue:@"text" forKey:@"status"];
    [createDic setValue:@"text" forKey:@"createTime"];
    
    return createDic;
}

+(NSDictionary *)createHistoryList{
    //表名 HistoryList
    NSMutableDictionary *createDic=[[NSMutableDictionary alloc]initWithCapacity:100];
    [createDic setValue:@"integer Primary Key AUTOINCREMENT" forKey:@"id"];
    [createDic setValue:@"text" forKey:@"story_id"];
    [createDic setValue:@"text" forKey:@"audio"];
    [createDic setValue:@"text" forKey:@"imageUrl"];
    [createDic setValue:@"text" forKey:@"name"];
    [createDic setValue:@"text" forKey:@"icon"];
    [createDic setValue:@"text" forKey:@"cId"];
    [createDic setValue:@"text" forKey:@"times"];
    [createDic setValue:@"text" forKey:@"play_count"];
    [createDic setValue:@"text" forKey:@"createTime"];
    return createDic;
}
+(NSDictionary *)createDaily{
    //表明 日课列表
    NSMutableDictionary *createDic = [[NSMutableDictionary alloc]initWithCapacity:100];
    [createDic setValue:@"integer Primary key AUTOINCREMENT" forKey:@"id"];
    [createDic setValue:@"text" forKey:@"story_id"];
    [createDic setValue:@"text" forKey:@"title"];
    [createDic setValue:@"text" forKey:@"summary"];
    [createDic setValue:@"text" forKey:@"open_type"];
    [createDic setValue:@"text" forKey:@"open_url"];
    [createDic setValue: @"text" forKey:@"open_params"];
    [createDic setValue: @"text" forKey:@"open_method"];
    [createDic setValue: @"text" forKey:@"img_url"];
    [createDic setValue: @"text" forKey:@"release_date"];
    [createDic setValue: @"text" forKey:@"read_count"];
    [createDic setValue: @"text" forKey:@"comment_count"];
    [createDic setValue:@"text" forKey:@"collect_count"];
    
    [createDic setValue:@"text" forKey:@"createTime"];
    return createDic;
}

+(NSString *)createlocalUserWithStr:(NSString *)tableName dic:(NSDictionary *)tableField
{
    NSArray *keys=[tableField allKeys];
    NSArray *values=[tableField allValues];
    NSMutableString *strSql=[[NSMutableString alloc]init];
    for (int i = 0 ; i<[keys count]; i++) {
        [strSql appendFormat:@" %@ %@ ,",[keys objectAtIndex:i],[values objectAtIndex:i]];
    }
    [strSql deleteCharactersInRange:NSMakeRange([strSql length]-1, 1)];
    strSql=[NSMutableString stringWithFormat:@"CREATE TABLE %@ (%@)",tableName,strSql];
    return strSql;
}


+(NSDictionary *)createTest
{
    NSMutableDictionary *createDic = [[NSMutableDictionary alloc]initWithCapacity:100];
    [createDic setValue:@"integer Primary key AUTOINCREMENT" forKey:@"id"];
    [createDic setValue:@"text" forKey:@"story_id"];
    [createDic setValue:@"text" forKey:@"title"];
    [createDic setValue:@"text" forKey:@"summary"];
    [createDic setValue:@"text" forKey:@"open_type"];
    [createDic setValue:@"text" forKey:@"open_url"];
    [createDic setValue: @"text" forKey:@"open_params"];
    [createDic setValue: @"text" forKey:@"open_method"];
    [createDic setValue: @"text" forKey:@"img_url"];
    [createDic setValue: @"text" forKey:@"release_date"];
    [createDic setValue: @"text" forKey:@"read_count"];
    [createDic setValue: @"text" forKey:@"comment_count"];
    [createDic setValue:@"text" forKey:@"collect_count"];    
    [createDic setValue:@"text" forKey:@"createTime"];
    return createDic;
    
    
//    return dic;
}
+(NSDictionary *)CreateCollection{
    NSMutableDictionary * CreateDic = [[NSMutableDictionary alloc]initWithCapacity:100];
    [CreateDic setValue:@"integer Primary key AUTOINCREMENT" forKey:@"id"];
    [CreateDic setValue:@"text" forKey:@"product_id"];
    [CreateDic setValue:@"text" forKey:@"name"];
    [CreateDic setValue:@"text" forKey:@"createTime"];
    return CreateDic;
}



+(NSDictionary *)CreateCustomList{
    NSMutableDictionary *createDir = [[NSMutableDictionary alloc]initWithCapacity:100];
    [createDir setValue:@"integer Primary key AUTOINCREMENT" forKey:@"id"];
    [createDir setValue:@"text" forKey:@"custom_id"];
    [createDir setValue:@"text" forKey:@"name"];
    [createDir setValue:@"text" forKey:@"createTime"];
    return createDir;
}

+(NSDictionary *)createLunBoList
{
    NSMutableDictionary *createDir = [[NSMutableDictionary alloc]initWithCapacity:100];
    [createDir setValue:@"integer Primary key AUTOINCREMENT" forKey:@"id"];
    [createDir setValue:@"text" forKey:@"LunBo_id"];
    [createDir setValue:@"text" forKey:@"img"];
    [createDir setValue:@"text" forKey:@"open_method"];
    [createDir setValue:@"text" forKey:@"open_params"];
    [createDir setValue:@"text" forKey:@"opentype"];
    [createDir setValue:@"text" forKey:@"open_url"];
    [createDir setValue:@"text" forKey:@"text"];
    [createDir setValue:@"text" forKey:@"createTime"];
    return createDir;
}

+(NSDictionary *) createRawTable
{
    NSMutableDictionary *createDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [createDict setValue:@"text" forKey: @"key"];
    [createDict setValue:@"text" forKey: @"value"];
    [createDict setValue:@"text" forKey: @"version"];
    [createDict setValue:@"text" forKey: @"createTime"];
    return createDict;
}

+(NSDictionary *)AlbumList
{
    NSMutableDictionary *createDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [createDict setValue:@"text" forKey: @"AlbumName"];
    [createDict setValue:@"text" forKey: @"JSON"];
    [createDict setValue:@"text" forKey: @"version"];
    [createDict setValue:@"text" forKey: @"createTime"];
    return createDict;
}
@end
