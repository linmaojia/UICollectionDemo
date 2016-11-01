//
//  MyShoppingCarController.m
//  Masonry
//
//  Created by LXY on 16/5/13.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "DEMO8_VC.h"
#import "CollectTableCell.h"

@interface DEMO8_VC ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
}
@property (nonatomic, strong) UICollectionView *hotCollectionView;    /**< 热门产品视图 */
@property (nonatomic, strong) NSMutableArray *hotDataArray;    /**< 热门产品产品数组 */
@end

@implementation DEMO8_VC

#pragma mark 懒加载控件
- (UICollectionView *)hotCollectionView {
    if (!_hotCollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 0; //列与列之间的间距
        layout.minimumLineSpacing = 0;//行与行之间的间距
        layout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-64);//cell的大小
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;//设置水平滚动
        _hotCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _hotCollectionView.delegate = self;
        _hotCollectionView.dataSource = self;
        _hotCollectionView.backgroundColor = [UIColor grayColor];
        _hotCollectionView.bounces = NO;//关闭弹簧
        _hotCollectionView.pagingEnabled = YES;//设置分页
        [_hotCollectionView registerClass:[CollectTableCell class] forCellWithReuseIdentifier:NSStringFromClass([CollectTableCell class])];//注册cell
        
    }
    return _hotCollectionView;
}
- (NSMutableArray *)hotDataArray {
    if (!_hotDataArray) {
        _hotDataArray = [NSMutableArray array];
    }
    return _hotDataArray;
}


#pragma mark - 系统方法
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self requestData];//请求数据
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];//设置导航栏
    [self layoutSubviews];//控件布局
    
}

#pragma mark - 设置导航栏
- (void)setNav {
    
    self.view.backgroundColor = RGB(247, 249, 250);
    self.navigationItem.title = @"原始collection";
    
}

#pragma mark - 请求初始数据
- (void)requestData {
   
    
}

#pragma mark - CollectionView 代理方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectTableCell *cell = [CollectTableCell hotProductsCellWithCollectionView:collectionView forIndexPath:indexPath];
    cell.index = indexPath.row;
  
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"%ld被点击",indexPath.row);
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger page = (NSInteger)offsetX / self.hotCollectionView.bounds.size.width;
    
    NSLog(@"我是第%ld个",(long)page);
    
 
}

#pragma mark - 控件布局
- (void)layoutSubviews {
    
    [self.view addSubview:self.hotCollectionView];
    
    
    [_hotCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
