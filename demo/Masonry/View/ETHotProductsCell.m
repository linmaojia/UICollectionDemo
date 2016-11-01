

#import "ETHotProductsCell.h"

@interface ETHotProductsCell ()
@property (nonatomic, strong) UIImageView *productImg;     /**< 品牌图片 */
@property (nonatomic, strong) UILabel *brandNameLab;     /**< 品牌名 */
@property (nonatomic, strong) UILabel *priceLab;     /**< 批发价 */
@property (nonatomic, strong) UILabel *productNumLab;    /**< 规格 */
@property (nonatomic, strong) UILabel *originPriceLab;    /**< 原价 */
@end


@implementation ETHotProductsCell

+ (ETHotProductsCell *)hotProductsCellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath{
    ETHotProductsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[ETHotProductsCell alloc] init];
    }
    return cell;
    
}

- (void)setIndexPath:(NSIndexPath *)indexPath{

    _indexPath = indexPath;
}

- (UIImageView *)productImg {
    if (!_productImg) {
        _productImg = [[UIImageView alloc] init];
        [_productImg setContentMode:UIViewContentModeScaleAspectFit];
        _productImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(productImgClickAction:)];
        [_productImg addGestureRecognizer:singleTap];
    }
    return _productImg;
}

- (UILabel *)brandNameLab {
    if (!_brandNameLab) {
        _brandNameLab = [[UILabel alloc] init];
        _brandNameLab.font = [UIFont systemFontOfSize:14];
        _brandNameLab.textAlignment = NSTextAlignmentCenter;
        _brandNameLab.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(brandNameLabClickAction:)];
        [_brandNameLab addGestureRecognizer:singleTap];
    }
    return _brandNameLab;
}

- (UILabel *)priceLab {
    if (!_priceLab) {
        _priceLab = [[UILabel alloc] init];
        _priceLab.font = [UIFont systemFontOfSize:12];
        _priceLab.textColor = hexColor(FF6600);
        _priceLab.textAlignment = NSTextAlignmentCenter;

    }
    return _priceLab;
}

- (UILabel *)originPriceLab {
    if (!_originPriceLab) {
        _originPriceLab = [[UILabel alloc] init];
        _originPriceLab.font = [UIFont systemFontOfSize:12];
        _originPriceLab.textColor = hexColor(AFAFAF);
        _originPriceLab.textAlignment = NSTextAlignmentCenter;
    }
    return _originPriceLab;
}

- (UILabel *)productNumLab {
    if (!_productNumLab) {
        _productNumLab = [[UILabel alloc] init];
        _productNumLab.font = [UIFont systemFontOfSize:14];
        _productNumLab.textAlignment = NSTextAlignmentCenter;
    }
    return _productNumLab;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.brandNameLab];
        [self.contentView addSubview:self.productImg];
        [self.contentView addSubview:self.productNumLab];
        [self.contentView addSubview:self.priceLab];
        [self.contentView addSubview:self.originPriceLab];
    }
    return self;
}
//图片被点击
- (void)productImgClickAction:(UITapGestureRecognizer *)sender{
    if(self.delegate && [self.delegate conformsToProtocol:@protocol(ETHotProductsCellDelegate)]){
        [self.delegate productImgClick:self.indexPath];
    }

}

//产品名点击回调
- (void)brandNameLabClickAction:(UITapGestureRecognizer *)sender{
    
    
    self.cellBrandNameClick(self.indexPath);
    
}

- (void)setModel:(ETHotProductsModel *)model {
    [_productImg sd_setImageWithURL:[NSURL URLWithString:[[model.productPicUri stringByAppendingString:@"@!product-list"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"Default_Image"]];
    _brandNameLab.text = model.brandName;
    _originPriceLab.text = [NSString stringWithFormat:@"零售价:%.2f元",model.originPrice];
    _priceLab.text = [NSString stringWithFormat:@"批发价:%.2f元",model.productPrice];
    _productNumLab.text = model.productNum;
}



- (void)layoutSubviews {
    [super layoutSubviews];
    
      [_productImg mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.left.right.equalTo(self.contentView);
          make.height.equalTo(@(AUTO_MATE_HEIGHT(160)));
      }];
    [_brandNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(_productImg.bottom).offset(5);
        make.height.equalTo(@(AUTO_MATE_HEIGHT(20)));
    }];
    [_productNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(_brandNameLab.bottom).offset(5);
        make.height.equalTo(@(AUTO_MATE_HEIGHT(20)));
    }];
    [_originPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(_productNumLab.bottom).offset(5);
        make.height.equalTo(@(AUTO_MATE_HEIGHT(20)));
    }];
    [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(_originPriceLab.bottom).offset(5);
        make.height.equalTo(@(AUTO_MATE_HEIGHT(20)));
    }];

    
//    _titleLab.frame = CGRectMake(0, CGRectGetMaxY(_titleImg.frame)+5, SCREEN_WIDTH/2-20, 20);
//    _sizeLab.frame = CGRectMake(0, CGRectGetMaxY(_titleLab.frame), SCREEN_WIDTH/2-20, 20);
//    _originPriceLab.frame = CGRectMake(0, CGRectGetMaxY(_sizeLab.frame), SCREEN_WIDTH/2-20, 20);
//    _priceLab.frame = CGRectMake(0, CGRectGetMaxY(_originPriceLab.frame), SCREEN_WIDTH/2-20, 20);
    
    
    
}



@end
