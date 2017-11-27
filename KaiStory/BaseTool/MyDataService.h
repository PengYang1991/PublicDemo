//
//  MyDataService.h
//  01 NavigationTask
//
//  Created by yangpeng on 14-9-5.
//  Copyright (c) 2014年 www.iphonetrain.com . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyDataService : NSObject


+ (void)requestURL:(NSString *)urlstring
        httpMethod:(NSString *)method
            params:(NSMutableDictionary *)params
       complection:(void(^)(id result))block;


+ (void)requestAFURL:(NSString *)urlstring
          httpMethod:(NSString *)method
              params:(NSMutableDictionary *)params
                data:(NSMutableDictionary *)datas
         complection:(void(^)(id result))block;

+ (void)requestAFURLPlus:(NSString *)urlstring
              httpMethod:(NSString *)method
                  params:(NSMutableDictionary *)params
                    data:(NSMutableDictionary *)datas
              completion:(void(^)(id result))block
                    fail:(void(^)(NSError *error))fail_block;

//上传文件请求



@end
