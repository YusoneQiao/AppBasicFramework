//
//  NSError+UserError.h
//  DAV
//
//  Created by Davis.Qiao on 16/4/7.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#import <Foundation/Foundation.h>



/**
 *  错误类型
 */
typedef enum {
    ErrorTypeNetworkError               = 404,
    ErrorTypeFailedConfigReopenError    = 405,
    ErrorTypeUnknowError                = 500,
    
    ErrorTypeVerifyFailed               = 110101,
    ErrorTypeAlreadyRegistered          = 110001,
    ErrorTypeErrorUsernameOrPassword    = 100001,
    ErrorTypeErrorUsernameNotExist      = 100002,
    ErrorTypeErrorHavenotRegistered     = 110002,
    ErrorTypeErrorZoneErr               = 40000,
    ErrorTypeErrorVersionErr            = 40001,
    ErrorTypeErrorParametersInvalid     = 40011,
    
    ErrorTypeErrorEventsCycleTime      = 100400,
    ErrorTypeErrorAcitvityAbnormal     = 100401,
    ErrorTypeErrorActivityOutdated     = 100402,
    ErrorTypeErrorActivityMustBeCar    = 100403,
    ErrorTypeErrorGroupMembersOnly     = 100404,
    ErrorTypeErrorGroupAuthority       = 100405,
    ErrorTypeErrorOperatorNotLeader    = 100406,
    ErrorTypeErrorActivityIdNotAllow   = 100407,
    ErrorTypeErrorActivityTypeNotAllow = 100408,
    ErrorTypeErrorActivityRangeNotAllow= 100409,
    ErrorTypeErrorActivityIfNotCar     = 100410,
    ErrorTypeErrorActivityHasApply     = 100411,
    ErrorTypeErrorActivityHasCancel    = 100412,
    ErrorTypeErrorActivityNoCarNo      = 100413,
    ErrorTypeErrorActivityDelete       = 100414,
    ErrorTypeErrorActivityNoIMage      = 100415,
    ErrorTypeErrorActivityTimeError    = 100416,
    ErrorTypeErrorActivityPersonsLimitError    = 100417,
    ErrorTypeErrorActivityPersonMoreError      = 100418,
} ErrorType;




@interface NSError (UserError)

+ (NSError *)networkError;

+ (NSError *)failedConfigReopenError;

+ (NSError *)unknowError;



@end
