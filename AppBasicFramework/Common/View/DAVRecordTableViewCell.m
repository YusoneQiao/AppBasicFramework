//
//  DAVRecordTableViewCell.m
//  DAV
//
//  Created by Davis.Qiao on 16/4/14.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#import "DAVRecordTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation DAVRecordTableViewCell

- (void)awakeFromNib {
//    @property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
//    
//    @property (weak, nonatomic) IBOutlet UILabel *neckLabel;
//    @property (weak, nonatomic) IBOutlet UILabel *timeLabel;
    
    
    
    self.iconImageView.frame = CGRectMake(40, 10, 40, 40);
    self.iconImageView.aliCornerRadius = self.iconImageView.frame.size.width*0.5;
    
    
    self.neckLabel.frame = CGRectMake(90, 10, DAV_SCREEN_WIDTH - 100, 20);
    self.neckLabel.textColor = DAV_COLOR_16(909090);
    self.neckLabel.font = [UIFont systemFontOfSize:11.0];
    
    self.timeLabel.frame = CGRectMake(90, 30, DAV_SCREEN_WIDTH - 100, 20);
    self.timeLabel.textColor = DAV_COLOR_16(909090);
    self.timeLabel.font = [UIFont systemFontOfSize:11.0];
    

    self.lineView.backgroundColor = DAV_COLOR_16(909090);
    self.lineView.frame = CGRectMake(59.5, 0, 1, self.frame.size.height);
    
    self.clipsToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
