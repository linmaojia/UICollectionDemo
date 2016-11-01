//
//  ETNoneDataView.h
//  NoneDataView
//
//  Created by 麥展毅 on 16/3/26.
//  Copyright © 2016年 麥展毅. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  显示错误视图类型
 */
typedef NS_ENUM(NSInteger , ViewType) {
    NetWorkError,//网络错误
};

@protocol ETNoneDataViewDelegate <NSObject>

- (void)BtnClickAction;

@end

@interface ETNoneDataView : UIView
@property (nonatomic,assign) id<ETNoneDataViewDelegate>delegate;


- (instancetype)initWithViewType:(ViewType)viewType errorParameters:(id)parameters error:(NSError *)error target:(id)target;

- (void)show;
@end






