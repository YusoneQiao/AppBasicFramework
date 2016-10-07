//
//  DAVRecordTableViewCell.h
//  DAV
//
//  Created by Davis.Qiao on 16/4/14.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DAVRecordTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *neckLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end
