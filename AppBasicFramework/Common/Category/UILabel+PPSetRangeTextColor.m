//
//  UILabel+PPSetRangeTextColor.m
//  DAV
//
//  Created by Davis.Qiao on 16/4/28.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#import "UILabel+PPSetRangeTextColor.h"

@implementation UILabel (PPSetRangeTextColor)

-(BOOL)isInt:(NSString *)str
{
    NSScanner *scanner = [NSScanner scannerWithString:str];
    [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
    int number=1000;   //这里初始化1000，是为了避免数字 0 出现无法识别
    [scanner scanInt:&number];
//    NSLog(@"number : %d", number);
//    
//    
//    NSLog(@"======%@",str);
//    if ([str isEqualToString:@"0"]) {
//        
//        return YES;
//        
//    }else
//    {
        return  number==1000?NO:YES;
//
//    }
    
}

-(void)pp_setRichNumberWithLabelColor:(UIColor *)color
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self.text];
    NSString *temp = nil;
    for(int i =0; i < [attributedString length]; i++)
    {
        temp = [self.text substringWithRange:NSMakeRange(i, 1)];
        if( [self isInt:temp]  ){
            [attributedString setAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                             color, NSForegroundColorAttributeName,
                                             [UIFont systemFontOfSize:self.font.pointSize],NSFontAttributeName, nil]
                                      range:NSMakeRange(i, 1)];
        }
    }
    
    self.attributedText = attributedString;
}


-(void)PP_setAttributeLabelWithtextColorFromIndex:(NSInteger )index length:(NSInteger)textLength Color:(UIColor *)color;
{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.text];
    
    if (index>self.text.length) return;
    
    if (index+textLength>self.text.length) textLength=self.text.length-index;
    
    NSRange range=NSMakeRange(index, textLength);
    
    [str addAttribute:NSForegroundColorAttributeName
                value:color
                range:range];
    self.attributedText=str;
    //
    
}
@end
