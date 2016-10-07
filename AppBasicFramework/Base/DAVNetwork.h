//
//  DAVNetwork.h
//  DAV
//
//  Created by Davis.Qiao on 16/4/7.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//



/****************************************************************************************/
/*
 本类是基于AFNetworking网络操作的第三方库进行简单包装的网络请求操作。
 */
/****************************************************************************************/



#import <Foundation/Foundation.h>
#import "DAVUploadParam.h"

/**
 *  网络请求类型
 */
typedef NS_ENUM(NSUInteger,HttpRequestType) {
    /**
     *  get请求
     */
    HttpRequestTypeGet = 0,
    /**
     *  post请求
     */
    HttpRequestTypePost
};



@interface DAVNetwork : NSObject


/**
 *  HTTP的GET请求
 *
 *  @param path    请求的网址字符串
 *  @param paraDic 请求的参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)httpRequestGETWithPath:(NSString *)path
             parameters:(NSDictionary *)paraDic
                success:(void (^)(id responseObject))success
                failure:(void (^)(NSError *error ))failure;


/**
 *  HTTP的POST请求
 *
 *  @param path    请求的网址字符串
 *  @param paraDic 请求的参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)httpRequestPOSTWithPath:(NSString *)path
              parameters:(NSDictionary *)paraDic
                 success:(void (^)(id responseObject))success
                 failure:(void (^)(NSError *error ))failure;

/**
 *  发送网络请求POST/GET
 *
 *  @param URLString   请求的网址字符串
 *  @param parameters  请求的参数
 *  @param type        请求的类型
 *  @param resultBlock 请求的结果
 */
+ (void)httpRequestWithPath:(NSString *)path
                  parameters:(id)paraDic
                        type:(HttpRequestType)type
                     success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure;


/**
 *  上传图片
 *
 *  @param URLString   上传图片的网址字符串
 *  @param parameters  上传图片的参数
 *  @param uploadParam 上传图片的信息
 *  @param success     上传成功的回调
 *  @param failure     上传失败的回调
 */
+ (void)httpUploadWithPath:(NSString *)path
                 parameters:(id)paraDic
                uploadParam:(DAVUploadParam *)uploadParam
                    success:(void (^)())success
                    failure:(void (^)(NSError *error))failure;


@end
