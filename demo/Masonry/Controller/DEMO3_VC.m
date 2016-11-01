//
//  DEMO1_VC.m
//  Masonry
//
//  Created by LXY on 16/5/11.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "DEMO3_VC.h"
#import "YZGNewProductCollectionViewCell.h"
#import "YZGNewProductFooter.h"
#import "YZGNewProductHeader.h"
#import "ETHotProductsModel.h"
static NSString * const reuseIdentifier = @"Cell";

@interface DEMO3_VC ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
}
@property (nonatomic, strong) UICollectionView *hotCollectionView;    /**< 热门产品视图 */
@property (nonatomic, strong) NSMutableArray *productArray;    /**< 热门产品产品数组 */
@property (nonatomic, strong) UIButton *topView;      /**< 顶部图片 */

@end

@implementation DEMO3_VC


#pragma mark 懒加载控件
- (UIButton *)topView
{
    if (!_topView)
    {
        _topView = [UIButton buttonWithType:UIButtonTypeCustom];
        _topView.frame = CGRectMake(0, -73, SCREEN_WIDTH, 73);
        [_topView setBackgroundImage:[UIImage imageNamed:@"banner"] forState:0];
    }
    return _topView;
    
}
- (UICollectionView *)hotCollectionView {
    if (!_hotCollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.itemSize = CGSizeMake(SCREEN_WIDTH/2, SCREEN_WIDTH/2);//cell的大小
        _hotCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _hotCollectionView.delegate = self;
        _hotCollectionView.dataSource = self;
        _hotCollectionView.backgroundColor = RGB(247, 249, 250);
        [_hotCollectionView registerClass:[YZGNewProductCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        [_hotCollectionView registerClass:[YZGNewProductHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
        [_hotCollectionView registerClass:[YZGNewProductFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
        _hotCollectionView.contentInset = UIEdgeInsetsMake(73, 0, 0, 0);//对于整个UICollectView
        
        [_hotCollectionView addSubview:self.topView];
        
    }
    return _hotCollectionView;
}


#pragma mark - 系统方法
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutSubviews];//控件布局
}
#pragma mark **************** <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
   
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YZGNewProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.indexPath = indexPath;
    
    NSLog(@"---%ld",indexPath.row);
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        YZGNewProductFooter *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footerView" forIndexPath:indexPath];
        [footerView setMoreProductButtonAction:^{
           
        }];
        return footerView;
    }else
    {
        YZGNewProductHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
       
        return headerView;
    }
}

//定义headView的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, 120);
}



//定义footView的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, 50);
}
#pragma mark - 控件布局
- (void)layoutSubviews
{
    [self.view addSubview:self.hotCollectionView];
    
    [_hotCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);//等同于父视图
    }];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
