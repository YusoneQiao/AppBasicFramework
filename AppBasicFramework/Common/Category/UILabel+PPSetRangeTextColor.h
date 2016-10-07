//
//  UILabel+PPSetRangeTextColor.h
//  DAV
//
//  Created by Davis.Qiao on 16/4/28.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (PPSetRangeTextColor)

//设置所有数字变色
-(void)pp_setRichNumberWithLabelColor:(UIColor *)color;


//设置同一label的不同颜色text
-(void)PP_setAttributeLabelWithtextColorFromIndex:(NSInteger )index length:(NSInteger)textLength Color:(UIColor *)color;

@end
