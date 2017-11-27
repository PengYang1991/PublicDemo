
#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "Tools.h"
#import "TableModel.h"
@interface SqliteControl : NSObject
@property (strong,nonatomic)FMDatabase *database;
@property BOOL isFirstRun;
+(SqliteControl *) sharedController;
-(BOOL)openSqlite;
-(BOOL)createTableAll;
-(BOOL)initData;
-(BOOL)updateTableInfo:(NSString *)tableName tablefield:(NSMutableDictionary *)field;
-(BOOL)deleteTableInfo:(NSString *)tableName tablefield:(NSMutableDictionary *)field;
-(BOOL)insertTableInfo:(NSString *)tableName tablefield:(NSMutableDictionary*)field;
//查询数据 多条数据 使用排序 + limit
-(NSArray *)selectTableInfo:(NSString *)tableName tablefield:(NSMutableDictionary *)field withDesc:(NSString *)desc limit:(NSString *)limit;

//插入数据 并得到最后插入的id
-(int)insertTableInfoGetLastId:(NSString *)tableName tablefield:(NSMutableDictionary*)field;
-(BOOL)createTable:(NSString *)tableName tablefield:(NSString *)field;
-(NSArray *)selectTableInfo:(NSString *)tableName tablefield:(NSMutableDictionary *)field;
-(NSArray *)selectTableInfo:(NSString *)tableName tablefield:(NSMutableDictionary *)field withDesc:(NSString *)desc;
//查询数据条数
-(int)CountTableInfo:(NSString *)tableName tablefield:(NSMutableDictionary *)field;
-(NSDictionary *)findTableInfo:(NSString *)tableName tablefield:(NSMutableDictionary *)field;
//更新数据 主键otherFiled为查询字段
-(BOOL)updateTableInfo:(NSString *)tableName tablefield:(NSMutableDictionary *)field withOtherField:(NSMutableDictionary *)otherFiled;
//查询数据 多条数据 使用排序 + limit +自定义where语句
-(NSArray *)selectTableInfo:(NSString *)tableName whrere:(NSString *)where withDesc:(NSString *)desc limit:(NSString *)limit;
//查询数据条数 根据where语句
-(int)CountTableInfo:(NSString *)tableName where:(NSString *)where;


//查询数据 自写select语句
-(NSArray *)selectWithNSString:(NSString *)select;
-(NSDictionary *)findWithNSString:(NSString *)select;
-(BOOL)deleteWithNSString:(NSString *)deleteString;

@end
