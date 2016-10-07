//
//  DAVConfig.h
//  AppBasicFramework
//
//  Created by Davis.Qiao on 16/10/7.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#ifndef DAVConfig_h
#define DAVConfig_h
//配置字体

#define MicroSoftYaHei @"Microsoft YaHei"

#define FontWithMicrosoft(fontSize)  ([UIFont fontWithName:MicroSoftYaHei size:fontSize])
#define Font(x)      ([UIFont systemFontOfSize:x])


#define Corner_Value 5

//配置颜色
#define DAV_COLOR(R, G, B, A) ([UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A])

#define ColorFromString(color) ([UIColor colorWithHexString:color])

#define Nav_RightBlueTextColor  ([UIColor colorWithHexString:@"0042FF"])


#define DAV_COLOR_16(AABBCC)   ([UIColor colorWithHexString:@"#"#AABBCC""])
#define DAV_THEMER_COLOR       ([UIColor colorWithHexString:@"FF4800"])
#define DAV_RED_CUSTOMER_COLOR       ([UIColor colorWithHexString:@"FF3939"])

#define DAV_Orange_CUSTOMER_COLOR       ([UIColor colorWithHexString:@"FF5400"])


#define Main_LabelBlack_COLOR        ([UIColor colorWithHexString:@"323232"])



#define DAV_BACKGROUND_COLOR   [UIColor colorWithHexString:@"#FAFAFA"]

#define kLineView_Color        [UIColor colorWithHexString:@"#C7C7C7"]

#define Gray_SubTitle_COLOR     [UIColor colorWithHexString:@"#909090"]

#define kEnterButtonColor DAV_COLOR(230, 90, 30, 1.0)



//屏幕尺寸
#define DAV_SCREEN_BOUNDS_RECT                 ([[UIApplication sharedApplication].keyWindow bounds])
#define DAV_SCREEN_WIDTH                       ([[UIApplication sharedApplication].keyWindow bounds].size.width)
#define DAV_SCREEN_HEIGHT                      ([[UIApplication sharedApplication].keyWindow bounds].size.height)

#define NAV_BAR_HEIGHT 64

#define Tab_BAR_HEIGHT 49

//字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))

//数组是否为空
#define IsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))


#define Rect(x, y, w, h)                    CGRectMake(x, y, w, h)
#define Size(w, h)                          CGSizeMake(w, h)

#define iOS7_OR_LATER                               (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)?YES:NO)

#define iPhone_5                               ((DAV_SCREEN_WIDTH < 350)?YES:NO)
#define iPhone_6                               ((DAV_SCREEN_WIDTH > 350 && DAV_SCREEN_WIDTH < 400)?YES:NO)
#define iPhone_6P                              ((DAV_SCREEN_WIDTH > 400)?YES:NO)


#define kSelfViewFrameWidth                     (self.view.bounds.size.width)
#define kSelfViewFrameHeight                    (self.view.bounds.size.height)
#define kSelfViewFrame                          (self.view.frame)
#define kSelfViewBounds                         (self.view.bounds)

#define kCellWidth                              (self.contentView.bounds.size.width)
#define kCellHEIGHT                             (self.contentView.bounds.size.height)


#define weak_Self(weakSelf)                               __weak typeof(self) weakSelf = self;


//调试输出
/******* GO DEBUG LOG ********/
#if DEBUG
#define DAVDebugLog(frmt, ...)   {NSLog((frmt), ##__VA_ARGS__);}
#else
#define DAVDebugLog(frmt, ...)
#endif
/******* GO DEBUG LOG ********/


//通知

//DAV_BASE_URL_STR是错误的，暂定，以后要改
#define DAV_BASE_URL_STR       @"http://116.6.96.154:8888"



#define DAV_FRAME_AADTOCART       CGRectMake(DAV_SCREEN_WIDTH - 54, DAV_SCREEN_HEIGHT -84, 34, 34)
#define DAV_POINT_AADTOCART       CGPointMake(DAV_SCREEN_WIDTH - 54 + 17, DAV_SCREEN_HEIGHT -84 +17)


//存储UUID
#define  KEY_USERNAME_PASSWORD_DAV @"com.company.app.usernamepassword"




//商品状态类型
typedef enum {
    ENUM_Products_Status_Ongoing = 0,//商品进行中
    ENUM_Products_Status_Announcing,//商品揭晓中
    ENUM_Products_Status_Announced,//商品已揭晓
} ENUM_Products_Status_ActionType;





#endif /* DAVConfig_h */
