//
//  SVHTTPClient+KnowETao.h
//  ETao
//
//  Created by AVGD—JK on 16/4/7.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient.h"



//版本新界面图片数组
typedef void (^RequestNewFeatureImagesArrayCallback)(NSArray *imagesArray);

@interface SVHTTPClient (KnowETao)



/**
 *  @author Kim, 16-02-29 18:02:25
 *
 *  请求版本新界面图片数组
 
 */
+ (void)requestNewFeatureImagesArrayWithCallback:(RequestNewFeatureImagesArrayCallback)callBack;

@end
