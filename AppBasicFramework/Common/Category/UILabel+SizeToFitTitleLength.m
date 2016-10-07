//
//  UILabel+SizeToFitTitleLength.m
//  DAV
//
//  Created by Davis.Qiao on 16/5/5.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#import "UILabel+SizeToFitTitleLength.h"

@implementation UILabel (SizeToFitTitleLength)

- (CGSize) sizeToFitTitleLengthWithTitle:(NSString*) txt Font:(UIFont*) font{
    CGSize _size;
    NSDictionary *attribute = @{NSFontAttributeName: font};
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    _size = [txt boundingRectWithSize:CGSizeZero options: options attributes:attribute context:nil].size;
    return _size;
}

@end
