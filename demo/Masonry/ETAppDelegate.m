//
//  AppDelegate.m
//  Masonry
//
//  Created by LXY on 16/4/27.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "ETAppDelegate.h"
#import "ViewController.h"
#import "ETRootNavigationController.h"

@interface ETAppDelegate ()

@end

@implementation ETAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];//设置主窗口并显示出来
    
    
    // 注册第三方库
    [self registThirdPart];
    
    // 其他逻辑
    [self handleOtherLogic];
    
    // 基本页面跳转逻辑
    [self baseViewJumpLogic];
    
  
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)registThirdPart
{
    
}

- (void)handleOtherLogic
{
    #pragma mark - 配置SVP
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setFont:[UIFont boldSystemFontOfSize:16.f]];
    
    
    
    #pragma mark - 配置IQKeyboardManager  ？？？？？？？有需求再弄
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    //激活
    manager.enable = YES;
    //设置点击View其它位置收回键盘
    manager.shouldResignOnTouchOutside = YES;
    //设置工具栏颜色是否跟文本框一致
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    //激活工具栏
    manager.enableAutoToolbar = YES;
    
    #pragma mark - 配置alerView
    [[SIAlertView appearance] setMessageFont:[UIFont systemFontOfSize:16]];
    [[SIAlertView appearance] setTitleColor:[UIColor blackColor]];
    [[SIAlertView appearance] setMessageColor:[UIColor blackColor]];
    [[SIAlertView appearance] setCornerRadius:12];
    [[SIAlertView appearance] setShadowRadius:20];
    [[SIAlertView appearance] setViewBackgroundColor:hexColor(F8F8F8)];
    //默认按钮文字颜色
    [[SIAlertView appearance] setButtonColor:[UIColor whiteColor]];
    //取消按钮文字颜色
    [[SIAlertView appearance] setCancelButtonColor:[UIColor blackColor]];
    [[SIAlertView appearance] setDestructiveButtonColor:[UIColor blackColor]];
    
    [[SIAlertView appearance] setDefaultButtonImage:[[UIImage imageFromContextWithColor:[UIColor colorWithRed:0.949  green:0.188  blue:0.184 alpha:1]] resizableImageWithCapInsets:UIEdgeInsetsMake(15,5,14,6)] forState:UIControlStateNormal];
    
    [[SIAlertView appearance] setTransitionStyle:SIAlertViewTransitionStyleBounce];
    
    [[SIAlertView appearance] setCancelButtonImage:[[UIImage imageFromContextWithColor:[UIColor whiteColor]] resizableImageWithCapInsets:UIEdgeInsetsMake(15,5,14,6)] forState:UIControlStateNormal];
    
    [[SIAlertView appearance] setButtonFont:[UIFont systemFontOfSize:16]];
    
    
    #pragma mark - 配置TSMessgae
    [[TSMessageView appearance] setTitleFont:[UIFont boldSystemFontOfSize:16]];
    [[TSMessageView appearance] setDuration:1.5f];
    [[TSMessageView appearance] setMessagePosition:TSMessageNotificationPositionTop];
    [[TSMessageView appearance] setMessageIsFullyDisplayed:YES];
}

- (void)baseViewJumpLogic
{
    
    ETRootNavigationController *nav = [[ETRootNavigationController alloc] initWithRootViewController:[ViewController new]];
    self.window.rootViewController = nav;
}

@end
