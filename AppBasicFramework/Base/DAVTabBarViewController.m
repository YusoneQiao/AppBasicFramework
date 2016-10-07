//
//  DAVTabBarViewController.m
//  DAV
//
//  Created by Davis.Qiao on 16/3/18.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#import "DAVTabBarViewController.h"
#import "DAVHomeViewController.h"
#import "DAVProductsViewController.h"
#import "DAVFindViewController.h"
#import "DAVShoppingCartViewController.h"
#import "DAVMineViewController.h"


@interface DAVTabBarViewController ()

@end

@implementation DAVTabBarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showBadgeNum:) name:Noti_Tab_ShowBadgeNum object:nil];
    DAVHomeViewController *homeVC = [[DAVHomeViewController alloc]init];
    DAVProductsViewController *productsVC = [[DAVProductsViewController alloc]init];
    DAVFindViewController *findVC = [[DAVFindViewController alloc]init];
    DAVShoppingCartViewController *shoppingCartVC = [[DAVShoppingCartViewController alloc]init];
    DAVMineViewController *mineVC = [[DAVMineViewController alloc]init];
    
    NSMutableArray * viewControllers = [NSMutableArray array];
    NSArray *rootViewController =  @[homeVC,productsVC,findVC,shoppingCartVC,mineVC];
    NSArray *normalImageArray = @[@"tabBar_home_normal.png",@"tabBar_category_normal.png",@"tabBar_find_normal.png",@"tabBar_cart_normal.png",@"tabBar_mine_normal.png"];
    NSArray *selectedImageArray = @[@"tabBar_home_press.png",@"tabBar_category_press.png",@"tabBar_find_press.png",@"tabBar_cart_press.png",@"tabBar_mine_press.png",];
//    NSArray *titleArray = @[@"首页",@"商品",@"发现",@"购物车",@"我的"];
    NSArray *titleArray = @[@"",@"",@"",@"",@""];
    if (rootViewController.count == normalImageArray.count && rootViewController.count == selectedImageArray.count) {
        for (int i=0; i<rootViewController.count; i++) {
            
            UINavigationController *navigationViewController = [[UINavigationController alloc]initWithRootViewController:rootViewController[i]];
            
            //设置UIImage的渲染方式为UIImageRenderingModeAlwaysOriginal
            UIImage * normalImage = [[UIImage imageNamed:normalImageArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            UIImage * selectImage = [[UIImage imageNamed:selectedImageArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            NSString *titleString = titleArray[i];
            
            //不设置title时 设置空值就可以了
            navigationViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:titleString image:normalImage selectedImage:selectImage];
            navigationViewController.tabBarItem.tag = i;
            navigationViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(4, 0, -4, 0);
//            navigationViewController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
            [navigationViewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:DAV_COLOR_16(909090) ,NSFontAttributeName:[UIFont systemFontOfSize:11.0]} forState:UIControlStateNormal];
            [navigationViewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:DAV_COLOR_16(FF4800) ,NSFontAttributeName:[UIFont systemFontOfSize:11.0]} forState:UIControlStateSelected];
            
            [viewControllers addObject:navigationViewController];
        }
    }
   
    self.viewControllers = viewControllers;
    
    
    

}


-(void)showBadgeNum:(NSNotification *)noti
{
    
    NSString* eqStr=[noti object];
    if ([eqStr isEqual:@"clean"]) {
        
        [ConfigDAV upDateProductNum:0];
        [[[self.tabBar items]objectAtIndex:3]setBadgeValue:nil];

    }else
    {
        NSInteger num= [ConfigDAV getProductNum];
        
        if (!num) {
            
            [[[self.tabBar items]objectAtIndex:3]setBadgeValue:nil];

        }
        else
        {
            NSString *numStr=[NSString  stringWithFormat:@"%ld",num];
            
            [[[self.tabBar items]objectAtIndex:3]setBadgeValue:numStr];

        }
      
    }
    
    
}

-(void)dealloc
{

    [self removeObserver:self forKeyPath:Noti_Tab_ShowBadgeNum];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
