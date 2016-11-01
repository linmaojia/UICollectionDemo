//
//  ProductModel.m
//  Masonry
//
//  Created by LXY on 16/5/19.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "ETHotBandModel.h"

@implementation ETHotBandModel

+ (NSDictionary *)objectClassInArray{
    return @{@"products" : [ETHotProductsModel class]};
}

@end
