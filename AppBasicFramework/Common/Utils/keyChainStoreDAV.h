//
//  keyChainStoreDAV.h
//  DAV
//
//  Created by Davis.Qiao on 16/5/13.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface keyChainStoreDAV : NSObject

+ (void)save:(NSString *)service data:(id)data;

+ (id)load:(NSString *)service;

+ (void)deleteKeyData:(NSString *)service;

@end
