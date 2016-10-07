//
//  DBHelperDAV.h
//  DAV
//
//  Created by Davis.Qiao on 16/5/10.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class shopModelDAV;

@interface DBHelperDAV : NSObject


+(BOOL)openDataBase;
+(void) closeDatabase;

+(void)insertShopModel:(shopModelDAV *)model;
+(NSArray *)selectAllhopModel;

@end
