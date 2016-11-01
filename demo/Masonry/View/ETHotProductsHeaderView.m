//
//  ETCollectBrandHeaderView.m
//  ETao
//
//  Created by AVGD－Mai on 16/4/6.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "ETHotProductsHeaderView.h"

@interface ETHotProductsHeaderView()

@property (nonatomic, strong) UIView *lineView;    /**< 头部分割线 */

@end

@implementation ETHotProductsHeaderView

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = hexColor(FAFAFA);
        
    }
    return _lineView;
}
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = systemFont(16);
        
        _titleLab.backgroundColor = [UIColor whiteColor];
    }
    return _titleLab;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLab];
        [self addSubview:self.lineView];

    }
    return self;
}



- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(@(10));
    }];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineView.bottom);
        make.right.bottom.equalTo(self);
        make.left.equalTo(@(10));
    }];
}

@end
