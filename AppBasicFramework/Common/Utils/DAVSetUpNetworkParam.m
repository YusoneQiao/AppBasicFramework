//
//  DAVSetUpNetworkParam.m
//  DAV
//
//  Created by Davis.Qiao on 16/5/13.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#import "DAVSetUpNetworkParam.h"
#import "DAVMD5.h"
#import "UUIDDAV.h"

@implementation DAVSetUpNetworkParam

+ (NSDictionary *)setUpParamDic:(NSDictionary *)dict{

    NSDictionary *mustParam = [self getMustDictParam];
    
    NSMutableDictionary *dictParam = [[NSMutableDictionary alloc]initWithDictionary:dict];
    [dictParam addEntriesFromDictionary:mustParam];
    
    NSArray *keysArray = [dictParam allKeys];
    //排序
    NSArray *sortedKeysArray = [keysArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    NSString *signValueStr = @"";
    NSString * tempStr = @"";
    for (int i = 0; i<sortedKeysArray.count; i++) {
        NSString *valueStr = [dictParam objectForKey:sortedKeysArray[i]];
        tempStr = [sortedKeysArray[i] stringByAppendingString:[NSString stringWithFormat:@"=%@",valueStr]];
        signValueStr =[signValueStr stringByAppendingString:tempStr];
    }
    signValueStr = [signValueStr stringByAppendingString:DAV_KEY_KEY];
    
    //MD5加密
    signValueStr  = [DAVMD5 md5:signValueStr];
    
    [dictParam setObject:signValueStr forKey:@"sign"];
    
    return dictParam;
}


+(NSDictionary *)getMustDictParam{

    NSString *app_Version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *uuidStr = [UUIDDAV getUUID];
    
    NSDictionary *mustParam = @{@"app":DAV_KEY_APP,@"channel":DAV_KEY_CHANNEL,@"version":app_Version,@"os":DAV_KEY_OS,@"zgid":uuidStr};
    return mustParam;
}



+ (NSString *)setUpParamStr:(NSString *)tempStr{
    
    tempStr = [DAV_TEST_URL_STR stringByAppendingString:tempStr];
    
    return tempStr;
}

@end
