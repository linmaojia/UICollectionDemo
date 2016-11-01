//
//  MyShoppingCarController.m
//  Masonry
//
//  Created by LXY on 16/5/13.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "DEMO4_VC.h"
#import "DEMO5_VC.h"
#import "ETHotProductsCell.h"
#import "ETHotProductsModel.h"
#import "ETHotHeadView.h"
#import "SVHTTPClient+TaoTaoTao.h"

@interface DEMO4_VC ()<UICollectionViewDelegate, UICollectionViewDataSource, ETHotProductsCellDelegate, ETHotHeadViewDelegete,ETNoneDataViewDelegate>
{
    NSInteger _pageNum;
}
@property (nonatomic, strong) UICollectionView *hotCollectionView;    /**< 热门产品视图 */
@property (nonatomic, strong) NSMutableArray *hotDataArray;    /**< 热门产品产品数组 */
@property (nonatomic, strong) ETHotHeadView *headerView;    /**< 热门产品头部 */

@end

@implementation DEMO4_VC

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
        [_hotCollectionView registerClass:[ETHotHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([ETHotHeadView class])];//注册头部
        
        //下拉刷新
         //设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
        _hotCollectionView.mj_header = header;
        
        //上拉加载
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        _hotCollectionView.mj_footer = footer;
        _hotCollectionView.mj_footer.hidden = YES;
        
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
    _pageNum = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"原始collection";
    
}

- (void)loadMoreData{
    _pageNum++;
    ESWeakSelf;
    [SVHTTPClient getTaoListProductsWithTarget:self PageNum:_pageNum isProducts:YES CallBack:^(ETBuyHomeModel *buyHomeModel, NSArray *hotProducts) {
        NSLog(@"--%@",buyHomeModel);
        [__weakSelf.hotCollectionView.mj_footer endRefreshing];
        [__weakSelf.hotDataArray addObjectsFromArray:hotProducts];
        [__weakSelf.hotCollectionView reloadData];
    }];
}
#pragma mark - 请求初始数据
- (void)requestData {
    
    // APIGetTTT  //淘淘淘首页
    ////淘淘淘爆款推荐  APIGetTTTProducts
    ESWeakSelf
    [SVHTTPClient getTaoListProductsWithTarget:self PageNum:1 isProducts:NO CallBack:^(ETBuyHomeModel *buyHomeModel, NSArray *hotProducts) {
        NSLog(@"--%@",buyHomeModel);
        __weakSelf.hotCollectionView.mj_footer.hidden = NO;
        __weakSelf.headerView.model = buyHomeModel;
        __weakSelf.hotDataArray = [NSMutableArray arrayWithArray:hotProducts];
        [__weakSelf.hotCollectionView reloadData];
    }];
     [self.hotCollectionView.mj_header endRefreshing];
 
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
    
    ETHotProductsModel *model = self.hotDataArray[indexPath.row];
    
    DEMO5_VC *demo5 = [[DEMO5_VC alloc]init];
    demo5.productId = model.productId;
    [self.navigationController pushViewController:demo5 animated:YES];
    NSLog(@"%@被点击",model.productId);
    
}

//headView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    //头部
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader ){
        
        self.headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([ETHotHeadView class]) forIndexPath:indexPath];
        self.headerView.delegate = self;
        reusableview = self.headerView;
    }
    
    return reusableview;
}

//定义headView的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, AUTO_MATE_WIDTH(45)*2+45+AUTO_MATE_HEIGHT(100)+40);
}


#pragma mark - ETHotHeadView 代理方法

- (void)imgClickWithDcid:(NSString *)dcId{
    NSLog(@"dcId = %@",dcId);
}

#pragma mark - ETHotProductsCell 代理方法
//商品图片被点击
- (void)productImgClick:(NSIndexPath *)indexPath{
    
    NSLog(@"图片%ld被点击",indexPath.row);
}

#pragma mark - ETNoneDataView 代理方法
//重新加载按钮
- (void)BtnClickAction{
    [self requestData];//加载数据
}

#pragma mark - 控件布局
- (void)layoutSubviews {
    
    [self.view addSubview:self.hotCollectionView];
    
    
    [_hotCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);//等同于父视图
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
