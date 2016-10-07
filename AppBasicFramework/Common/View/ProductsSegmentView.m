//
//  ProductsSegmentView.m
//  DAV
//
//  Created by Davis.Qiao on 16/4/22.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#import "ProductsSegmentView.h"


@interface ProductsSegmentView()
@property (nonatomic,assign) BOOL isUp;
@property (nonatomic,strong) UIButton *changeButton;
@property(nonatomic,copy)productsSegmentalTapBlock tempBlock;
@end
@implementation ProductsSegmentView


- (instancetype)initWithFrame:(CGRect)frame clickIndex:(productsSegmentalTapBlock)block
{
    self=[super initWithFrame:frame];
    if (self) {
        
        if (block) {
            _tempBlock=block;
        }
        
        [self initUI];
    }
    return self;
}


-(void)initUI{

    NSArray *titleArray=@[@"最热",@"最新",@"剩余人次",@"总需人次"];

    self.backgroundColor=[UIColor whiteColor];
    CGFloat btnWidth=CGRectGetWidth(self.frame)/titleArray.count;
    CGFloat btnHeight=CGRectGetHeight(self.frame);
    
    for (int i=0; i<titleArray.count; i++) {
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(i*btnWidth + 10, 0, btnWidth-1, btnHeight);
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        btn.selected=i?NO:YES;
        btn.tag=i;
        [btn setTitleColor:Main_LabelBlack_COLOR forState:UIControlStateNormal];
        [btn setTitleColor:ColorFromString(@"FF5400") forState:UIControlStateSelected];
        btn.titleLabel.font=FontWithMicrosoft(14);
        [btn addTarget:self action:@selector(segmentClickHander:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [UIColor clearColor];
        [self addSubview:btn];
        
        UILabel *linelabel=[UILabel new];
        linelabel.tag=i+10;
        linelabel.frame=CGRectMake(btn.PP_origin.x + 5, btn.PP_bottom-2+1, btn.PP_width - 10, 2);
        linelabel.backgroundColor=i?[UIColor clearColor]:ColorFromString(@"FF5400");
        [self addSubview:linelabel];
        
        if (i == titleArray.count - 1) {
            self.changeButton = btn;
        }
    }
    
    //添加分隔线
    [self addLineView];
}


-(void)segmentClickHander:(id)sender
{
    [self.changeButton setTitle:@"总需人次" forState:UIControlStateNormal];
    
    for (UIView *tempV in self.subviews) {
        
        
        if ([tempV isKindOfClass:[UIButton class]] ) {
            
            UIButton *tempBtn=(UIButton *)tempV;
            
            tempBtn.selected=NO;
        }
        
        if ([tempV isKindOfClass:[UILabel class]] ) {
            
            UILabel *tempLab=(UILabel *)tempV;
            
            tempLab.backgroundColor=[UIColor clearColor];
        }
    }
    
    UIButton *btn=(UIButton *)sender;
    
    //回调tag
    _tempBlock(btn.tag);
    
    if (btn.tag == 3) {
        if (!self.isUp) {
            [btn setTitle:@"总需人次∧" forState:UIControlStateNormal];
            self.isUp = YES;
        }else{
            [btn setTitle:@"总需人次∨" forState:UIControlStateNormal];
            self.isUp = NO;
        }
    }else{
        self.isUp = NO;
    }

    btn.selected=YES;

    UILabel *label=(UILabel *)[self viewWithTag:btn.tag+10];
    label.backgroundColor=ColorFromString(@"FF5400");
}


//添加分隔线
-(void)addLineView{
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(self.PP_origin.x, 31.5, self.PP_size.width, 0.5)];
    lineView.backgroundColor = DAV_COLOR_16(C7C7C7);
    [self insertSubview:lineView atIndex:0];
}

@end
