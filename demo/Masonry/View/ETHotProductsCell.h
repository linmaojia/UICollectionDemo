

#import <UIKit/UIKit.h>
#import "ETHotProductsModel.h"


@protocol ETHotProductsCellDelegate <NSObject>

- (void)productImgClick:(NSIndexPath *)indexPath;    /**< 图片被点击 */

@end

@interface ETHotProductsCell : UICollectionViewCell

//内部初始化方法
+ (ETHotProductsCell *)hotProductsCellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, strong) ETHotProductsModel *model;    /**< 热门数据模型 */

@property (nonatomic, strong) NSIndexPath *indexPath;    /**< indexPath */

@property(nonatomic, assign)id<ETHotProductsCellDelegate>delegate;

@property(nonatomic, copy)void(^cellBrandNameClick)(NSIndexPath *index);   /**< cell选中按钮点击回调 */



@end
