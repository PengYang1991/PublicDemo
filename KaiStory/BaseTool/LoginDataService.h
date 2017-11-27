//
//  LoginDataService.h
//  Networking
//
//  Created by yangpeng on 15/3/16.
//  Copyright (c) 2015年 yangpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginDataService : NSObject

+ (void)requestAFURL:(NSString *)urlstring
          httpMethod:(NSString *)method
              params:(NSMutableDictionary *)params
                data:(NSMutableDictionary *)datas
         complection:(void(^)(id result))block;

+ (void)requestAFURL1:(NSString *)urlstring
          httpMethod:(NSString *)method
              params:(NSMutableDictionary *)params
                data:(NSMutableDictionary *)datas
         complection:(void(^)(id result))block;
@end
