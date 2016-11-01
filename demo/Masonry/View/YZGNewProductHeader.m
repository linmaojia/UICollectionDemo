//
//  YZGNewProductHeader.m
//  yzg
//
//  Created by EDS on 16/6/4.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGNewProductHeader.h"
@interface YZGNewProductHeader ()
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UIView *grayView;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel *brandLable;
@property (nonatomic, strong) UIImageView *logoBottomView;

@end

@implementation YZGNewProductHeader
#pragma mark **************** init
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubviewsForHeader];
        [self addConstaintsForHeaderView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark **************** 添加子控件
- (void)addSubviewsForHeader
{
    [self addSubview:self.titleLable];
    [self addSubview:self.grayView];
    [self addSubview:self.logoBottomView];
    [self addSubview:self.logoImageView];
    [self addSubview:self.brandLable];
    self.titleLable.translatesAutoresizingMaskIntoConstraints = NO;
    self.grayView.translatesAutoresizingMaskIntoConstraints = NO;
    self.logoImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.brandLable.translatesAutoresizingMaskIntoConstraints = NO;
    self.logoBottomView.translatesAutoresizingMaskIntoConstraints = NO;
}
#pragma mark **************** 布局
- (void)addConstaintsForHeaderView
{
    [self.grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(@44);
    }];
    [self.logoBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(20);
        make.width.height.equalTo(@95);
     
    }];
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logoBottomView.right).offset(10);
        make.top.equalTo(self.grayView.bottom).offset(5);
    }];
  
//    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.logoBottomView).mas_offset(1);
//        make.leading.mas_equalTo(self.logoBottomView).mas_offset(5);
//        make.trailing.mas_equalTo(self.logoBottomView).mas_offset(-6);
//        make.height.mas_equalTo(58);
//    }];
//    [self.brandLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.logoBottomView);
//        make.width.mas_equalTo(90);
//        make.bottom.mas_equalTo(self.logoBottomView.mas_bottom).mas_offset(-10);
//    }];

}
#pragma mark **************** 懒加载
- (UILabel *)titleLable
{
    if (_titleLable == nil)
    {
        _titleLable = [[UILabel alloc] init];
        _titleLable.text = @"欧式风格--产品上新";
        _titleLable.font = [UIFont systemFontOfSize:12];
        _titleLable.textColor = RGB(51, 51, 51);
        [_titleLable sizeToFit];
    }
    return _titleLable;

}
- (UIView *)grayView
{
    if (_grayView == nil)
    {
        _grayView = [[UIView alloc] init];
        _grayView.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1.0];
    }
    return _grayView;
}
- (UIImageView *)logoImageView
{
    if (_logoImageView == nil)
    {
       _logoImageView = [[UIImageView alloc] init];
        _logoImageView.backgroundColor = [UIColor yellowColor];
    }
    return _logoImageView;
}
- (UILabel *)brandLable
{
    if (_brandLable == nil)
    {
        _brandLable = [[UILabel alloc] init];
        _brandLable.font = [UIFont systemFontOfSize:12];
        _brandLable.textColor = RGB(102, 102, 102);
        _brandLable.numberOfLines = 0;
        _brandLable.textAlignment = NSTextAlignmentCenter;
    }
    return _brandLable;
}
- (UIImageView *)logoBottomView
{
    if (_logoBottomView == nil)
    {
        _logoBottomView = [[UIImageView alloc] init];
        _logoBottomView.backgroundColor = [UIColor whiteColor];
        _logoBottomView.layer.borderColor = [UIColor colorWithWhite:237/255.0 alpha:1.0].CGColor;
        _logoBottomView.layer.borderWidth = 1;

    }
    return _logoBottomView;
}
@end
