//
//  ProductModel.h
//  Masonry
//
//  Created by LXY on 16/5/19.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETHotProductsModel.h"
@interface ETHotBandModel : NSObject

@property (nonatomic,strong) NSString *bandTitle;     /**< 标题 */

@property (nonatomic, strong) NSMutableArray<ETHotProductsModel *> *products;    /**< 产品Model */



@end
