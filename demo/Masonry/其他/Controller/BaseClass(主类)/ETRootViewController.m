//
//  ETRootViewController.m
//  ETao
//
//  Created by AVGD on 15/9/17.
//  Copyright (c) 2015年 jacky. All rights reserved.
//

#import "ETRootViewController.h"

@interface ETRootViewController ()

@end

@implementation ETRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"diamond_upholstery"]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [SVProgressHUD dismiss];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    //收起键盘
    [self.view endEditing:YES];
}

@end
