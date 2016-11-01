//
//  LPXDataView.m
//  练习
//
//  Created by 卢鹏肖 on 16/4/29.
//  Copyright © 2016年 卢鹏肖. All rights reserved.
//

#import "MyTableView.h"

@interface MyTableView () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation MyTableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor yellowColor];
        
    }
    return self;
}
- (void)setIndex:(NSInteger)index{
    _index = index;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"大牛 %ld",self.index];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"---%ld",indexPath.row);
}
@end
