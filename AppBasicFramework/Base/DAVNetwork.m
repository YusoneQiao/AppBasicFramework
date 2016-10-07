//
//  DAVNetwork.m
//  DAV
//
//  Created by Davis.Qiao on 16/4/7.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#import "DAVNetwork.h"

@implementation DAVNetwork



#pragma mark -- GET请求 --
+(void)httpRequestGETWithPath:(NSString *)path
                    parameters:(NSDictionary *)paraDic
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error ))failure
{
    if (!path || path.length<1) {
        if (failure) {
            DAVDebugLog(@"%s path == nil",__FUNCTION__);
            failure([NSError failedConfigReopenError]);
        }
        return;
    }
    
    
    path = [DAVSetUpNetworkParam setUpParamStr:path];
    paraDic = [DAVSetUpNetworkParam setUpParamDic:paraDic];

    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    //可接受的类型（不加上这句话，会报“Request failed: unacceptable content-type: text/plain”错误，因为我们要获取text/plain类型数据）
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
//    //请求队列最大并发数
//    sessionManager.operationQueue.maxConcurrentOperationCount = 5;
//    //请求超时时间
//    sessionManager.requestSerializer.timeoutInterval = 15.0;
    
    DAVDebugLog(@"\nRequest path = %@\nRequest paraDic = %@",path,paraDic);
    
    [sessionManager GET:path parameters:paraDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
#if DEBUG
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        DAVDebugLog(@"Http get responseObject: %@",str);
#endif
        if (!responseObject) {
            DAVDebugLog(@"Http get responseObject is nil ...");
            if (failure) {
                failure([NSError unknowError]);
            }
            return;
        }
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (!dic) {
            if (failure) {
                failure([NSError unknowError]);
            }
            return;
        }
        
        if (success) {
            success(dic);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure([NSError networkError]);
        }
    }];
}



#pragma mark -- POST请求 --
+ (void)httpRequestPOSTWithPath:(NSString *)path
                     parameters:(NSDictionary *)paraDic
                        success:(void (^)(id responseObject))success
                        failure:(void (^)(NSError *error ))failure
{
    if (!path || path.length<1) {
        if (failure) {
            DAVDebugLog(@"%s path == nil",__FUNCTION__);
            failure([NSError failedConfigReopenError]);
        }
        return;
    }
    
    
    path = [DAVSetUpNetworkParam setUpParamStr:path];
    paraDic = [DAVSetUpNetworkParam setUpParamDic:paraDic];
    
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    //可接受的类型（不加上这句话，会报“Request failed: unacceptable content-type: text/plain”错误，因为我们要获取text/plain类型数据）
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];

    DAVDebugLog(@"\nRequest path = %@\nRequest paraDic = %@",path,paraDic);
    [sessionManager POST:path parameters:paraDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
#if DEBUG
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        DAVDebugLog(@"Request responseObject: %@",str);
#endif
        
        if (!responseObject) {
            DAVDebugLog(@"Http post responseObject is nil ...");
            if (failure) {
                failure([NSError unknowError]);
            }
            return;
        }
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (!dic) {
            if (failure) {
                failure([NSError unknowError]);
            }
            return;
        }
        
        if (success) {
            DAVDebugLog(@"home成功");
            success(dic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure([NSError networkError]);
        }
    }];
}



#pragma mark -- POST/GET网络请求 --
+ (void)httpRequestWithPath:(NSString *)path
                 parameters:(id)paraDic
                       type:(HttpRequestType)type
                    success:(void (^)(id responseObject))success
                    failure:(void (^)(NSError *error))failure
{
    switch (type) {
        case HttpRequestTypeGet:
        {
            [DAVNetwork httpRequestGETWithPath:path parameters:paraDic success:success failure:failure];
        }
            break;
        case HttpRequestTypePost:
        {
            [DAVNetwork httpRequestPOSTWithPath:path parameters:paraDic success:success failure:failure];
        }
            break;
    }
}



#pragma mark -- 上传图片 --
+ (void)httpUploadWithPath:(NSString *)path
                parameters:(id)paraDic
               uploadParam:(DAVUploadParam *)uploadParam
                   success:(void (^)())success
                   failure:(void (^)(NSError *error))failure
{
    
    path = [DAVSetUpNetworkParam setUpParamStr:path];
    paraDic = [DAVSetUpNetworkParam setUpParamDic:paraDic];
    
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    //可接受的类型（不加上这句话，会报“Request failed: unacceptable content-type: text/plain”错误，因为我们要获取text/plain类型数据）
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [sessionManager POST:path parameters:paraDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //拼接data到请求体，这个block的参数是遵守AFMultipartFormData协议的。
        [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.filename mimeType:uploadParam.mimeType];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
         // 这里可以获取到目前的数据请求的进度
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
#if DEBUG
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        DAVDebugLog(@"Request path: %@",path);
        DAVDebugLog(@"Request responseObject: %@",str);
#endif
        
        if (!responseObject) {
            DAVDebugLog(@"Http post responseObject is nil ...");
            if (failure) {
                failure([NSError unknowError]);
            }
            return;
        }
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (!dic) {
            if (failure) {
                failure([NSError unknowError]);
            }
            return;
        }
        
        if (success) {
            success(dic);
        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure([NSError networkError]);
        }
    }];

}
















@end
