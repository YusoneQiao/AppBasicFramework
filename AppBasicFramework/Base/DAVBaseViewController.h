//
//  CustomViewController.h

//
//  Created by Davis.Qiao on 16/4/6.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
////

#import <UIKit/UIKit.h>

@interface DAVBaseViewController : UIViewController

//搜索页面
-(void)setSearchView;

- (void)bringNaviBarToTopmost;

- (void)setNaviBarTitle:(NSString *)strTitle image:(UIImage *)imageTitle;

- (void)setNaviBarLeftBtn:(UIButton *)btn;

- (void)setNaviBarRightBtn:(UIButton *)btn;

-(void)setNavHidden;

-(void)setRightNaviBarBtnByText:(NSString *)btnText selColor:(UIColor *)selColor clickAction:(SEL)actionEvent;
/**
 *
 *
 *  @param strImg          普通图
 *  @param strImgHighlight 高亮图
 *  @param actionEvent     点击事件
 */
-(void)setNavBackColor:(UIColor *)color;

-(void)setLeftNaviBarBtnByImgNormal:(UIImage *)strImg imgHighlight:(UIImage *)strImgHighlight;

//不是返回按钮，不需要重写btnBack方法
-(void)setLeftNaviBarBtnByImgNormal:(UIImage *)strImg imgHighlight:(UIImage *)strImgHighlight clickAction:(SEL)actionEvent;

-(void)setRightNaviBarBtnByImgNormal:(UIImage *)strImg imgHighlight:(UIImage *)strImgHighlight clickAction:(SEL)actionEvent;

/**
 *  @param btnText    按钮文字
 *  @param actionEvent 点击事件
 */
//-(void)setRightNaviBarBtnByText:(NSString *)btnText clickAction:(SEL)actionEvent;


//设置常规tableview
-(UITableView *)setCustomerTableView;



//角标数量变化
-(void)addTabBarBadgeNum;

-(void)delTabBarBadgeNum;

//更新角标数量

-(void)updateTabBarBadgeNum:(NSInteger)num;

//提示角标

-(void)notiTabBarShowBadge;

//隐藏角标
-(void)cleanTabBarBadgeNum;

#pragma mark - 悬浮购物车角标
-(void)setCartBadgeValue;
-(void)refreshCartBadgeValue;

@property (nonatomic,assign) NSInteger cartProductsNumber;

-(void)getNickNameJumpButtonWithButton:(UIButton *)nickButton isOther:(BOOL)isOther;
-(void)addToCartView;

@property (nonatomic,strong) UIButton *addToCartButton;
@property (nonatomic,strong) UILabel *addToCarBadgeValueLabel;
@property (nonatomic,strong) NSString *nickButtonTagString;

@end
