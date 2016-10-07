//
//  UIImageView+ShopAnimation.m
//  ShopDemo
//
//  Created by Davis.Qiao on 16/4/18.
//  Copyright © 2016年 wanglh. All rights reserved.
//

#import "UIImageView+ShopAnimation.h"

#define DAV_SCREEN_WIDTH                       ([[UIApplication sharedApplication].keyWindow bounds].size.width)
#define DAV_SCREEN_HEIGHT                      ([[UIApplication sharedApplication].keyWindow bounds].size.height)



static CALayer *layer=nil;
static shopAnimationFinishBlock tempBlock=nil;
@implementation UIImageView (ShopAnimation)

-(void)pp_moveToRect:(CGPoint)point shopAnimationFinishHandle:(shopAnimationFinishBlock)handleBlock
{
    if (handleBlock) {
        tempBlock=handleBlock;
    }
    CGRect rect=[self convertRect:self.layer.bounds toView:self.window];
//    CGRect rect= self.layer.bounds;
    
    CGPoint startPoint=CGPointMake(CGRectGetMidX(rect),CGRectGetMidY(rect));
    CGPoint endPoint=point;
    
    if (!layer) {
        layer=[CALayer layer];
        layer.contents=self.layer.contents;
        layer.contentsGravity = kCAGravityResizeAspectFill;
        layer.bounds = rect;
        [layer setCornerRadius:CGRectGetHeight([layer bounds]) / 2];
        layer.masksToBounds = YES;
        layer.position=CGPointMake(self.center.x, CGRectGetMidY(self.frame)+64);
        [self.window.layer addSublayer:layer];
        
        UIBezierPath *path=[UIBezierPath bezierPath];
        [path moveToPoint:startPoint];
        [path addQuadCurveToPoint:endPoint controlPoint:CGPointMake(DAV_SCREEN_WIDTH/2,rect.origin.y-80)];
        
        
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        animation.path = path.CGPath;
        animation.rotationMode = kCAAnimationRotateAuto;
        //    CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        //    expandAnimation.duration = 0.5f;
        //    expandAnimation.fromValue = [NSNumber numberWithFloat:1];
        //    expandAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        //    expandAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        
        CABasicAnimation *narrowAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        narrowAnimation.beginTime = 0;
        narrowAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
        narrowAnimation.duration = 1.0f;
        narrowAnimation.toValue = [NSNumber numberWithFloat:0.2f];
        
        narrowAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        
        CAAnimationGroup *groups = [CAAnimationGroup animation];
        groups.animations = @[animation,narrowAnimation];
        groups.duration = 1.0f;
        groups.removedOnCompletion=NO;
        groups.fillMode=kCAFillModeForwards;
        groups.delegate = self;
        [layer addAnimation:groups forKey:@"group"];
    }
    

    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (anim == [layer animationForKey:@"group"]) {
        [layer removeFromSuperlayer];
        
        layer=nil;
        
              
        
        if (flag) tempBlock();
      
    
    }
}



@end
