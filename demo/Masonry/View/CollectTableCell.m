

#import "CollectTableCell.h"
#import "MyTableView.h"
#import "myView.h"
#import "HRTabView.h"
@interface CollectTableCell ()
@property (nonatomic, strong) HRTabView *tableView1;
@end


@implementation CollectTableCell

+ (CollectTableCell *)hotProductsCellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath{
    
    CollectTableCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[CollectTableCell alloc] init];
    }
    return cell;
    
}



- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
//         MyTableView *myTable = [[MyTableView alloc] initWithFrame:self.contentView.frame];
//         [self.contentView addSubview:myTable];
        
        NSArray * _nameArray = @[@"Table-分区-左滑",@"Table-个人设置-Grouped",@"清除缓存SDWebImage",@"Scrollow-Table-没完",@"Table-下拉背景拉长",@"Table-下拉背景变大",@"Table-下拉背景，头像变大",@"Table-下拉背景，头像变大",@"Table-下拉背景，头像变大",@"Table-下拉背景，头像变大",@"Table-下拉背景，头像变大",@"Table-下拉背景，头像变大"];
        _tableView1=[[HRTabView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH,0, SCREEN_WIDTH, SCREEN_HEIGHT-64) Target:self];
        _tableView1.nameArray = _nameArray;
        [self.contentView addSubview:_tableView1];
        
    }
    return self;
}

- (void)setIndex:(NSInteger)index{
    _index = index;
    
   
    NSLog(@"%-----ld",_index);
}




@end
