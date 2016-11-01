//
//  ProductModel.h
//  Masonry
//
//  Created by LXY on 16/5/19.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETHotProductsModel : NSObject

@property (nonatomic,strong) NSString *brandName;     /**< 品牌名 */

@property (nonatomic,assign) CGFloat originPrice;     /**< 原价 */

@property (nonatomic,strong) NSString *productNum;     /**< 产品编号 */

@property (nonatomic,strong) NSString *productPicUri;     /**< 产品图片 */

@property (nonatomic,assign) CGFloat productPrice;     /**< 批发价 */

@property (nonatomic, strong) NSString *productId;    /**< 产品id */

@property (nonatomic,assign) BOOL isShow;// 组的状态，yes显示组，no不显示组


@end
