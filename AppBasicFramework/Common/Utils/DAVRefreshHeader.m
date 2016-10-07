//
//  DAVRefreshHeader.m
//  DAV
//
//  Created by Davis.Qiao on 16/5/10.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#import "DAVRefreshHeader.h"



@interface DAVRefreshHeader()
@property (nonatomic,strong) NSArray *willRefreshImages;//松手就刷新
@property (nonatomic,strong) NSArray *onRefreshImages;//正在刷新
@property (nonatomic,strong) NSMutableArray *normalImages;//普通状态下的图片数组

@property (nonatomic,strong) NSTimer *timer;//模拟数据刷新需要的时间控制器
@property (nonatomic,assign) int time;
@end



@implementation DAVRefreshHeader

+ (DAVRefreshHeader *)sharedManager
{
    static DAVRefreshHeader *sharedManager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}


//头视图
- (MJRefreshGifHeader *)getTableViewRefreshHeaderWithBlock:(refreshHeaderBlock)refreshHeaderBlock{
    
    MJRefreshGifHeader *header =[MJRefreshGifHeader headerWithRefreshingBlock:^{
        refreshHeaderBlock();
    }];
    [header setImages:self.willRefreshImages duration:0.7 forState:MJRefreshStatePulling];// 松开就可以进行刷新的状态
    [header setImages:self.onRefreshImages duration:0.7 forState:MJRefreshStateRefreshing];//正在刷新中的状态
    [header setImages:self.normalImages duration:0.7 forState:MJRefreshStateIdle];

    header.lastUpdatedTimeLabel.hidden= YES;//如果不隐藏这个会默认 图片在最左边不是在中间
    header.stateLabel.hidden = YES;
    return header;
}





- (NSMutableArray *)normalImages
{
    if (_normalImages == nil) {
        _normalImages = [[NSMutableArray alloc] init];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_down_will_1.png"]];
        [self.normalImages addObject:image];
    }
    return _normalImages;
}

//松手就刷新
- (NSArray *)willRefreshImages
{
    if (_willRefreshImages == nil) {

        _willRefreshImages = [[NSArray alloc] init];
        NSMutableArray *mutabeArray = [[NSMutableArray alloc]init];
        //				循环添加图片
        for (int i = 1; i<=4; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_down_will_%d.png", i]];
            [mutabeArray addObject:image];
        }
        _willRefreshImages = mutabeArray;
    }
    return _willRefreshImages;
}

//正在刷新
- (NSArray *)onRefreshImages
{
    if (_onRefreshImages == nil) {
        
        _onRefreshImages = [[NSArray alloc] init];
        NSMutableArray *mutabeArray = [[NSMutableArray alloc]init];
        //				循环添加图片
        for (int i = 1; i<=4; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_down_on_%d.png", i]];
            [mutabeArray addObject:image];
        }
        _onRefreshImages = mutabeArray;
    }
    return _onRefreshImages;
}

@end
