//
//  HahaCell.m
//  Masonry
//
//  Created by LXY on 16/5/27.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "HahaCell.h"
#import "ETHotProductsCell.h"
@interface HahaCell()<UICollectionViewDelegate, UICollectionViewDataSource,ETHotProductsCellDelegate>
@property (nonatomic, strong) UICollectionView *hotCollectionView;    /**< 热门产品视图 */

@end
@implementation HahaCell

#pragma mark  - 内部初始化方法
+ (HahaCell *)shoppingCarCellWithTableView:(UITableView *)tableView {
    
    HahaCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (!cell) {
        cell = [[HahaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
        
    }
    return cell;
}
#pragma mark 懒加载控件
- (UICollectionView *)hotCollectionView {
    if (!_hotCollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //上 左 下 右 的距离(整个collection)不包括cell与cell 的距离
        layout.sectionInset = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
        //列与列之间的间距
        layout.minimumInteritemSpacing = 10;
        //行与行之间的间距
        layout.minimumLineSpacing = 10;
        layout.itemSize = CGSizeMake((SCREEN_WIDTH-30)/2, AUTO_MATE_HEIGHT(260));//cell的大小
        _hotCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _hotCollectionView.delegate = self;
        _hotCollectionView.dataSource = self;
        _hotCollectionView.backgroundColor = RGB(247, 249, 250);
        [_hotCollectionView registerClass:[ETHotProductsCell class] forCellWithReuseIdentifier:NSStringFromClass([ETHotProductsCell class])];//注册cell
       
        
    }
    return _hotCollectionView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = hexColor(FAFAFA);
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.hotCollectionView];
        
        
    }
    return self;
}
- (void)setSameDataArray:(NSArray *)sameDataArray{
    _sameDataArray = sameDataArray;
    [self.hotCollectionView reloadData];
}


#pragma mark - CollectionView 代理方法


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _sameDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ETHotProductsCell *cell = [ETHotProductsCell hotProductsCellWithCollectionView:collectionView forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.delegate = self;
    cell.model = _sameDataArray[indexPath.row];
    
    ESWeakSelf;
    //block 回调      //cell的选中按钮点击回调
    cell.cellBrandNameClick = ^(NSIndexPath *index){
        NSLog(@"回调被点击");
        __weakSelf.hotCollectionView.backgroundColor = [UIColor blueColor];
        
    };
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"%ld被点击",indexPath.row);
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_hotCollectionView makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.contentView);
    }];
    
}
@end
