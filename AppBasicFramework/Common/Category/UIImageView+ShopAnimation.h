//
//  UIImageView+ShopAnimation.h
//  ShopDemo
//
//  Created by Davis.Qiao on 16/4/18.
//  Copyright © 2016年 wanglh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^shopAnimationFinishBlock)(void);

@interface UIImageView (ShopAnimation)

-(void)pp_moveToRect:(CGPoint)point  shopAnimationFinishHandle:(shopAnimationFinishBlock )handleBlock;



@end
