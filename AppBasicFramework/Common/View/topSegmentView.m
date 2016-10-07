//
//  topSegmentView.m
//  DAV
//
//  Created by Davis.Qiao on 16/4/20.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#import "topSegmentView.h"

@interface topSegmentView ()

@property(nonatomic,copy)segmentalTapBlock tempBlock;

@end

@implementation topSegmentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame titleArrays:(NSArray *)titleArrs clickIndex:(segmentalTapBlock)block
{
    if (self=[super initWithFrame:frame]) {
        
        if (block) {
            _tempBlock=block;
        }
        
     
        self.backgroundColor=[UIColor whiteColor];
        CGFloat btnWidth=CGRectGetWidth(frame)/titleArrs.count;
        CGFloat btnHeight=CGRectGetHeight(frame);
        
        for (int i=0; i<titleArrs.count; i++) {
            
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(i*btnWidth, 0, btnWidth, btnHeight);
            [btn setTitle:titleArrs[i] forState:UIControlStateNormal];
            btn.selected=i?NO:YES;
            btn.tag=i;
            [btn setTitleColor:Main_LabelBlack_COLOR forState:UIControlStateNormal];
            [btn setTitleColor:ColorFromString(@"FF5400") forState:UIControlStateSelected];
            btn.titleLabel.font=FontWithMicrosoft(15);
            [btn addTarget:self action:@selector(segmentClickHander:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            
            UILabel *linelabel=[UILabel new];
            linelabel.tag=i+10;
            linelabel.frame=CGRectMake(btn.PP_origin.x, btn.PP_bottom-2, btn.PP_width, 2);
            linelabel.backgroundColor=i?[UIColor whiteColor]:ColorFromString(@"FF5400");
            [self addSubview:linelabel];
            
            UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(btn.PP_origin.x, btn.PP_bottom-0.5, btn.PP_width, 0.5)];
            lineView.backgroundColor=kLineView_Color;
            [self addSubview:lineView];

        }
        
      
        
    }
    return self;
}

-(void)segmentClickHander:(id)sender
{
    
    for (UIView *tempV in self.subviews) {
        
        
        if ([tempV isKindOfClass:[UIButton class]] ) {
            
            UIButton *tempBtn=(UIButton *)tempV;
            
            tempBtn.selected=NO;
        }
        
        if ([tempV isKindOfClass:[UILabel class]] ) {
            
            UILabel *tempLab=(UILabel *)tempV;
            
            tempLab.backgroundColor=[UIColor whiteColor];
        }
    }
    
    UIButton *btn=(UIButton *)sender;
    _tempBlock(btn.tag);
    btn.selected=YES;
    
    UILabel *label=(UILabel *)[self viewWithTag:btn.tag+10];
    label.backgroundColor=ColorFromString(@"FF5400");
    
    
}

@end
