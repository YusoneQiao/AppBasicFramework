//
//  AppDelegate.m
//  AppBasicFramework
//
//  Created by Davis.Qiao on 16/10/7.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#import "AppDelegate.h"
#import "DAVTabBarViewController.h"

#import <IQKeyboardManager.h>

//#import "UIImageView+WebCache.h"
//#import "UMSocialWechatHandler.h"
//#import "UMSocialSinaSSOHandler.h"
//#import "UMSocialQQHandler.h"

#import "UUIDDAV.h"

//#import "FWPayManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //获取deviceid  测试用
    Class cls = NSClassFromString(@"UMANUtil");
    SEL deviceIDSelector = @selector(openUDIDString);
    NSString *deviceID = nil;
    
    NSLog(@"uuid---%@",[UUIDDAV getUUID]);
    
    
    if(cls && [cls respondsToSelector:deviceIDSelector]){
        deviceID = [cls performSelector:deviceIDSelector];
    }
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:@{@"oid" : deviceID}
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    
    NSLog(@"%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    
    
    //友盟统计
    //    [MobClick setLogEnabled:YES];
    
//    [MobClick startWithAppkey:UMSocaial_APPKEY reportPolicy:BATCH channelId:nil];
    
    
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    DAVTabBarViewController *tabBarVC = [[DAVTabBarViewController alloc]init];
    _window.rootViewController = tabBarVC;
    [_window makeKeyAndVisible];
    
    
    //更改tabbar颜色为白色,不能放在上边，要不然不起作用
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DAV_SCREEN_WIDTH, 49)];
    backView.backgroundColor = [UIColor whiteColor];
    [tabBarVC.tabBar insertSubview:backView atIndex:0];
    tabBarVC.tabBar.opaque = YES;
    
    
    //智能键盘管理
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside=YES;
    //    [manager disableInViewControllerClass:[labelViewController class]];
    //    [manager disableInViewControllerClass:[DeteilViewController class]];
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
    
    
    
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:UMSocaial_APPKEY];
    
    //设置微信AppId、appSecret，分享url
//    [UMSocialWechatHandler setWXAppId:WX_APP_ID appSecret:WX_APP_SECRET url:@"http://www.umeng.com/social"];
    
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
//    [UMSocialQQHandler setQQWithAppId:QQ_APP_ID appKey:QQ_APP_Key url:@"http://www.umeng.com/social"];
    
    //打开新浪微博的SSO开关，第一个参数为新浪appkey,第二个参数为新浪secret，第三个参数是新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。
    //回调URL必须和后台保持一致，否则会报错redirect URL mismatch
//    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:Sina_APP_ID
//                                              secret:Sina_APP_Key
//                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    return YES;
}



-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    
    return YES;
}
//友盟需要的系统回调
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //    [[FWPayManager shareInstance] manageOpenUrl:url];
    //    BOOL result = [UMSocialSnsService handleOpenURL:url];
    //
    //    if (result == FALSE) {
    //        //调用其他SDK，例如支付宝SDK等
    //
    //    }
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    
    //    [[FWPayManager shareInstance] manageOpenUrl:url];
    return YES;
    
}

#pragma mark - 注意：收到内存警告时调用，
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 1. 停止所有下载
    [[SDWebImageManager sharedManager] cancelAll];
    
    // 2. 清除缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
