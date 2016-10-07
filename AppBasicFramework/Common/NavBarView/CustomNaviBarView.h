//
//  CustomNaviBarView.h

//  PPNavTest
//
//  Created by Davis.Qiao on 16/4/6.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//
//

#import <UIKit/UIKit.h>

@interface CustomNaviBarView : UIView

@property (nonatomic, weak) UIViewController *m_viewCtrlParent;

+ (CGRect)rightBtnFrame;
+ (CGSize)barBtnSize;
+ (CGSize)barSize;
+ (CGRect)titleViewFrame;

// 创建一个导航条按钮：使用默认的按钮图片。
+ (UIButton *)createNormalNaviBarBtnByTitle:(NSString *)strTitle target:(id)target action:(SEL)action;

// 创建一个导航条按钮：自定义按钮图片。
+ (UIButton *)createImgNaviBarBtnByImgNormal:(UIImage *)strImg imgHighlight:(UIImage *)strImgHighlight target:(id)target action:(SEL)action;

//返回按钮  距离
+(UIButton *)creatNavNorBack:(UIImage *)strImg imgHighlight:(UIImage *)strImgHighlight;

// 用自定义的按钮和标题替换默认内容
- (void)setLeftBtn:(UIButton *)btn;
- (void)setRightBtn:(UIButton *)btn;
- (void)setTitle:(NSString *)strTitle image:(UIImage *)imageTitle;
//搜索页面
-(void)setSearchView;

@property (nonatomic,strong) UIView *lineNaviView;

@end
