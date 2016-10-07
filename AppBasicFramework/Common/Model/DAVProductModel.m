//
//  DAVProductModel.m
//  DAV
//
//  Created by Davis.Qiao on 16/4/20.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#import "DAVProductModel.h"

@implementation DAVProductModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        _iconImage          = dic[@"iconImage"];
        _iconImageUrlStr    = dic[@"iconImageUrlStr"];
        _titleStr           = dic[@"titleStr"];
        _timeStr            = dic[@"timeStr"];
        _countdownTimeStr   = dic[@"countdownTimeStr"];
        _totalNumber        = [dic[@"totalNumber"] intValue];
        _leftNumber         = [dic[@"leftNumber"] intValue];
        _issueNumber        = [dic[@"issueNumber"] intValue];
    }
    return self;
}


+(DAVProductModel *)productModelWithIconImage:(UIImage *)iconImage iconImageUrlStr:(NSString *)iconImageUrlStr titleStr:(NSString *)titleStr timeStr:(NSString *)timeStr countdownTimeStr:(NSString *)countdownTimeStr totalNumber:(NSInteger )totalNumber leftNumber:(NSInteger )leftNumber issueNumber:(NSInteger )issueNumber winnerNickname:(NSString *)winnerNickname joinTimes:(NSInteger)joinTimes lucklyNumber:(NSInteger)lucklyNumber{

    DAVProductModel *productModel = [[DAVProductModel alloc]init];
    productModel.iconImage = iconImage;
    productModel.iconImageUrlStr = iconImageUrlStr;
    productModel.titleStr = titleStr;
    productModel.timeStr = timeStr;
    productModel.countdownTimeStr = countdownTimeStr;
    productModel.totalNumber = totalNumber;
    productModel.leftNumber = leftNumber;
    productModel.issueNumber = issueNumber;
    productModel.winnerNickname = winnerNickname;
    productModel.joinTimes = joinTimes;
    productModel.lucklyNumber = lucklyNumber;
    
    return productModel;
}

@end
