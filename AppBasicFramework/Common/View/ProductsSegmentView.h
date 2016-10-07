//
//  ProductsSegmentView.h
//  DAV
//
//  Created by Davis.Qiao on 16/4/22.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^productsSegmentalTapBlock)(NSInteger selectIndex);

@interface ProductsSegmentView : UIView
- (instancetype)initWithFrame:(CGRect)frame clickIndex:(productsSegmentalTapBlock)block;
@end
