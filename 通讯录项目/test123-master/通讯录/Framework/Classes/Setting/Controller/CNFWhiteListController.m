//
//  CNFWhiteListController.m
//  通讯录
//
//  Created by gwp on 15-5-21.
//  Copyright (c) 2015年 cnf. All rights reserved.
//

#import "CNFWhiteListController.h"

@interface CNFWhiteListController ()

@end

@implementation CNFWhiteListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"白名单";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource方法
// 每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
// 数据源
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"whiteList";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = @"bai";
    
    return cell;
}
@end
