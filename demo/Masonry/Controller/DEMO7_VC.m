//
//  MyShoppingCarController.m
//  Masonry
//
//  Created by LXY on 16/5/13.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "DEMO7_VC.h"
#import "CollectMyCell.h"

@interface DEMO7_VC ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
}
@property (nonatomic, strong) UICollectionView *hotCollectionView;    /**< 热门产品视图 */
@property (nonatomic, strong) NSMutableArray *hotDataArray;    /**< 热门产品产品数组 */
@property (nonatomic, strong) NSMutableArray *collorArray;
@end

@implementation DEMO7_VC

#pragma mark 懒加载控件
- (UICollectionView *)hotCollectionView {
    if (!_hotCollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //上 左 下 右 的距离(整个collection)不包括cell与cell 的距离
        layout.sectionInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
        layout.minimumInteritemSpacing = 1;//列与列之间的间距
        layout.minimumLineSpacing = 1;//行与行之间的间距
        layout.itemSize = CGSizeMake((SCREEN_WIDTH-3)/4, (SCREEN_WIDTH-3)/4);//cell的大小
        _hotCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _hotCollectionView.delegate = self;
        _hotCollectionView.dataSource = self;
        _hotCollectionView.backgroundColor = [UIColor grayColor];
        [_hotCollectionView registerClass:[CollectMyCell class] forCellWithReuseIdentifier:NSStringFromClass([CollectMyCell class])];//注册cell
        
        
        //此处给其增加长按手势，用此手势触发cell移动效果
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlelongGesture:)];
        [_hotCollectionView addGestureRecognizer:longGesture];
        
    }
    return _hotCollectionView;
}
- (NSMutableArray *)hotDataArray {
    if (!_hotDataArray) {
        _hotDataArray = [NSMutableArray array];
        for(int i = 0;i<4;i++){
            [_hotDataArray addObject:[NSString stringWithFormat:@"我是%d个",i]];
        }
    }
    return _hotDataArray;
}
- (NSMutableArray *)collorArray {
    if (!_collorArray) {
        _collorArray = [NSMutableArray array];
        for(int i = 0;i<4;i++){
            [_collorArray addObject:[UIColor grayColor]];
             [_collorArray addObject:[UIColor yellowColor]];
             [_collorArray addObject:[UIColor redColor]];
             [_collorArray addObject:[UIColor blueColor]];
        }
    }
    return _collorArray;
}

#pragma mark - 系统方法
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
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



#pragma mark - CollectionView 代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.hotDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectMyCell *cell = [CollectMyCell hotProductsCellWithCollectionView:collectionView forIndexPath:indexPath];
    cell.name = self.hotDataArray[indexPath.row];
    cell.color = self.collorArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"%ld被点击",indexPath.row);
    
}
- (void)handlelongGesture:(UILongPressGestureRecognizer *)longGesture {
    //判断手势状态
    switch (longGesture.state) {
        case UIGestureRecognizerStateBegan:{
            //判断手势落点位置是否在路径上
            NSIndexPath *indexPath = [self.hotCollectionView indexPathForItemAtPoint:[longGesture locationInView:self.hotCollectionView]];
            if (indexPath == nil) {
                break;
            }
            //在路径上则开始移动该路径上的cell
            [self.hotCollectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
        }
            break;
        case UIGestureRecognizerStateChanged:
            //移动过程当中随时更新cell位置
            [self.hotCollectionView updateInteractiveMovementTargetPosition:[longGesture locationInView:self.hotCollectionView]];
            break;
        case UIGestureRecognizerStateEnded:
            //移动结束后关闭cell移动
            [self.hotCollectionView endInteractiveMovement];
            break;
        default:
            [self.hotCollectionView cancelInteractiveMovement];
            break;
    }
}
#pragma mark -
//返回YES允许其item移动
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    
     id objc = self.collorArray[sourceIndexPath.row];//取出源item数据
    
    [self.collorArray removeObject:objc];//从资源数组中移除该数据
    [self.collorArray insertObject:objc atIndex:destinationIndexPath.item];//添加
}

#pragma mark - 控件布局
- (void)layoutSubviews {
    
    [self.view addSubview:self.hotCollectionView];
    
    
    [_hotCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@((SCREEN_WIDTH-3)/4));

    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
