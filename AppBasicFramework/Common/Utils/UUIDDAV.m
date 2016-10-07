//
//  UUIDDAV.m
//  DAV
//
//  Created by Davis.Qiao on 16/5/13.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#import "UUIDDAV.h"

#import "keyChainStoreDAV.h"

@implementation UUIDDAV

+(NSString *)getUUID
{
    NSString * strUUID = (NSString *)[keyChainStoreDAV load:KEY_USERNAME_PASSWORD_DAV];
    
    //首次执行该方法时，uuid为空
    if ([strUUID isEqualToString:@""] || !strUUID)
    {
        //生成一个uuid的方法
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        
        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        
        //将该uuid保存到keychain
        [keyChainStoreDAV save:KEY_USERNAME_PASSWORD_DAV data:strUUID];
        
    }
    return strUUID;
}

@end
