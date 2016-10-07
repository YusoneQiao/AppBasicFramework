//
//  UIView+PPAdd.m
//  YYKitDemo
//
//  Created by Davis.Qiao on 16/4/5.
//  Copyright © 2016年 ibireme. All rights reserved.
//

#import "UIView+PPAdd.h"

@implementation UIView (PPAdd)

- (void)removeAllSubviews {
    //[self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}



-(void)PP_setCornerRadiusWithFloat:(CGFloat)Radius borderWidth:(CGFloat)width
{
     width=width?:0;
//    切圆角
    self.layer.cornerRadius=Radius;
    self.layer.masksToBounds=YES;
    self.layer.borderColor=[UIColor colorWithHexString:@"FF4A00"].CGColor;
;
    self.layer.borderWidth=width;

}

-(void)PP_setCornerRadiusWithFloat:(CGFloat)Radius colorWith:(UIColor *)color
{
    //    切圆角
    self.layer.cornerRadius=Radius;
    self.layer.masksToBounds=YES;
    self.layer.borderWidth=0.5;
    self.layer.borderColor=color.CGColor;

}

-(void)PP_setCornerRadiusWithFloat:(CGFloat)Radius colorWith:(UIColor *)color borderWidth:(CGFloat)width
{
    color=color?:[UIColor colorWithHexString:@"FF4A00"];
    self.layer.cornerRadius=Radius;
    self.layer.masksToBounds=YES;
    self.layer.borderColor=color.CGColor;
    self.layer.borderWidth=width;

}


- (UIViewController *)viewController
{
    UIResponder *responder = self.nextResponder;
    do {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    } while (responder);
    return nil;
}

- (UIImage *)screenshot {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    if( [self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
    {
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    }
    else
    {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshot;
}

- (CGRect)visibleBoundsShowNav:(BOOL)hasNav showTabBar:(BOOL)hasTabBar
{

        CGRect frame = [[UIScreen mainScreen] bounds];
        frame.size.height -= 20;
        if (hasNav) {
            frame.size.height -= 44;
            frame.origin.y+=64;
        }
        if (hasTabBar) {
            frame.size.height -= 49;
        }
        return frame;
}

- (CGFloat)PP_left {
    return self.frame.origin.x;
}

-(void)setPP_left:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;

}


- (CGFloat)PP_top {
    return self.frame.origin.y;
}

- (void)setPP_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)PP_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setPP_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)PP_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setPP_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)PP_width {
    return self.frame.size.width;
}

- (void)setPP_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)PP_height {
    return self.frame.size.height;
}

- (void)setPP_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)PP_centerX {
    return self.center.x;
}

- (void)setPP_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)PP_centerY {
    return self.center.y;
}

- (void)setPP_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)PP_origin {
    return self.frame.origin;
}

- (void)setPP_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)PP_size {
    return self.frame.size;
}

- (void)setPP_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


@end
