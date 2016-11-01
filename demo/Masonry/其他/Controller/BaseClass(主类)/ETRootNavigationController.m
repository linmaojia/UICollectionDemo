//
//  ETRootNavigationController.m
//  ETao
//
//  Created by AVGD on 15/9/17.
//  Copyright (c) 2015年 jacky. All rights reserved.
//

#import "ETRootNavigationController.h"


@interface ETRootNavigationController ()

@end

@implementation ETRootNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}
//隐藏下方TabBar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

/**
 *  当第一次使用这个类的时候调用1次
 http://blog.csdn.net/sbvfhp/article/details/47857851 说明网址
 */
+ (void)initialize
{
    // 设置UINavigationBar的主题
    [self setupNavigationBarTheme];
    
}

+ (void)setupNavigationBarTheme
{
    UINavigationBar *appearance = [UINavigationBar appearance];
    
#warning 这里使用图片和不用图片  会影响控制器的view的尺寸,原因暂时不得而知  建议使用鱼片
    //以下二选一   最好用图片
    // 设置导航栏背景图片
    [appearance setBackgroundImage:[UIImage imageNamed:@"navigationbar"] forBarMetrics:UIBarMetricsDefault];
    //设置导航栏背景颜色
//    [appearance setBarTintColor:mainColor];
//    [appearance.layer setMasksToBounds:YES];
    
    // 设置中部文字属性
    [appearance setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];

    //设置返回文字颜色
    [appearance setTintColor:[UIColor whiteColor]];
}


@end
