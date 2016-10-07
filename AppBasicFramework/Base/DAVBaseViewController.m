//
//  CustomViewController.m
//  CustomNavigationBarDemo
//
//  Created by Davis.Qiao on 16/4/6.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#import "DAVBaseViewController.h"
#import "CustomNaviBarView.h"


#import <objc/runtime.h>
@interface DAVBaseViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic, strong) CustomNaviBarView *viewNaviBar;


@end

@implementation DAVBaseViewController



-(void)setNavBackColor:(UIColor *)color
{
    _viewNaviBar.backgroundColor=color;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //去掉滑动View的顶部留白
        self.edgesForExtendedLayout = UIRectEdgeNone;
        //一级视图默认不显示左滑按钮


        
    }
    return self;
}

-(void)updateTabBarBadgeNum:(NSInteger)num
{
    
    [ConfigDAV upDateProductNum:num];
    [self notiTabBarShowBadge];

}
-(void)addTabBarBadgeNum
{
    NSInteger num=[ConfigDAV getProductNum];
    NSInteger addNum=num+1;
    [ConfigDAV upDateProductNum:addNum];
    [self notiTabBarShowBadge];
}

-(void)delTabBarBadgeNum
{
    NSInteger num=[ConfigDAV getProductNum];
    NSInteger delNum=num-1;
    [ConfigDAV upDateProductNum:delNum];
    [self notiTabBarShowBadge];

}

-(void)dealloc
{
    DAVDebugLog(@"dealloc--%@",self);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:NSStringFromClass([self class])];//("PageOne"为页面名称，可自定义)

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick endLogPageView:NSStringFromClass([self class])];

    
    if (_viewNaviBar && !_viewNaviBar.hidden)  [self.view bringSubviewToFront:_viewNaviBar];
    [self setLeftNaviBarBtnByImgNormal:[UIImage imageNamed:@"Nav_back"] imgHighlight:[UIImage imageNamed:@"Nav_back"]];

            if (self.navigationController.viewControllers.count-1) {
    
//                [self setLeftNaviBarBtnByImgNormal:[UIImage imageNamed:@"Nav_back"] imgHighlight:[UIImage imageNamed:@"Nav_back"]];
                [self creatNorBackBtn];
    
            }else
            {
                [self setLeftNaviBarBtnByImgNormal:nil imgHighlight:nil];
            }
    
    

    //导航栏颜色
    NSString *currentClassName = [NSString stringWithUTF8String:object_getClassName(self)];
    if ([currentClassName isEqualToString:@"DAVHomeViewController"]) {
         _viewNaviBar.backgroundColor = DAV_COLOR_16(FF4800);
        _viewNaviBar.lineNaviView.hidden = YES;
    }else{
        _viewNaviBar.backgroundColor = DAV_COLOR_16(F0F0F0);
    }
    
    
}

-(void)creatNorBackBtn
{
    UIButton *btn=[CustomNaviBarView creatNavNorBack:nil imgHighlight:nil];
    [btn addTarget:self action:@selector(btnBack:) forControlEvents:UIControlEventTouchUpInside];
    [self setNaviBarLeftBtn:btn];
}
-(UITableView *)setCustomerTableView
{
    
        UITableView *cusTomerView=[[UITableView alloc]initWithFrame:[self.view visibleBoundsShowNav:YES showTabBar:YES] style:UITableViewStylePlain];
        cusTomerView.delegate=self;
        cusTomerView.dataSource=self;
        cusTomerView.backgroundColor = DAV_BACKGROUND_COLOR;
        cusTomerView.showsVerticalScrollIndicator=NO;
        cusTomerView.showsHorizontalScrollIndicator=NO;
//        cusTomerView.separatorStyle=UITableViewCellAccessoryNone;
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = DAV_BACKGROUND_COLOR;
        [cusTomerView setTableFooterView:view];
 
        return cusTomerView;
}

-(void)setNavHidden
{
    if (_viewNaviBar) {
        
        [_viewNaviBar removeFromSuperview];
        
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setHidden:YES];
    
    
    self.view.backgroundColor=DAV_BACKGROUND_COLOR;

    [self.view addSubview:self.viewNaviBar];
    
  
}


-(CustomNaviBarView *)viewNaviBar
{
    _viewNaviBar = [[CustomNaviBarView alloc] initWithFrame:Rect(0.0f, 0.0f, [CustomNaviBarView barSize].width, [CustomNaviBarView barSize].height)];
//    _viewNaviBar.backgroundColor=DAV_BACKGROUND_COLOR;
    [_viewNaviBar addSubview:_viewNaviBar.lineNaviView];
    _viewNaviBar.m_viewCtrlParent = self;
    return _viewNaviBar;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -

- (void)bringNaviBarToTopmost
{
    if (_viewNaviBar)
    {
        [self.view bringSubviewToFront:_viewNaviBar];
    }else{}
}

- (void)hideNaviBar:(BOOL)bIsHide
{
    _viewNaviBar.hidden = bIsHide;
}

- (void)setNaviBarTitle:(NSString *)strTitle image:(UIImage *)imageTitle
{
    if (_viewNaviBar)
    {
        [_viewNaviBar setTitle:strTitle image:imageTitle];
    }
}

-(void)setSearchView{
    if (_viewNaviBar)
    {
        [_viewNaviBar setSearchView];
    }
}

- (void)setNaviBarLeftBtn:(UIButton *)btn
{
    if (_viewNaviBar)
    {
        [_viewNaviBar setLeftBtn:btn];
    }
}

- (void)setNaviBarRightBtn:(UIButton *)btn
{
    if (_viewNaviBar)
    {
        [_viewNaviBar setRightBtn:btn];
    }
}

-(void)setNorNaviBarBtn:(UIImage *)strImg imgHighlight:(UIImage *)strImgHighlight
{
    UIButton *btn=[CustomNaviBarView createImgNaviBarBtnByImgNormal:strImg imgHighlight:strImgHighlight  target:self action:@selector(btnBack:)];
    [self setNaviBarLeftBtn:btn];

}


-(void)setLeftNaviBarBtnByImgNormal:(UIImage *)strImg imgHighlight:(UIImage *)strImgHighlight
{
    if (_viewNaviBar)
{
        
   UIButton *btn=[CustomNaviBarView createImgNaviBarBtnByImgNormal:strImg imgHighlight:strImgHighlight  target:self action:@selector(btnBack:)];
    [self setNaviBarLeftBtn:btn];
}

}

//不是返回的左侧按钮
-(void)setLeftNaviBarBtnByImgNormal:(UIImage *)strImg imgHighlight:(UIImage *)strImgHighlight clickAction:(SEL)actionEvent
{
    UIButton *btn=[CustomNaviBarView createImgNaviBarBtnByImgNormal:strImg imgHighlight:strImgHighlight  target:self action:actionEvent];
    
    [self setNaviBarLeftBtn:btn];
}


-(void)setRightNaviBarBtnByImgNormal:(UIImage *)strImg imgHighlight:(UIImage *)strImgHighlight clickAction:(SEL)actionEvent
{
    UIButton *btn=[CustomNaviBarView createImgNaviBarBtnByImgNormal:strImg imgHighlight:strImgHighlight  target:self action:actionEvent];
   
    [self setNaviBarRightBtn:btn];

}

-(void)setRightNaviBarBtnByText:(NSString *)btnText selColor:(UIColor *)selColor clickAction:(SEL)actionEvent
{
    
    !selColor?ColorFromString(@"0042FF") :[UIColor whiteColor];
    if (_viewNaviBar) {
        
        UIButton *btn=[CustomNaviBarView createNormalNaviBarBtnByTitle:btnText target:self action:actionEvent];
        
        [btn setTitleColor:selColor forState:UIControlStateNormal];
        

//        selColor?[btn setTitleColor:selColor  forState:UIControlStateSelected]:[btn setTitleColor:[UIColor lightGrayColor]  forState:UIControlStateSelected];

        [self setNaviBarRightBtn:btn];
    }
}

- (void)btnBack:(id)sender
{
    if (_viewNaviBar.m_viewCtrlParent)
    {
        [_viewNaviBar.m_viewCtrlParent.navigationController popViewControllerAnimated:YES];
    }
    
}

//底部提示角标

-(void)notiTabBarShowBadge;
{
    [[NSNotificationCenter defaultCenter]postNotificationName:Noti_Tab_ShowBadgeNum object:nil];
}

-(void)cleanTabBarBadgeNum
{
    [[NSNotificationCenter defaultCenter]postNotificationName:Noti_Tab_ShowBadgeNum object:@"clean"];
}



#pragma mark - 购物车半透明按钮
-(UIButton *)addToCartButton{
    if (!_addToCartButton) {
        _addToCartButton = [[UIButton alloc]initWithFrame:DAV_FRAME_AADTOCART];
        [_addToCartButton setImage:[UIImage imageNamed:@"addToCart.png"] forState:UIControlStateNormal];
        [_addToCartButton addTarget:self action:@selector(addToCartView) forControlEvents:UIControlEventTouchUpInside];
        [_addToCartButton addSubview:self.addToCarBadgeValueLabel];
        _addToCartButton.hidden = YES;
        [self.view addSubview:_addToCartButton];
    }
    return _addToCartButton;
}

-(UILabel *)addToCarBadgeValueLabel{
    if (!_addToCarBadgeValueLabel) {
        _addToCarBadgeValueLabel = [[UILabel alloc]initWithFrame:Rect(19, -5, 20, 20)];
        _addToCarBadgeValueLabel.backgroundColor = [UIColor redColor];
        _addToCarBadgeValueLabel.layer.masksToBounds = YES;
        [_addToCarBadgeValueLabel setFont:[UIFont systemFontOfSize:13]];
        [_addToCarBadgeValueLabel setAdjustsFontSizeToFitWidth:YES];
        _addToCarBadgeValueLabel.layer.cornerRadius = _addToCarBadgeValueLabel.frame.size.width * 0.5;
        _addToCarBadgeValueLabel.textColor = [UIColor whiteColor];
        _addToCarBadgeValueLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _addToCarBadgeValueLabel;
}


-(void)addToCartView{
//    Class cl=NSClassFromString(@"DAVShoppingCartViewController");
//    UIViewController *targetVC=(UIViewController *)[[cl alloc]init];
//    targetVC.hidesBottomBarWhenPushed=NO;
//    [self.navigationController pushViewController:targetVC anximated:YES];
    
    
    if (self.tabBarController.selectedIndex == 3) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }else{
        [self.tabBarController setSelectedIndex:3];
    }
}


#pragma mark - 购物车角标
//增加
-(void)setCartBadgeValue{
    
        self.cartProductsNumber =[ConfigDAV getProductNum];
        self.addToCarBadgeValueLabel.text = [NSString stringWithFormat:@"%ld",self.cartProductsNumber];
        if (![self.addToCarBadgeValueLabel.superview isEqual:self.addToCartButton]) {//若为0，刷新时候被销毁。此时显示不出来
            [self.addToCartButton addSubview:self.addToCarBadgeValueLabel];
        }
    }

//刷新角标
-(void)refreshCartBadgeValue{
    self.cartProductsNumber = [ConfigDAV getProductNum];
    if (self.cartProductsNumber == 0) {
        
        [self cleanTabBarBadgeNum];
        
    }else{
        
        self.addToCarBadgeValueLabel.text = [NSString stringWithFormat:@"%ld",self.cartProductsNumber];
        
          }
}



#pragma mark - 点击昵称跳转到对应个人信息详情页

/**
 *  页面跳转逻辑，tag==0，自己页面。tag==1，别人页面。
 */
-(void)nickNameJumpButtonAction{
    if ([self.nickButtonTagString isEqualToString:@"me"]) {//自己
        [self.navigationController popToRootViewControllerAnimated:YES];
        [self.tabBarController setSelectedIndex:4];
    }else if ([self.nickButtonTagString isEqualToString:@"other"]){//他人
        Class class=NSClassFromString(@"DAVOtherUserViewController");
        UIViewController *targetVC=(UIViewController *)[[class alloc]init];
        targetVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:targetVC animated:YES];
    }else{}
}

//一行代码获取button
-(void)getNickNameJumpButtonWithButton:(UIButton *)nickButton isOther:(BOOL)isOther{
    nickButton.backgroundColor = [UIColor clearColor];
//    nickButton.alpha = 0.5;
    [nickButton addTarget:self action:@selector(nickNameJumpButtonAction) forControlEvents:UIControlEventTouchUpInside];
    if (isOther == YES) {
        self.nickButtonTagString = @"other";
    }else{
        self.nickButtonTagString = @"me";
    }
}


@end
