//
//  SVHTTPClient+TaoGoodsDetails.h
//  ETao
//
//  Created by AVGD－Mai on 16/3/4.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient.h"
#import "ETHotProductsModel.h"

//商品数据模型
typedef void (^GoodsDetailsCallback)(ETHotProductsModel *goodsDetailsModel);

@interface SVHTTPClient (TaoGoodsDetails)

/**
 *  @author Mai, 16-03-03 19:03:56
 *
 *  筛选商品列表数据
 *
 *  @param pageNum  页数
 *  @param dataDict URL请求需要的数据字典
 *  @param callback 返回商品列表数组
 */
+ (void)getGoodsDetailsWithProductId:(NSString *)productId target:(id)target callBack:(GoodsDetailsCallback)callback;

@end
