//
//  SVHTTPClient+SameProducts.m
//  ETao
//
//  Created by LXY on 16/5/17.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient+SameProducts.h"
#import "ETHotProductsModel.h"
@implementation SVHTTPClient (SameProducts)

+ (void)getSameProductListWithTarget:(id)target productId:(NSString *)productId CallBack:(SameProductsCallback)sameProductsCallback{
    
    //配置全局请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    
    [[SVHTTPClient sharedClient] GET:[APISameProducts stringByAppendingString:productId] parameters:nil completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if(error) {
        }
        else
        {
            
            NSArray *dataArray = [ETHotProductsModel mj_objectArrayWithKeyValuesArray:(NSArray *)response];
            
            sameProductsCallback(dataArray);
        }
    }];
}

@end
