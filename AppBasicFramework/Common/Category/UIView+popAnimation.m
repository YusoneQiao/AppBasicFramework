//
//  UIView+popAnimation.m
//  bounceAnimation
//
//  Created by Davis.Qiao on 15/12/22.
//  Copyright © 2015年 JianYe. All rights reserved.
//

#import "UIView+popAnimation.h"

@implementation UIView (popAnimation)

-(void)PP_ShowPopAnimation
{
    
    [UIView animateWithDuration:0.2 animations:
     ^(void){
         self.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.1f, 1.1f);
         self.alpha = 0.5;
     }
                     completion:^(BOOL finished){
                         [self bounceOutAnimationStoped];
                     }];
}
- (void)bounceOutAnimationStoped
{
    [UIView animateWithDuration:0.1 animations:
     ^(void){
         self.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0, 1.0);
         self.alpha = 1.0;
     }
                     completion:^(BOOL finished){
//                         [self bounceInAnimationStoped];
                     }];
}
//- (void)bounceInAnimationStoped
//{
//    [UIView animateWithDuration:0.1 animations:
//     ^(void){
//         self.transform = CGAffineTransformScale(CGAffineTransformIdentity,1, 1);
//         self.alpha = 1.0;
//     }
//                     completion:^(BOOL finished){
//                         [self animationStoped];
//                     }];
//}
- (void)animationStoped
{
    
}

-(void)PP_hidePopAnimation
{
  
    [UIView animateWithDuration:0.1 animations:
     ^(void){
        self.alpha = 0;
        self.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.6, 0.6);
     }
                     completion:^(BOOL finished){
                         [self animationStoped];
                     }];

 }

@end
