//
//  CNFSettingViewController.m
//  通讯录
//
//  Created by gwp on 15-5-18.
//  Copyright (c) 2015年 cnf. All rights reserved.
//

#import "CNFSettingViewController.h"
#import "CNFBlackListController.h"
#import "CNFWhiteListController.h"

@interface CNFSettingViewController ()
/** 每一个“设置”的cell的文字 */
@property (nonatomic, strong) NSArray *item;
@end

@implementation CNFSettingViewController
#pragma mark - 懒加载
- (NSArray *)item{
    if (!_item) {
        _item = @[@"黑名单", @"白名单"];
    }
    return _item;
}


#pragma mark - 初始化方法
- (instancetype)init{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource方法
// 组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
// 每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
// 数据源
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"setting";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = self.item[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[[CNFBlackListController alloc] init] animated:YES];
    }else if (indexPath.row == 1) {
        [self.navigationController pushViewController:[[CNFWhiteListController alloc] init] animated:YES];
    }
}
@end
