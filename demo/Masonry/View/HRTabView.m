//
//  HRTabView.m
//  segment
//
//  Created by HR_W on 16/4/22.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "HRTabView.h"
#import "DEMO2_VC.h"
@interface HRTabView ()<UITableViewDelegate, UITableViewDataSource>


@end

@implementation HRTabView

- (void)setNameArray:(NSArray *)nameArray{
    _nameArray = nameArray;
}

- (instancetype)initWithFrame:(CGRect)frame Target:(id)target
{
    self = [super initWithFrame:frame];
    if (self) {
        
            //self.backgroundColor = [UIColor redColor];
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.nameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    cell.textLabel.text = self.nameArray[indexPath.row];
    cell.detailTextLabel.text = @"分别为北京";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //cell.backgroundColor = [UIColor redColor];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"xx--");
    
    self.cellClickAction(indexPath.row);
    
    
}
@end
