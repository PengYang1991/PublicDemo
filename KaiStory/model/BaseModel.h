//
//  BaseModel.h
//  KaiStory
//
//  Created by mac on 15/2/9.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

@property (strong,nonatomic)NSString *resCode;
@property (strong,nonatomic)NSString *resMsg;


-(id)initWithDict:(NSDictionary *)dict;
-(id)initWithCoder:(NSCoder *)coder;
-(void)encodeWithCoder: (NSCoder *)coder;


@end
