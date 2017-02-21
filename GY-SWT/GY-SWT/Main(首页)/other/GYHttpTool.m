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


@implementation GYHttpTool
+ (void)get:(NSString *)url ticket:(NSString *)ticket params:(NSDictionary *)params success:(void(^)(id json))success failure:(void(^)(NSError *error)) failure
{
//    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
//    [securityPolicy setAllowInvalidCertificates:YES];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json",@"text/javascript",@"text/plain",@"application/xml",@"application/javascript", nil];
//    [manager setSecurityPolicy:securityPolicy];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
//    NSString *randCodeStr = [self get32bitString];//随机字符串
//    NSString *timeStr = [self getTimeNow];
//    NSString *thirdFlowStr = [self get32bitString];
//    
//    NSString *pastMD5Str = [NSString stringWithFormat:@"%s%@%@%s%@%s",uuid,url,thirdFlowStr,appId,randCodeStr,md5key];
//    NSString *newMD5Str = [self md5HexDigest:pastMD5Str];
//    
//    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
//    
//    paramsDic[@"thirdFlow"] = @123456;
//    
//    paramsDic[@"busiCode"] = url;
//    
//    paramsDic[@"loginName"] = @"";
//    
//    paramsDic[@"appId"] = @appId;
//    
//    paramsDic[@"secM"] = @"c743529c8e38d14a867de23f6c59fde7";
//    
//    paramsDic[@"randCode"] = @123;
//    
//    paramsDic[@"time"] = timeStr;
//    
//    paramsDic[@"seqM"] = @"";
//    
//    paramsDic[@"uuid"] = @uuid;
//    
//    paramsDic[@"version"] = @version;
//    
//    paramsDic[@"ticket"] = @"88eb5aa0-9f66-4970-abfa-ef3c7ea3b879";
//    
//    paramsDic[@"parameters"] = params;
//    
//    NSString *urlStr = [NSString stringWithFormat:@"%@",BaseUrl];
//
//    NSMutableDictionary *newParams = [NSMutableDictionary dictionary];
//    newParams[@"params"] = paramsDic;
//    
//    NSLog(@"%@",urlStr);
//    
    //NSString *UrlString = [urlStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    NSString *randCodeStr = [self get8bitString];//随机字符串
    NSString *timeStr = [self getTimeNow];
    NSString *thirdFlowStr = [self get32bitString];
    
    NSString *appid = @"1c7bd52c-1bfe-11e6-b6ba-3e1d05defe78";
    NSString *uuid = @"2c7be2ce-1bfe-11e6-b6ba-3e1d05defe79";
    NSString *md5key = @"834ebef38ca6";
    NSString *version = @"1.0";
    NSString *pastMD5Str = [NSString stringWithFormat:@"%@%@%@%@%@%@",uuid,url,thirdFlowStr,appid,randCodeStr,md5key];
    NSLog(@"pastmd5==%@====%@====%@",pastMD5Str,randCodeStr,thirdFlowStr);
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
//    NSString *UrlString = [urlStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:UrlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"==%@",operation);
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
    //[formatter setDateFormat:@"YYYY.MM.dd.hh.mm.ss"];
    [formatter setDateFormat:@"YYYYMMddhhmmss"];
    date = [formatter stringFromDate:[NSDate date]];
    NSString *timeNow = [[NSString alloc] initWithFormat:@"%@", date];
    NSLog(@"%@", timeNow);
    return timeNow;
}

+(NSString *)get32bitString{
    
    char data[8];
    
    for (int x=0;x<8;data[x++] = (char)('a' + (arc4random_uniform(26))));
    
    return [[NSString alloc] initWithBytes:data length:8 encoding:NSUTF8StringEncoding];
    
}

+(NSString *)get8bitString{
    
    //自动生成8位随机密码
    NSTimeInterval random=[NSDate timeIntervalSinceReferenceDate];
    NSLog(@"now:%.8f",random);
    NSString *randomString = [NSString stringWithFormat:@"%.8f",random];
    NSString *randompassword = [[randomString componentsSeparatedByString:@"."]objectAtIndex:1];
    NSLog(@"randompassword:%@",randompassword);
    
    return randompassword;
    
}

+ (NSString *)md5HexDigest:(NSString*)input
{
//    const char* str = [input UTF8String];
//    unsigned char result[CC_MD5_DIGEST_LENGTH];
//    CC_MD5(str, strlen(str), result);
//    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
//    
//    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
//        [ret appendFormat:@"%02x",result[i]];
//    }
//    return ret;
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

//字典转字符串
+ (NSString *)setDictionaryToString:(NSDictionary *)dic {
    
    NSString *keyValueFormat;
    NSMutableString *result = [NSMutableString new];
    //实例化一个key枚举器用来存放dictionary的key
    NSEnumerator *keyEnum = [dic keyEnumerator];
    id key;
    while (key = [keyEnum nextObject]) {
        keyValueFormat = [NSString stringWithFormat:@"%@:%@,",key,[dic valueForKey:key]];
        [result appendString:keyValueFormat];
    }
    return result;
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
//    NSMutableDictionary *newParams = [NSMutableDictionary dictionary];
//    newParams[@"params"] = paramsDic;
    
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
//    //1.创建会话对象
//    NSURLSession *session = [NSURLSession sharedSession];
//    
//    //2.根据会话对象创建task
//    NSURL *urlstr = [NSURL URLWithString:@"http://202.101.70.125:8080/bs/request.shtml"];
//    
//    //3.创建可变的请求对象
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlstr];
//    
//    //4.修改请求方法为POST
//    request.HTTPMethod = @"POST";
//    
//    //5.设置请求体
//    NSData *data = [self returnDataWithDictionary:paramsDic];
//    request.HTTPBody = data;
//    
////    NSString *str = [NSString stringWithFormat:@"params={thirdFlow:%@,busiCode:%@,loginName:"",appId:%@,secM:%@,randCode:%@,time:%@,seqM:""&uuid:%@,version:%@,ticket:""}",thirdFlowStr,url,appid,newMD5Str,randCodeStr,timeStr,uuid,version];
////    NSLog(@"++--%@",str);
////    request.HTTPBody = [str dataUsingEncoding:NSUTF8StringEncoding];
//    
////    NSLog(@"data:%@",data);
//    
//    //6.根据会话对象创建一个Task(发送请求）
//    /*
//     第一个参数：请求对象
//     第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
//     data：响应体信息（期望的数据）
//     response：响应头信息，主要是对服务器端的描述
//     error：错误信息，如果请求失败，则error有值
//     */
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        
//        //8.解析数据
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//        NSLog(@"+++%@",dict);
//        
//    }];
//    
//    //7.执行任务
//    [dataTask resume];


//    [manager POST:urlStr parameters:paramsDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        NSData *jsonData = [self returnDataWithDictionary:paramsDic];
//        
//        [formData appendPartWithFormData:jsonData name:@"params"];
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        NSLog(@"%@--%@",paramsDic,responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@--%@",paramsDic,error);
//    }];
    
//字典转data
+(NSData *)returnDataWithDictionary:(NSDictionary *)dict
{
    NSMutableData * data = [[NSMutableData alloc] init];
    NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:dict forKey:@"params"];
    [archiver finishEncoding];
    
    return data;
}
    
    
//    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json",@"text/javascript",@"text/plain", nil];
//
//    NSString *randCodeStr = [self get32bitString];//随机字符串
//    NSString *timeStr = [self getTimeNow];
//    NSString *thirdFlowStr = [self get32bitString];
//    
//    NSString *pastMD5Str = [NSString stringWithFormat:@"%s%@%@%s%@%s",uuid,url,thirdFlowStr,appId,randCodeStr,md5key];
//    NSLog(@"%@",pastMD5Str);
//    NSString *newMD5Str = [self md5HexDigest:pastMD5Str];
//    
//    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
//    paramsDic[@"thirdFlow"] = thirdFlowStr;
//    paramsDic[@"busiCode"] = url;
//    paramsDic[@"loginName"] = @"";
//    paramsDic[@"appId"] = @appId;
//    paramsDic[@"secM"] = newMD5Str;
//    paramsDic[@"randCode"] = [self get8bitString];
//    paramsDic[@"time"] = timeStr;
//    paramsDic[@"seqM"] = @"";
//    paramsDic[@"uuid"] = @uuid;
//    paramsDic[@"version"] = @version;
//    paramsDic[@"ticket"] = ticket;
//    paramsDic[@"parameters"] = params;
//    
//    NSString *urlStr = [NSString stringWithFormat:@"%@",BaseUrl];
//
//    NSMutableDictionary *newParams = [NSMutableDictionary dictionary];
//    newParams[@"params"] = paramsDic;
//    
//    [manager POST:urlStr parameters:paramsDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        NSLog(@"123---%@",formData);
//    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        NSLog(@"456---====%@==%@",operation,paramsDic);
//        if (success) {
//            success(responseObject);
//        }
//    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//        NSLog(@"789---====%@",operation);
//        if (failure) {
//            failure(error);
//        }
//    }];

//    NSString *UrlString = [urlStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [manager POST:urlStr parameters:paramsDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        NSLog(@"====%@==%@",operation,paramsDic);
//        if (success) {
//            success(responseObject);
//        }
//    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
//        NSLog(@"====%@",operation);
//
//        if (failure) {
//            failure(error);
//        }
//    }];
//}

@end
