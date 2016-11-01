//
//  MyShoppingCarController.m
//  Masonry
//
//  Created by LXY on 16/5/13.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "DEMO6_VC.h"
#import "ETHotProductsCell.h"
#import "ETHotProductsModel.h"
#import "ETHotProductsHeaderView.h"

@interface DEMO6_VC ()<UICollectionViewDelegate, UICollectionViewDataSource, ETHotProductsCellDelegate>
{
}
@property (nonatomic, strong) UICollectionView *hotCollectionView;    /**< 热门产品视图 */
@property (nonatomic, strong) NSMutableArray *hotDataArray;    /**< 热门产品产品数组 */
@end

@implementation DEMO6_VC

#pragma mark 懒加载控件
- (UICollectionView *)hotCollectionView {
    if (!_hotCollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //上 左 下 右 的距离(整个collection)不包括cell与cell 的距离
        layout.sectionInset = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
        layout.minimumInteritemSpacing = 10;//列与列之间的间距
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;//水平滑动
        layout.itemSize = CGSizeMake((SCREEN_WIDTH-30)/2, AUTO_MATE_HEIGHT(260));//cell的大小
        _hotCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _hotCollectionView.delegate = self;
        _hotCollectionView.dataSource = self;
        _hotCollectionView.backgroundColor = RGB(247, 249, 250);
        [_hotCollectionView registerClass:[ETHotProductsCell class] forCellWithReuseIdentifier:NSStringFromClass([ETHotProductsCell class])];//注册cell
        
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
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"原始collection";
    
}

#pragma mark - 请求初始数据
- (void)requestData {
    
    //本地请求数据
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ShopData1" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:plistPath];
    NSArray *shoppingCarListArray = [ETHotProductsModel mj_objectArrayWithKeyValuesArray:array];//转模型
    self.hotDataArray = [NSMutableArray arrayWithArray:shoppingCarListArray];
    [self.hotCollectionView reloadData];//刷新
    
}

#pragma mark - CollectionView 代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.hotDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ETHotProductsCell *cell = [ETHotProductsCell hotProductsCellWithCollectionView:collectionView forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.delegate = self;
    cell.model = self.hotDataArray[indexPath.row];
    
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


#pragma mark - ETHotProductsCell 代理方法
//商品图片被点击
- (void)productImgClick:(NSIndexPath *)indexPath{
    
    NSLog(@"图片%ld被点击",indexPath.row);
}


#pragma mark - 控件布局
- (void)layoutSubviews {
    
    [self.view addSubview:self.hotCollectionView];
    
    
    [_hotCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.right.left.equalTo(self.view);
        make.height.equalTo(@(280));
        
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
