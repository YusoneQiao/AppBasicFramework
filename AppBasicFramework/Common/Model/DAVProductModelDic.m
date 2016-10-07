//
//  DAVProductModelDic.m
//  DAV
//
//  Created by Davis.Qiao on 16/4/20.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#import "DAVProductModelDic.h"
#import "DAVProductModel.h"


@interface DAVProductModelDic()
//@property (nonatomic,strong) NSArray *titleLabelArray;
//@property (nonatomic,strong) NSArray *iconImageArray;
//@property (nonatomic, strong) NSArray *citites;


@end

@implementation DAVProductModelDic
{
    NSArray *iconImageArray;
    NSArray *titleLabelArray;
}

+(NSMutableArray *)getProductModelDicWithTimes:(NSInteger )times{
    NSMutableArray *productModelArray = [[NSMutableArray alloc]init];
    NSArray *titleLabelArray = @[@"SONY 镜头数码相机SONY 镜头数码相机SONY 镜头数码相机",@"Gents 男士石英表Gents 男士石英表Gents 男士石英表",@"博冠 双筒望远镜博冠 双筒望远镜博冠 双筒望远镜",@"宝马 儿童脚踏三轮车宝马 儿童脚踏三轮车宝马 儿童脚踏三轮车",@"水滴风暴 天气预报瓶子",@"飞利浦 充电式牙刷飞利浦 充电式牙刷飞利浦 充电式牙刷",@"九阳 营养专业榨汁机九阳 营养专业榨汁机九阳 营养专业榨汁机",@"ZIPPO火机 爱神之翼"];
    NSArray *iconImageArray =@[@"product_001",@"product_002",@"product_003",@"product_004",@"product_005",@"product_006",@"product_007",@"product_008"];
    NSArray *winnerNicknameArray =@[@"张三 ",@"李四",@"王五",@"赵六",@"田七",@"周八",@"习大大",@"李博士"];
    
    
    
    for (int i = 0; i<times; i++) {
       
        UIImage *image = [UIImage imageNamed:iconImageArray[i%8]];
        NSString *title = titleLabelArray[i%8];
        NSInteger totalNumber = arc4random_uniform(9999);
        NSInteger leftNumber = arc4random_uniform((float)totalNumber);
        NSInteger issueNumber = arc4random_uniform(999) + 100000000;
        
        NSString *winnerNickname = winnerNicknameArray[i%8];
        NSInteger joinTimes = arc4random_uniform(99);
        NSInteger lucklyNumber = arc4random_uniform(9999) + 1000000;
        
        
        //倒计时
        NSString *countdownTimeStr = [NSString stringWithFormat:@"%d",arc4random_uniform(60*60)];//时间只精确到秒
        
       DAVProductModel *productModel = [DAVProductModel productModelWithIconImage:image iconImageUrlStr:nil titleStr:title timeStr:nil countdownTimeStr:countdownTimeStr totalNumber:totalNumber leftNumber:leftNumber issueNumber:issueNumber winnerNickname:winnerNickname joinTimes:joinTimes lucklyNumber:lucklyNumber];
        [productModelArray addObject:productModel];
    }
    return productModelArray;
}




@end
