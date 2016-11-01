

#import <UIKit/UIKit.h>

@interface CollectMyCell : UICollectionViewCell

//内部初始化方法
+ (CollectMyCell *)hotProductsCellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, strong) NSString *name; 
@property (nonatomic, strong) UIColor *color;



@end
