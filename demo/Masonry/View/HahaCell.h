//
//  HahaCell.h
//  Masonry
//
//  Created by LXY on 16/5/27.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HahaCell : UITableViewCell

@property (nonatomic, strong) NSArray *sameDataArray;    /**< 相同产品数组 */

//内部初始化方法
+ (HahaCell *)shoppingCarCellWithTableView:(UITableView *)tableView;
@end
