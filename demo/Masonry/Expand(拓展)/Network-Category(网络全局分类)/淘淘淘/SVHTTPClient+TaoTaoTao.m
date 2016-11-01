//
//  SVHTTPClient+TaoTaoTao.m
//  Masonry
//
//  Created by LXY on 16/5/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "SVHTTPClient+TaoTaoTao.h"

@implementation SVHTTPClient (TaoTaoTao)

+ (void)getTaoListProductsWithTarget:(id)target PageNum:(NSInteger)pageNum isProducts:(BOOL)isProducts CallBack:(ETTaoListCallBack)taoListCallBack{
    if(!isProducts){
        [SVProgressHUD show];
        [[[SVHTTPClient alloc]init] getTaoProductsListWithTarget:target CallBack:taoListCallBack];
    }else{
        
        [[[SVHTTPClient alloc]init] getTaoListProductsWithPageNum:pageNum Model:nil CallBack:taoListCallBack];
    }
}
//获取淘淘类型
- (void)getTaoProductsListWithTarget:(id)target CallBack:(ETTaoListCallBack)taoListCallBack{
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    NSLog(@"-----xx--:%@",APIGetTTT);
    [[SVHTTPClient sharedClient] GET:APIGetTTT parameters:nil completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if(error){
            NSLog(@"---%@",error);
            [SVProgressHUD dismiss];
            [[[ETNoneDataView alloc] initWithViewType:NetWorkError errorParameters:response error:error target:target] show];
        }else{
            
            [[[SVHTTPClient alloc]init] getTaoListProductsWithPageNum:1 Model:[ETBuyHomeModel mj_objectWithKeyValues:response] CallBack:taoListCallBack];
        }
    }];
}
//获取爆款数据
- (void)getTaoListProductsWithPageNum:(NSInteger)pageNum Model:(ETBuyHomeModel *)Model CallBack:(ETTaoListCallBack)taoListCallBack{
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    
    [[SVHTTPClient sharedClient] GET:[APIGetTTTProducts stringByAppendingString:[NSString stringWithFormat:@"?rowsPerPage=10&pageNumber=%ld",(long)pageNum]]  parameters:nil completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if(error)
        {
            [SVProgressHUD showWithStatus:@""];
        }
        else
        {
            [SVProgressHUD dismiss];
            NSArray *hotProductsArray = [ETHotProductsModel mj_objectArrayWithKeyValuesArray:(NSArray *)response];
            taoListCallBack(Model,hotProductsArray);
        }
        
    }];
}
@end
