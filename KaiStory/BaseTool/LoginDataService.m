//
//  LoginDataService.m
//  Networking
//
//  Created by yangpeng on 15/3/16.
//  Copyright (c) 2015年 yangpeng. All rights reserved.
//

#import "LoginDataService.h"
#import "AFNetworking.h"
#define BASE_URL @"http://test.login.kaishuhezi.com"

#define HTML5_URL @"http://h5.kaishuhezi.com/daily/show.html?id="

@implementation LoginDataService

+ (void)requestAFURL:(NSString *)urlstring
          httpMethod:(NSString *)method
              params:(NSMutableDictionary *)params
                data:(NSMutableDictionary *)datas
         complection:(void(^)(id result))block {
    
    urlstring = [BASE_URL stringByAppendingString:urlstring];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    if ([method isEqualToString:@"GET"]) {
        
        [manager GET:urlstring parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            block(responseObject);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"网络请求失败:%@",error);
        }];
    }
    else if([method isEqualToString:@"POST"]) {
        
        if (datas != nil) { //判断是否有文件需要上传
            
            //上传文件的POST请求
            AFHTTPRequestOperation *operation = [manager POST:urlstring parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                
                //将需要上传的文件数据添加到formData
                
                //循环遍历需要上的文件数据
                for (NSString *name in datas) {
                    NSData *data = datas[name];
                    
                    [formData appendPartWithFileData:data name:name fileName:name mimeType:@"image/jpeg"];
                    
                }
                
                
            } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                block(responseObject);
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"网络请求失败：%@",error);
            }];
            
            //设置上传的进度监听
            /**
             *
             *  @param bytesWritten              一个数据包的大小
             *  @param totalBytesWritten         已经上传的数据大小
             *  @param totalBytesExpectedToWrite 文件总大小
             *
             *  @return <#return value description#>
             */
            [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
                
                CGFloat progress = totalBytesWritten/(CGFloat)totalBytesExpectedToWrite;
                NSLog(@"进度：%.1f",progress);
                
            }];
            
        } else {
            
            [manager POST:urlstring parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                block(responseObject);
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                NSLog(@"网络请求失败：%@",error);
                
            }];
            
        }
        
    }
    
}


//NSData
+(void)requestAFURL1:(NSString *)urlstring
          httpMethod:(NSString *)method
              params:(NSMutableDictionary *)params
                data:(NSMutableDictionary *)datas
         complection:(void(^)(id result))block {
    
//    urlstring = [HTML5_URL stringByAppendingString:urlstring];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    if ([method isEqualToString:@"GET"]||[method isEqualToString:@"get"]) {
        
        [manager GET:urlstring parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            block(responseObject);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"网络请求失败:%@",error);
        }];
    }
    else if([method isEqualToString:@"POST"]||[method isEqualToString:@"post"]) {
        
        if (datas != nil) { //判断是否有文件需要上传
            
            //上传文件的POST请求
            AFHTTPRequestOperation *operation = [manager POST:urlstring parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                
                //将需要上传的文件数据添加到formData
                
                //循环遍历需要上的文件数据
                for (NSString *name in datas) {
                    NSData *data = datas[name];
                    
                    [formData appendPartWithFileData:data name:name fileName:name mimeType:@"image/jpeg"];
                    
                }
                
                
            } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                block(responseObject);
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"网络请求失败：%@",error);
            }];
            
            //设置上传的进度监听
            /**
             *
             *  @param bytesWritten              一个数据包的大小
             *  @param totalBytesWritten         已经上传的数据大小
             *  @param totalBytesExpectedToWrite 文件总大小
             *
             *  @return <#return value description#>
             */
            [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
                
                CGFloat progress = totalBytesWritten/(CGFloat)totalBytesExpectedToWrite;
                NSLog(@"进度：%.1f",progress);
                
            }];
            
        } else {
            
            [manager POST:urlstring parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                block(responseObject);
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                NSLog(@"网络请求失败：%@",error);
                
            }];
            
        }
        
    }
    
}








@end
