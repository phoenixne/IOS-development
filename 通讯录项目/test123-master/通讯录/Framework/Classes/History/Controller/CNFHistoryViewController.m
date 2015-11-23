//
//  CNFHistoryViewController.m
//  通讯录
//
//  Created by gwp on 15-5-18.
//  Copyright (c) 2015年 cnf. All rights reserved.
//

#import "CNFHistoryViewController.h"
#import "CNFHistory.h"
//#import "CNFAddressBookTool.h"
#import "CNFHistoryCell.h"

@interface CNFHistoryViewController ()
@property (nonatomic, strong) NSArray *historys;
@end

@implementation CNFHistoryViewController
#pragma mark - 懒加载
- (NSArray *)historys{
//    if (!_historys) {
        _historys = [CNFAddressBookTool historys];
//    }
    return _historys;
}



#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource方法
// 每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.historys.count;
}
// 数据源
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CNFHistoryCell *cell = [CNFHistoryCell cellWithTableView:tableView];
    
    cell.history = self.historys[indexPath.row];
    
    return cell;
}

@end
