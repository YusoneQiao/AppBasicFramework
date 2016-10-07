//
//  ConfigDAV.h
//  DAV
//
//  Created by Davis.Qiao on 16/5/10.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserDAV;
@class MBProgressHUD;
@interface ConfigDAV : NSObject

//保存登录用户记录
+ (void)saveOwnAccount:(NSString *)account andPassword:(NSString *)password;

//保存用户信息
+ (void)saveProfile:(UserDAV *)user;

//更新用户信息
+ (void)updateProfile:(UserDAV *)user;

//清除用户信息
+ (void)clearProfile;

//获取购物车商品数量
+(NSInteger )getProductNum;


//更新购物车商品数量
+(void)upDateProductNum:(NSInteger )proNum;

//获取用户信息
+ (UserDAV *)myProfile;

//清除缓存
+ (void)clearCookie;

//保存缓存
+ (void)saveCookies;

//获取用户账户密码
+ (NSArray *)getOwnAccountAndPassword;

//获取用户ID
+ (int64_t)getOwnID;

+ (MBProgressHUD *)createHUD;


@end
