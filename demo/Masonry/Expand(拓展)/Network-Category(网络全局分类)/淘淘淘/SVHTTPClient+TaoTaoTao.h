//
//  SVHTTPClient+TaoTaoTao.h
//  Masonry
//
//  Created by LXY on 16/5/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "SVHTTPClient.h"
#import "ETBuyHomeModel.h"



typedef void(^ETTaoListCallBack)(ETBuyHomeModel *buyHomeModel, NSArray *hotProducts) ;

@interface SVHTTPClient (TaoTaoTao)

//获取淘淘淘数据
+ (void)getTaoListProductsWithTarget:(id)target PageNum:(NSInteger)pageNum isProducts:(BOOL)isProducts CallBack:(ETTaoListCallBack)taoListCallBack;


@end
