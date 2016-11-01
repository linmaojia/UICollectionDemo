//
//  SVHTTPClient+TaoGoodsDetails.m
//  ETao
//
//  Created by AVGD－Mai on 16/3/4.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient+TaoGoodsDetails.h"

@implementation SVHTTPClient (TaoGoodsDetails)

+ (void)getGoodsDetailsWithProductId:(NSString *)productId target:(id)target callBack:(GoodsDetailsCallback)callback {
    [SVProgressHUD show];
    
    //配置全局请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    
    [[SVHTTPClient sharedClient] GET:[APIGoodsDetails stringByAppendingString:productId] parameters:nil completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if(error) {
            [SVProgressHUD dismiss];
            [[[ETNoneDataView alloc] initWithViewType:NetWorkError errorParameters:response error:error target:target] show];
        }
        else {
            
            
            [SVProgressHUD dismiss];
            ETHotProductsModel *goodsDetailModel = [ETHotProductsModel mj_objectWithKeyValues:(NSDictionary *)response];
            NSLog(@"xxx%@",response);
            callback(goodsDetailModel);
        }
    }];
}

@end
