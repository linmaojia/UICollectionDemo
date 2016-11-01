

#import "CollectMyCell.h"

@interface CollectMyCell ()
@property (nonatomic, strong) UILabel *nameLab;     /**< 品牌名 */

@end


@implementation CollectMyCell

+ (CollectMyCell *)hotProductsCellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath{
    CollectMyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[CollectMyCell alloc] init];
    }
    return cell;
    
}


- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] init];
        _nameLab.font = [UIFont systemFontOfSize:14];
        _nameLab.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLab;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.nameLab];
        
    }
    return self;
}

- (void)setName:(NSString *)name{
    _name = name;
    self.nameLab.text = _name;
}
- (void)setColor:(UIColor *)color{
    _color = color;
    self.nameLab.backgroundColor = _color;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
      [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
          make.edges.equalTo(self.contentView);
      }];

}



@end
