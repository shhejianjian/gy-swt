//
//  SWTHttpTool.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/27.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "GYHttpTool.h"
#import "AFNetworking.h"
#import "GYConst.h"
#import <CommonCrypto/CommonDigest.h>
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import "MXConstant.h"


@interface GYHttpTool ()<MBProgressHUDDelegate>

@end

@implementation GYHttpTool
+ (void)get:(NSString *)url ticket:(NSString *)ticket params:(NSDictionary *)params success:(void(^)(id json))success failure:(void(^)(NSError *error)) failure
{

    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json",@"text/javascript",@"text/plain",@"application/xml",@"application/javascript", nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *randCodeStr = [self get8bitString];//随机字符串
    NSString *timeStr = [self getTimeNow];
    NSString *thirdFlowStr = [self get32bitString];
    
    NSString *appid = @"1c7bd52c-1bfe-11e6-b6ba-3e1d05defe78";
    NSString *uuid = @"2c7be2ce-1bfe-11e6-b6ba-3e1d05defe79";
    NSString *md5key = @"834ebef38ca6";
    NSString *version = @"1.0";
    NSString *pastMD5Str = [NSString stringWithFormat:@"%@%@%@%@%@%@",uuid,url,thirdFlowStr,appid,randCodeStr,md5key];
    NSString *newMD5Str = [self md5HexDigest:pastMD5Str];
    
    // 2.利用AFN管理者发送请求
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    paramsDic[@"thirdFlow"] = thirdFlowStr;
    paramsDic[@"busiCode"] = url;
    paramsDic[@"loginName"] = @"";
    paramsDic[@"appId"] = appid;
    paramsDic[@"secM"] = newMD5Str;
    paramsDic[@"randCode"] = randCodeStr;
    paramsDic[@"time"] = timeStr;
    paramsDic[@"seqM"] = @"";
    paramsDic[@"uuid"] = uuid;
    paramsDic[@"version"] = version;
    paramsDic[@"ticket"] = ticket;
    paramsDic[@"parameters"] = params;
    NSMutableDictionary *newParams = [NSMutableDictionary dictionary];
    newParams[@"params"] = paramsDic;
    NSString *urlStr = [NSString stringWithFormat:@"%@?params={%@}",BaseUrl,paramsDic];
    NSString *UrlString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:UrlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
//获取系统当前时间，精确到秒
+ (NSString *)getTimeNow{
    NSString* date;
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYYMMddhhmmss"];
    date = [formatter stringFromDate:[NSDate date]];
    NSString *timeNow = [[NSString alloc] initWithFormat:@"%@", date];
    return timeNow;
}

+(NSString *)get32bitString{
    
    char data[32];
    
    for (int x=0;x<32;data[x++] = (char)('a' + (arc4random_uniform(26))));
    
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
    
}

+(NSString *)get8bitString{
    
    //自动生成8位随机密码
    NSTimeInterval random=[NSDate timeIntervalSinceReferenceDate];
    NSString *randomString = [NSString stringWithFormat:@"%.8f",random];
    NSString *randompassword = [[randomString componentsSeparatedByString:@"."]objectAtIndex:1];
    
    return randompassword;
    
}

+ (NSString *)md5HexDigest:(NSString*)input
{
    const char *cStr = [input UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (void)post:(NSString *)url ticket:(NSString *)ticket params:(NSDictionary *)params success:(void(^)(id json))success failure:(void(^)(NSError *error)) failure
{
    
    
    // 1.创建AFN管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json",@"text/javascript",@"text/plain", nil];
    NSString *randCodeStr = [self get8bitString];//随机字符串
    NSString *timeStr = [self getTimeNow];
    NSString *thirdFlowStr = [self get32bitString];
    
    NSString *appid = @"1c7bd52c-1bfe-11e6-b6ba-3e1d05defe78";
    NSString *uuid = @"2c7be2ce-1bfe-11e6-b6ba-3e1d05defe79";
    NSString *md5key = @"834ebef38ca6";
    NSString *version = @"1.0";
    NSString *pastMD5Str = [NSString stringWithFormat:@"%@%@%@%@%@%@",uuid,url,thirdFlowStr,appid,randCodeStr,md5key];
    NSString *newMD5Str = [self md5HexDigest:pastMD5Str];

    // 2.利用AFN管理者发送请求
        NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
        paramsDic[@"thirdFlow"] = thirdFlowStr;
        paramsDic[@"busiCode"] = url;
        paramsDic[@"loginName"] = @"";
        paramsDic[@"appId"] = appid;
        paramsDic[@"secM"] = newMD5Str;
        paramsDic[@"randCode"] = randCodeStr;
        paramsDic[@"time"] = timeStr;
        paramsDic[@"seqM"] = @"";
        paramsDic[@"uuid"] = uuid;
        paramsDic[@"version"] = version;
        paramsDic[@"ticket"] = ticket;
        paramsDic[@"parameters"] = params;
    
    NSString *paramsDicStr = [self dictionaryToJson:paramsDic];
    NSDictionary *newParams = @{@"params":paramsDicStr};
    NSString *urlStr = [NSString stringWithFormat:@"%@",BaseUrl];
    
    [manager POST:urlStr parameters:newParams success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

+ (void)postImage:(NSString *)url ticket:(NSString *)ticket params:(NSDictionary *)params success:(void(^)(id json))success failure:(void(^)(NSError *error)) failure{
    
    // 1.创建AFN管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json",@"text/javascript",@"text/plain",@"image/jpg",@"application/pdf", nil];
    NSString *randCodeStr = [self get8bitString];//随机字符串
    NSString *timeStr = [self getTimeNow];
    NSString *thirdFlowStr = [self get32bitString];
    
    NSString *appid = @"1c7bd52c-1bfe-11e6-b6ba-3e1d05defe78";
    NSString *uuid = @"2c7be2ce-1bfe-11e6-b6ba-3e1d05defe79";
    NSString *md5key = @"834ebef38ca6";
    NSString *version = @"1.0";
    NSString *pastMD5Str = [NSString stringWithFormat:@"%@%@%@%@%@%@",uuid,url,thirdFlowStr,appid,randCodeStr,md5key];
    NSString *newMD5Str = [self md5HexDigest:pastMD5Str];
    
    // 2.利用AFN管理者发送请求
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    paramsDic[@"thirdFlow"] = thirdFlowStr;
    paramsDic[@"busiCode"] = url;
    paramsDic[@"loginName"] = @"";
    paramsDic[@"appId"] = appid;
    paramsDic[@"secM"] = newMD5Str;
    paramsDic[@"randCode"] = randCodeStr;
    paramsDic[@"time"] = timeStr;
    paramsDic[@"seqM"] = @"";
    paramsDic[@"uuid"] = uuid;
    paramsDic[@"version"] = version;
    paramsDic[@"ticket"] = ticket;
    paramsDic[@"parameters"] = params;
    
    NSString *paramsDicStr = [self dictionaryToJson:paramsDic];
    NSDictionary *newParams = @{@"params":paramsDicStr};
    
    [manager POST:fileUrl parameters:newParams success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}








+ (void)uploadImage:(NSString *)url andImageData:(NSData *)image ticket:(NSString *)ticket params:(NSDictionary *)params success:(void(^)(id json))success failure:(void(^)(NSError *error)) failure{
    
    
    
    
    NSString *randCodeStr = [self get8bitString];//随机字符串
    NSString *timeStr = [self getTimeNow];
    NSString *thirdFlowStr = [self get32bitString];
    
    NSString *appid = @"1c7bd52c-1bfe-11e6-b6ba-3e1d05defe78";
    NSString *uuid = @"2c7be2ce-1bfe-11e6-b6ba-3e1d05defe79";
    NSString *md5key = @"834ebef38ca6";
    NSString *version = @"1.0";
    NSString *pastMD5Str = [NSString stringWithFormat:@"%@%@%@%@%@%@",uuid,url,thirdFlowStr,appid,randCodeStr,md5key];
    NSString *newMD5Str = [self md5HexDigest:pastMD5Str];
    
    // 2.利用AFN管理者发送请求
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    paramsDic[@"thirdFlow"] = thirdFlowStr;
    paramsDic[@"busiCode"] = url;
    paramsDic[@"loginName"] = @"";
    paramsDic[@"appId"] = appid;
    paramsDic[@"secM"] = newMD5Str;
    paramsDic[@"randCode"] = randCodeStr;
    paramsDic[@"time"] = timeStr;
    paramsDic[@"seqM"] = @"";
    paramsDic[@"uuid"] = uuid;
    paramsDic[@"version"] = version;
    paramsDic[@"ticket"] = ticket;
    paramsDic[@"parameters"] = params;
    
    NSString *paramsDicStr = [self dictionaryToJson:paramsDic];
    NSDictionary *newParams = @{@"params":paramsDicStr};
    
    NSString *urlStr = [NSString stringWithFormat:@"%@",BaseUrl];
    
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg",timeStr];
    
    NSError *playerError = nil;
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request =
    [serializer multipartFormRequestWithMethod:@"POST"//请求方法为post
                                     URLString:urlStr//上传文件URL
                                    parameters:newParams//上传的其他参数
                     constructingBodyWithBlock:^(id<AFMultipartFormData> formData)//设置请求体
     {
         [formData appendPartWithFileData:image//音乐媒体文件的data对象
                                     name:@"files"//与数据关联的参数名称，不能为nil
                                 fileName:fileName//上传的文件名，不能为nil
                                 mimeType:@"image/jpg"];
     } error:&playerError];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json",@"text/javascript",@"text/plain",@"image/jpg", nil];
    AFHTTPRequestOperation *operation =
    [manager HTTPRequestOperationWithRequest:request
                                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                         if (success) {
                                             success(responseObject);
                                         }
                                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         
                                         if (failure) {
                                             failure(error);
                                         }
                                     }];
    [operation setUploadProgressBlock:^(NSUInteger __unused bytesWritten,
                                        long long totalBytesWritten,//已上传的字节数
                                        long long totalBytesExpectedToWrite)//总字节数
     {
         double f =  ((double)totalBytesWritten / totalBytesExpectedToWrite);
         [SVProgressHUD showProgress:f status:@"上传中"];
         if (f >= 1.000000) {
             
             [SVProgressHUD dismiss];
             
         }
     }];
    [operation start];
}


@end
