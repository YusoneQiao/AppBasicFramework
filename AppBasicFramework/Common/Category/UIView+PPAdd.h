//
//  UIView+PPAdd.h
//  YYKitDemo
//
//  Created by Davis.Qiao on 16/4/5.
//  Copyright © 2016年 ibireme. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (PPAdd)

@property (readonly) UIViewController *viewController;


- (void)removeAllSubviews;


-(CGRect)visibleBoundsShowNav:(BOOL)hasNav showTabBar:(BOOL)hasTabBar;

/**
 *  @brief  view截图
 *
 *  @return 截图
 */
- (UIImage *)PP_screenshot;

/**
 *  @brief  找到当前view所在的viewcontroler
 */



-(void)PP_setCornerRadiusWithFloat:(CGFloat)Radius colorWith:(UIColor *)color;

-(void)PP_setCornerRadiusWithFloat:(CGFloat)Radius borderWidth:(CGFloat)width;


-(void)PP_setCornerRadiusWithFloat:(CGFloat)Radius colorWith:(UIColor *)color borderWidth:(CGFloat)width;



@property (nonatomic) CGFloat PP_left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat PP_top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat PP_right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat PP_bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat PP_width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat PP_height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat PP_centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat PP_centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint PP_origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  PP_size;        ///< Shortcut for frame.size.

@end
