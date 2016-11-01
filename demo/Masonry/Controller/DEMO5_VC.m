//
//  MyShoppingCarController.m
//  Masonry
//
//  Created by LXY on 16/5/13.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "DEMO5_VC.h"
#import "SVHTTPClient+SameProducts.h"
#import "SVHTTPClient+TaoGoodsDetails.h"
#import "HahaCell.h"
#import "ETHotProductsModel.h"
#import "ETHotProductsModel.h"
@interface DEMO5_VC ()<UITableViewDelegate, UITableViewDataSource>
{
}
@property (nonatomic, strong) UITableView *tableView;    /**< RootTableView */
@property (nonatomic, strong) NSMutableArray *dataArray;    /**< 数据数组 */
@property (nonatomic, strong) NSArray *sameDataArray;    /**< 相同产品数组 */
@property (nonatomic, strong) ETHotProductsModel *goodsDetailModel;    /**< 商品详情数据 */

@property (nonatomic, strong) NSArray *titleArray;    /**< 规格数组 */

@end

@implementation DEMO5_VC

#pragma mark 懒加载控件
- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        
    }
    return _dataArray;
}
- (NSArray *)titleArray {
    
    if (!_titleArray) {
        _titleArray = @[@"宽度(W): ",@"高度(H): ",@"深度(D): ",@"光源数量: ",@"适用空间: ",@"风格: ",@"颜色: ",@"材质: "];
        
    }
    return _titleArray;
}
- (NSArray *)sameDataArray {
    
    if (!_sameDataArray) {
        _sameDataArray = [NSArray array];
        
    }
    return _sameDataArray;
}
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线为none
        _tableView.backgroundColor = RGB(250, 250, 250);
    }
    return _tableView;
}
#pragma mark - 系统方法
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];//设置导航栏
    [self requestData];//请求数据
    
    
    
}

#pragma mark - 设置导航栏
- (void)setNav {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"原始collection";
    
}

#pragma mark - 请求初始数据
- (void)requestData {
    [self getGoodsDetailData];//请求cell数据
    [self getSameProductsDataArray];//获取相同产品
    //    //本地请求数据
    //    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"shoppingCart" ofType:@"plist"];
    //    NSArray *array = [NSArray arrayWithContentsOfFile:plistPath];
    //    NSArray *shoppingCarListArray = [MJShoppingCarModel mj_objectArrayWithKeyValuesArray:array];//转模型
    //    self.dataArray = [NSMutableArray arrayWithArray:shoppingCarListArray];
    
}

- (void)getGoodsDetailData {
    ESWeakSelf;
    [SVHTTPClient getGoodsDetailsWithProductId:self.productId target:self callBack:^(ETHotProductsModel *goodsDetailsModel) {
        
        __weakSelf.goodsDetailModel = goodsDetailsModel;
        
        NSLog(@"-我是--%@",goodsDetailsModel);
        [__weakSelf layoutSubviews];//控件布局
        
    }];
}

- (void)getSameProductsDataArray
{
    ESWeakSelf;
    [SVHTTPClient getSameProductListWithTarget:self productId:self.productId CallBack:^(NSArray *sameProductsArray) {
        
        __weakSelf.sameDataArray = sameProductsArray;
        [__weakSelf.tableView reloadData];
        
    }];
    
    
}
#pragma mark - CollectionView 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(section == 0){
        
        int row = self.goodsDetailModel.isShow? 8:0;
        
        return  row;
    }else{
        return 1;
    }
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0){
        
        return AUTO_MATE_HEIGHT(30);
        
    }else{
        
        int row = (int)((self.sameDataArray.count * 0.5) + 0.5);
        CGFloat height = (AUTO_MATE_HEIGHT(260)+10)*row +10;
        return height;
    }
    
    
    
}

//Cell显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0){
        static NSString *cellIden = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellIden];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone; //选中cell时无色
        cell.textLabel.text = [NSString stringWithFormat:@"%@%ld",self.titleArray[indexPath.row],indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.textColor = [UIColor colorWithRed:0.540  green:0.564  blue:0.589 alpha:1];
        return cell;
    }else{
        
        HahaCell *cell = [HahaCell shoppingCarCellWithTableView:tableView];
        
        cell.sameDataArray = self.sameDataArray;
        
        return cell;
        
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"---%ld",indexPath.row);
}

//区头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return AUTO_MATE_HEIGHT(50);
}
//区头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0 , 0, SCREEN_WIDTH, 50);
    [btn setTitleColor:[UIColor blackColor] forState:0];
    btn.tag = section+100;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor grayColor]];
    NSString *title = section? @"产品规格" : @"同系列品" ;
    [btn setTitle:title forState:UIControlStateNormal];
    [headerView addSubview:btn];
    return headerView;
}


- (void) btnClick:(UIButton *)btn
{
    
    if(btn.tag ==100 ){
        self.goodsDetailModel.isShow = !self.goodsDetailModel.isShow;
    }
    
    // 刷新点击的组标题，动画使用卡片
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - 控件布局
- (void)layoutSubviews {
    
    [self.view addSubview:self.tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
