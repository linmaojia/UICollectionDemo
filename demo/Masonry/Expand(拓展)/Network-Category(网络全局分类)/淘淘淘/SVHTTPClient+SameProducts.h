//
//  SVHTTPClient+SameProducts.h
//  ETao
//
//  Created by LXY on 16/5/17.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient.h"

typedef void (^SameProductsCallback)(NSArray *sameProductsArray);


@interface SVHTTPClient (SameProducts)
/**
 *  @author lin, 16-05-17 16:05:45
 *
 *  请求同系列产品数组
 *
 *  @param target               控制器
 *  @param productId        产品ID
 */
+ (void)getSameProductListWithTarget:(id)target productId:(NSString *)productId CallBack:(SameProductsCallback)sameProductsCallback;

@end
