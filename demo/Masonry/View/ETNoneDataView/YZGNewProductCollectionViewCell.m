//
//  YZGNewProductCollectionViewCell.m
//  yzg
//
//  Created by EDS on 16/6/3.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGNewProductCollectionViewCell.h"
@interface YZGNewProductCollectionViewCell ()
@property (nonatomic, strong) UIImageView *productImageView;
@property (nonatomic, strong) UILabel *priceLable;
@property (nonatomic, strong) UILabel *wholescalLable;
@property (nonatomic, strong) UIView *grayLineView;

@end

@implementation YZGNewProductCollectionViewCell
#pragma mark **************** 懒加载
- (UIImageView *)productImageView
{
    if (_productImageView == nil)
    {
        _productImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_del_pro"]];
        _productImageView.backgroundColor = [UIColor yellowColor];
    }
    return _productImageView;
}
- (UILabel *)priceLable
{
    if (_priceLable == nil)
    {
        _priceLable = [[UILabel alloc] init];
        _priceLable.text = @"零售价：660.00 元";
        _priceLable.font = [UIFont systemFontOfSize:12];
        _priceLable.textColor = RGB(153, 153, 153);
        _priceLable.textAlignment = NSTextAlignmentCenter;
    }
    return _priceLable;
}
- (UILabel *)wholescalLable
{
    if (_wholescalLable == nil)
    {
        _wholescalLable = [[UILabel alloc] init];
        _wholescalLable.text = @"批发价：444.00 元";
        _wholescalLable.font = [UIFont systemFontOfSize:12];
        _wholescalLable.textColor = RGB(58, 88, 153);
        _wholescalLable.textAlignment = NSTextAlignmentCenter;
    }
    return _wholescalLable;
}
- (UIView *)grayLineView
{
    if (_grayLineView == nil)
    {
        _grayLineView = [[UIView alloc] init];
        _grayLineView.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0];
    }
    return _grayLineView;
}
#pragma mark **************** init
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubviewsForCell];
        [self addConstraintForCell];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
#pragma mark **************** 添加子视图
- (void)addSubviewsForCell
{
    [self.contentView addSubview:self.productImageView];
    [self.contentView addSubview:self.priceLable];
    [self.contentView addSubview:self.wholescalLable];
    [self.contentView addSubview:self.grayLineView];
    self.productImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.priceLable.translatesAutoresizingMaskIntoConstraints = NO;
    self.wholescalLable.translatesAutoresizingMaskIntoConstraints = NO;
}

#pragma mark **************** yues
- (void)addConstraintForCell
{
    [_wholescalLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(@(AUTO_MATE_WIDTH(20)));
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    [_priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.wholescalLable);
        make.bottom.equalTo(_wholescalLable.top).offset(-3);
    }];
    [_productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(20);
        make.bottom.equalTo(self.priceLable.top).offset(-3);
        make.left.equalTo(self.contentView).offset(25);
        make.right.equalTo(self.contentView).offset(-25);
    }];

}

#pragma mark **************** 计算灰线的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect frame = CGRectZero;
    CGFloat cellH = self.contentView.frame.size.height;
    CGFloat cellW = self.contentView.frame.size.width;
    switch (self.indexPath.item)
    {
        case 0:
            frame = CGRectMake(cellW - 1.5, 5, 1.5, cellH -10);
            break;
        case 1:
            frame = CGRectMake(5, cellH - 1.5, cellW -10, 1.5);
            break;
        case 2:
            frame = CGRectMake(5, 0, cellW -10, 1.5);
            break;
        case 3:
            frame = CGRectMake(-1.5*0.5 , 5, 1.5, cellH -10);
            break;
        default:
            break;
    }
    self.grayLineView.frame = frame;
}

@end
