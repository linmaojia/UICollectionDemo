

#import <UIKit/UIKit.h>

@interface CollectTableCell : UICollectionViewCell

//内部初始化方法
+ (CollectTableCell *)hotProductsCellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic,assign) NSInteger index;

@end
