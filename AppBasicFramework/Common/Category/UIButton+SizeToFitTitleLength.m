//
//  UIButton+SizeToFitTitleLength.m
//  DAV
//
//  Created by Davis.Qiao on 16/5/4.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#import "UIButton+SizeToFitTitleLength.h"

@implementation UIButton (SizeToFitTitleLength)


- (CGSize) sizeToFitTitleLengthWithTitle:(NSString*) txt Font:(UIFont*) font{
    CGSize _size;
    NSDictionary *attribute = @{NSFontAttributeName: font};
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    _size = [txt boundingRectWithSize:CGSizeZero options: options attributes:attribute context:nil].size;
    return _size;
}




@end
