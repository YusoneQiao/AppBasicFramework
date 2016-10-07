//
//  ConfigDAV.m
//  DAV
//
//  Created by Davis.Qiao on 16/5/10.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#import "ConfigDAV.h"
#import "SSKeychain.h"
#import "UserDAV.h"
#import "MBProgressHUD.h"

NSString * const kService = @"DAVService";
NSString * const kAccount = @"account";
NSString * const kUserID = @"userID";

NSString * const kUserName = @"name";
NSString * const kLocation = @"location";
NSString * const kPhoneNumber = @"phoneNumber";

NSString *const kProDuctNum=@"productNum";


@implementation ConfigDAV

+ (void)saveOwnAccount:(NSString *)account andPassword:(NSString *)password
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:account?:@"" forKey:kAccount];
    [userDefaults synchronize];
    
    [SSKeychain setPassword:password ?: @"" forService:kService account:account];
}

+ (MBProgressHUD *)createHUD
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithWindow:window];
    HUD.detailsLabelFont = [UIFont boldSystemFontOfSize:16];
    [window addSubview:HUD];
    [HUD show:YES];
    HUD.removeFromSuperViewOnHide = YES;
    //[HUD addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:HUD action:@selector(hide:)]];
    
    return HUD;
}

+(NSInteger)getProductNum
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    NSString *proNum=[userDefaults objectForKey:kProDuctNum];
    
    NSLog(@"%@",proNum);
    
    return [proNum integerValue];
}

+(void)upDateProductNum:(NSInteger )proNum
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:[NSString  stringWithFormat:@"%ld",proNum] forKey:kProDuctNum];
    
    [userDefaults synchronize];
}
#pragma mark - user profile

+(void)saveProfile:(UserDAV *)user
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
      [userDefaults synchronize];
}

+ (void)updateProfile:(UserDAV *)user
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    

    [userDefaults synchronize];
}


+ (void)clearProfile
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults synchronize];
}


+ (UserDAV *)myProfile
{
    UserDAV *user = [UserDAV new];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults synchronize];
    return user;
}

+ (void)clearCookie
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"sessionCookies"];
}

- (void)saveCookies
{
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: cookiesData forKey: @"sessionCookies"];
    [defaults synchronize];
    
}
+ (NSArray *)getOwnAccountAndPassword
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *account = [userDefaults objectForKey:kAccount];
    NSString *password = [SSKeychain passwordForService:kService account:account] ?: @"";
    if (account) {return @[account, password];}
    return nil;
}

+ (int64_t)getOwnID
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults integerForKey:kUserID];
}
@end
