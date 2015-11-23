//
//  CNFBlackListController.m
//  通讯录
//
//  Created by gwp on 15-5-21.
//  Copyright (c) 2015年 cnf. All rights reserved.
//

#import "CNFBlackListController.h"
#import "CNFContactListController.h"
#import "CNFNavigationController.h"

@interface CNFBlackListController ()

@end

@implementation CNFBlackListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"黑名单";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addContact)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addContact{
    CNFContactListController *contactVc = [[CNFContactListController alloc] init];
    
    CNFNavigationController *nav = [[CNFNavigationController alloc] initWithRootViewController:contactVc];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource方法
// 每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
// 数据源
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"blackList";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = @"hei";
    
    return cell;
}

@end
