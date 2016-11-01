//
//  ETCollectBrandHeaderView.h
//  ETao
//
//  Created by AVGD－Mai on 16/4/6.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETBuyHomeModel.h"

@protocol ETHotHeadViewDelegete <NSObject>

- (void)imgClickWithDcid:(NSString *)dcId;

@end

@interface ETHotHeadView : UICollectionReusableView


@property (nonatomic, strong) UILabel *titleLab;    /**< 标题 */
@property (nonatomic,strong) ETBuyHomeModel *model;
@property (nonatomic,assign) id<ETHotHeadViewDelegete>delegate;
@end
