//
//  topSegmentView.h
//  DAV
//
//  Created by Davis.Qiao on 16/4/20.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^segmentalTapBlock)(NSInteger selectIndex);

@interface topSegmentView : UIView

-(id)initWithFrame:(CGRect)frame titleArrays:(NSArray *)titleArrs clickIndex:(segmentalTapBlock)block;

@end
