//
//  DAVProductModel.h
//  DAV
//
//  Created by Davis.Qiao on 16/4/20.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAVProductModel : NSObject

#pragma mark - 进行中
@property (nonatomic,strong) UIImage *iconImage;        //头像图片
@property (nonatomic,strong) NSString *iconImageUrlStr; //头像图片url
@property (nonatomic,strong) NSString *titleStr;        //商品标题
@property (nonatomic,strong) NSString *timeStr;         //时间
@property (nonatomic,strong) NSString *countdownTimeStr;//倒计时剩余时间
@property (nonatomic,assign) NSInteger totalNumber;     //总可参与次数
@property (nonatomic,assign) NSInteger leftNumber;      //剩余可参与次数

@property (nonatomic,assign) NSInteger issueNumber;      //期号



#pragma mark - 已揭晓
@property (nonatomic,strong) NSString *winnerNickname;    //中奖者昵称
@property (nonatomic,assign) NSInteger joinTimes;         //中奖者参与次数
@property (nonatomic,assign) NSInteger lucklyNumber;      //幸运号码


- (instancetype)initWithDictionary:(NSDictionary *)dic;


+(DAVProductModel *)productModelWithIconImage:(UIImage *)iconImage iconImageUrlStr:(NSString *)iconImageUrlStr titleStr:(NSString *)titleStr timeStr:(NSString *)timeStr countdownTimeStr:(NSString *)countdownTimeStr totalNumber:(NSInteger )totalNumber leftNumber:(NSInteger )leftNumber issueNumber:(NSInteger )issueNumber winnerNickname:(NSString *)winnerNickname joinTimes:(NSInteger )joinTimes lucklyNumber:(NSInteger)lucklyNumber;

@end
