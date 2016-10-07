//
//  shopModelDAV.h
//  DAV
//
//  Created by Davis.Qiao on 16/5/10.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface shopModelDAV : NSObject

@property(nonatomic,assign)int proId; //商品ID;
@property(nonatomic,strong)NSString *proName; //商品名;
@property(nonatomic,strong)NSString *proPrice; //商品价格;


@end
