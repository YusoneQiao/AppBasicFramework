//
//  CountdownNumber.m
//  DAV
//
//  Created by Davis.Qiao on 16/5/3.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#import "CountdownNumber.h"

@implementation CountdownNumber


/**
 *  创建一个带有倒计时的button
 *
 *  @param timeLeft 倒计时剩余时间
 *
 *  @return 带有倒计时的button
 */
+(void)getCountdownButtonWithTimeNumber:(NSInteger)timeLeft titleFont:(UIFont *)font WithLabel:(UILabel *)tempLabel{
    UIFont *titleFont;
    if (font) {
        titleFont = font;
    }else{
        titleFont = Font(18.0);
    }
    [tempLabel removeAllSubviews];
    
    [tempLabel setBackgroundColor:[UIColor clearColor]];
    [tempLabel setTextColor:DAV_COLOR_16(FF1313)];
    [tempLabel setFont:font];
    tempLabel.textAlignment = NSTextAlignmentLeft;
    
    [tempLabel removeAllSubviews];
    
    [self startWithTimeNumber:timeLeft titleColor:DAV_COLOR_16(FF1313) titleFont:titleFont timeOutTitle:nil timeOutTitleColor:[UIColor blackColor] frame:tempLabel.frame withLabel:tempLabel];
}




/**
 *  商品抢购倒计时
 *
 *  @param timeLeft     倒计时剩余时间,s
 *  @param color        倒计时颜色
 *  @param titleFont    倒计时font
 *  @param title        倒计时结束显示字
 *  @param timeOutColor 倒计时结束显示颜色
 */

+ (void) startWithTimeNumber:(NSInteger)timeLeft titleColor:(UIColor *)color titleFont:(UIFont *)titleFont timeOutTitle:(NSString *)title timeOutTitleColor:(UIColor *)timeOutColor frame:(CGRect)tempFrame withLabel:(UILabel *)tempLabel {
    timeLeft *=100;
    
//    __weak typeof(self) weakSelf = self;
    
    
    
    //设置label，分开显示倒计时数字
    //    UILabel *label0 = [[UILabel alloc]init];
    //    UILabel *label1 = [[UILabel alloc]init];
    //    UILabel *label2 = [[UILabel alloc]init];
    //    UILabel *label3 = [[UILabel alloc]init];
    //    UILabel *label4 = [[UILabel alloc]init];
    //
    //    float width = tempFrame.size.width / 11;
    //    int j = 0;
    //    int q = 0;
    //
    //    for (int i = 0; i<5; i++) {
    //
    //        UILabel *label = [[UILabel alloc]init];
    //        label.font = titleFont;
    //        label.textColor = color;
    //        label.backgroundColor = [UIColor redColor];
    //        switch (i) {
    //            case 0:
    //                j = 0;
    //                q = 3;
    //                label0 = label;
    //                break;
    //            case 1:
    //                j = 3;
    //                 q = 1;
    //                label1 = label;
    //                break;
    //            case 2:
    //                j = 4;
    //                 q = 3;
    //                label2 = label;
    //                break;
    //            case 3:
    //                j = 7;
    //                 q = 1;
    //                label3 = label;
    //                break;
    //            case 4:
    //                j = 8;
    //                 q = 3;
    //                label4 = label;
    //                break;
    //
    //            default:
    //                break;
    //        }
    //        label.frame = Rect(width *j,0, width *q, self.PP_height);
    //        [button addSubview:label];
    //    }
    
    //    NSArray *array = self.subviews;
    
    //倒计时时间
    __block NSInteger timeOut = timeLeft;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 0.01 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        //倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (title) {
                    [tempLabel setText:title];
                }else{
                    [tempLabel setText:[NSString stringWithFormat:@"00:00:00"]];
                }
            });
            
        } else {
            int allTime = (int)timeLeft + 1;
            int mSeconds = timeOut % allTime;
            
            NSString *timeStr = [NSString stringWithFormat:@"%.2d:%.2d:%.2d",mSeconds/(60*100),(mSeconds % (60*100))/100,((mSeconds % (60*100))%100)];
            dispatch_async(dispatch_get_main_queue(), ^{
                [tempLabel setText:[NSString stringWithFormat:@"%@",timeStr]];
            });
            timeOut--;
        }
        
    });
    
    //    dispatch_source_set_cancel_handler(_timer, ^{
    //        NSLog(@"cancel");
    //        dispatch_release(_timer);
    //    });
    
    dispatch_resume(_timer);
}









@end
