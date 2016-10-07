//
//  PPCGProgressView.m
//  DAV
//
//  Created by Davis.Qiao on 16/4/20.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#import "PPCGProgressView.h"

@interface PPCGProgressView ()

@property (nonatomic,strong) UIImageView *progressView;
@property (nonatomic,strong) UIImageView *progressView_BG;

@end

@implementation PPCGProgressView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    weak_Self(mySelf);
    self = [super init];
    if (self) {
        
        self.backgroundColor=[UIColor clearColor];

        self.progressView_BG=[UIImageView new];
//        [self.progressView_BG setImage:[UIImage imageNamed:@"home_progressView_BG"]];
        [self.progressView_BG setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.progressView_BG];
        
       
        
        self.progressView = [UIImageView new];

        self.progressView.image = [UIImage imageNamed:@"home_progressView.png"];

        [self addSubview:self.progressView];
        
        
        
        [self.progressView_BG makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.left.bottom.right.equalTo(mySelf).insets(UIEdgeInsetsMake(0, 0, 0, 0));
            
        }];
        //
        [self.progressView makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.left.bottom.equalTo(mySelf).insets(UIEdgeInsetsMake(0,0, 0, 0));
            make.width.mas_equalTo(@0);
            
        }];
        

        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.progressView_BG PP_setCornerRadiusWithFloat:self.progressView_BG.PP_height*0.5 colorWith:DAV_COLOR_16(C7C7C7)];

    [self.progressView PP_setCornerRadiusWithFloat:self.progressView.PP_height*0.5 borderWidth:0];

}

-(void)setProgressPercent:(CGFloat)percent
{
  
    
    [self.progressView remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.bottom.equalTo(self).insets(UIEdgeInsetsMake(0,0, 0, 0));
        make.width.equalTo(self.progressView_BG.mas_width).multipliedBy(percent);

    }];

}



@end
