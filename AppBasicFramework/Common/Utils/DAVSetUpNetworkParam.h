//
//  DAVSetUpNetworkParam.h
//  DAV
//
//  Created by Davis.Qiao on 16/5/13.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAVSetUpNetworkParam : NSObject

/**
 *  http请求参数字典封装
 *  @param dictParam http参数字典
 */
+ (NSDictionary *)setUpParamDic:(NSDictionary *)dictParam;

/**
 *  http请求参数url封装
 *  @param tempStr http参数url
 */
+ (NSString *)setUpParamStr:(NSString *)tempStr;
@end
