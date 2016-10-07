//
//  DAVRefreshHeader.h
//  DAV
//
//  Created by Davis.Qiao on 16/5/10.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^refreshHeaderBlock)();

@interface DAVRefreshHeader : NSObject


+ (DAVRefreshHeader *)sharedManager;

- (MJRefreshGifHeader *)getTableViewRefreshHeaderWithBlock:(refreshHeaderBlock)refreshHeaderBlock;
@end
