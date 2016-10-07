//
//  UILabel+SizeToFitTitleLength.h
//  DAV
//
//  Created by Davis.Qiao on 16/5/5.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (SizeToFitTitleLength)
- (CGSize) sizeToFitTitleLengthWithTitle:(NSString*) txt Font:(UIFont*) font;
@end
