//
//  SWTHttpTool.h
//  SX-SWT
//
//  Created by 何键键 on 16/7/27.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define uuid "2c7be2ce-1bfe-11e6-b6ba-3e1d05defe79"
//#define version "1.0"
//#define appId "1c7bd52c-1bfe-11e6-b6ba-3e1d05defe78"
//#define md5key "834ebef38ca6"

@interface GYHttpTool : NSObject
+ (void)get:(NSString *)url ticket:(NSString *)ticket params:(NSDictionary *)params success:(void(^)(id json))success failure:(void(^)(NSError *error)) failure;
+ (void)post:(NSString *)url ticket:(NSString *)ticket params:(NSDictionary *)params success:(void(^)(id json))success failure:(void(^)(NSError *error)) failure;
@end
