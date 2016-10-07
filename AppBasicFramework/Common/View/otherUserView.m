
//
//  otherUserView.m
//  DAV
//
//  Created by Davis.Qiao on 16/4/26.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#import "otherUserView.h"

@interface otherUserView ()

@property(nonatomic,strong)UIImageView *headUserImageV;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *idLabel;

@end

@implementation otherUserView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        [self addSubview:self.headUserImageV];
        [self addSubview:self.nameLabel];
        [self addSubview:self.idLabel];
        
    }
    return self;
}

-(void)loadDataDic:(NSDictionary *)dic
{
    _headUserImageV.image=[UIImage imageNamed:@"1"];
    _nameLabel.text=@"测试用户";
    _idLabel.text=@"100082";
}
-(UIImageView *)headUserImageV
{
    if (!_headUserImageV) {
        
        _headUserImageV=[[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 45, 45)];

        _headUserImageV.PP_centerY=self.PP_centerY;
        _headUserImageV.layer.cornerRadius=CGRectGetWidth(_headUserImageV.frame)/2;
        _headUserImageV.layer.masksToBounds=YES;

        
    }
    return _headUserImageV;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        
        _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(_headUserImageV.PP_right+10, _headUserImageV.PP_top+5, 120,15)];
        [_nameLabel setFont:FontWithMicrosoft(12)];
        
    }
    return _nameLabel;
}

-(UILabel *)idLabel
{
    if (!_idLabel) {
        
        _idLabel=[[UILabel alloc]initWithFrame:CGRectMake(_headUserImageV.PP_right+10, _nameLabel.PP_bottom+5, 120, 15)];
        [_idLabel setFont:FontWithMicrosoft(12)];
        
    }
    return _idLabel;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
