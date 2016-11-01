//
//  YZGNewProductFooter.m
//  yzg
//
//  Created by EDS on 16/6/4.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGNewProductFooter.h"
@interface YZGNewProductFooter ()
@property (nonatomic, strong) UIButton *moreProductButton;
@end

@implementation YZGNewProductFooter
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubviewsForfooter];
        [self addConstaintsForfooterView];
       self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
#pragma mark **************** 添加子控件
- (void)addSubviewsForfooter
{
    [self addSubview:self.moreProductButton];
    self.moreProductButton.translatesAutoresizingMaskIntoConstraints = NO;
}
#pragma mark **************** 布局
- (void)addConstaintsForfooterView
{
    [self.moreProductButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self);
        make.width.mas_equalTo(170);
        make.height.mas_equalTo(30);
    }];
}
#pragma mark **************** 懒加载
- (UIButton *)moreProductButton
{
    if (_moreProductButton == nil)
    {
        _moreProductButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreProductButton setTitle:@"更多商品" forState:UIControlStateNormal];
        [_moreProductButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_moreProductButton setBackgroundColor:[UIColor colorWithRed:58/255.0 green:88/255.0 blue:153/255.0 alpha:1.0]];
        _moreProductButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [_moreProductButton sizeToFit];
        _moreProductButton.layer.cornerRadius = 30/2;
        [_moreProductButton addTarget:self action:@selector(buttonDidAction) forControlEvents:UIControlEventTouchUpInside];
        _moreProductButton.clipsToBounds = YES;
        
    }
    return _moreProductButton;
}
#pragma mark **************** 点击更多按钮触发
- (void)buttonDidAction
{
    if (self.moreProductButtonAction)
    {
        self.moreProductButtonAction();
    }
}
@end
