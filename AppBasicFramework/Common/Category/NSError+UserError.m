//
//  NSError+UserError.m
//  DAV
//
//  Created by Davis.Qiao on 16/4/7.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#import "NSError+UserError.h"

@implementation NSError (UserError)


+ (NSError *)networkError
{
    NSError *error = [NSError errorWithDomain:DAV_BASE_URL_STR
                                         code:ErrorTypeNetworkError
                                     userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"GOUC_NetworkErr", nil)}];
    return error;
}

+ (NSError *)failedConfigReopenError
{
    NSError *error = [NSError errorWithDomain:DAV_BASE_URL_STR
                                         code:ErrorTypeFailedConfigReopenError
                                     userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"GOUC_FialedConfigReopenApp", nil)}];
    return error;
}

+ (NSError *)unknowError
{
    NSError *error = [NSError errorWithDomain:DAV_BASE_URL_STR
                                         code:ErrorTypeUnknowError
                                     userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"GOUC_UnknowErr", nil)}];
    return error;
}

@end
