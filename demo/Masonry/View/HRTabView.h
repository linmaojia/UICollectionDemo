//
//  HRTabView.h
//  segment
//
//  Created by HR_W on 16/4/22.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface HRTabView : UITableView


- (instancetype)initWithFrame:(CGRect)frame Target:(id)target;

//block 点击回调
@property (nonatomic,copy) void(^cellClickAction)(NSInteger indexPath);


//数组
@property (nonatomic,strong) NSArray *nameArray;

@end
