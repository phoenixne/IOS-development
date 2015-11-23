//
//  CNFContactListController.m
//  通讯录
//
//  Created by gwp on 15-5-21.
//  Copyright (c) 2015年 cnf. All rights reserved.
//

#import "CNFContactListController.h"
#import "CNFPerson.h"
#import "CNFContactCell.h"

@interface CNFContactListController ()

/** 普通联系人 */
@property (nonatomic, strong) NSArray *normalPeoples;

/** 选中的联系人 */
@property (nonatomic, strong) NSMutableArray *selectPersons;
@end

@implementation CNFContactListController
#pragma mark - 懒加载
- (NSMutableArray *)selectIndexs{
    if (!_selectPersons) {
        _selectPersons = [[NSMutableArray alloc] init];
    }
    return _selectPersons;
}


- (NSArray *)normalPeoples{
    if (!_normalPeoples) {
        NSMutableArray *temp = [NSMutableArray array];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSArray *allPerson = [[CNFAddressBookTool peoples] valueForKey:@"fullName"];
            
            /** 剔除黑名单中的联系人 */
            for (NSString *fullName in allPerson) {
                if ([[CNFAddressBookTool blackPersons] containsObject:fullName]) continue;
                
                CNFPerson *person = [[CNFPerson alloc] init];
                person.fullName = fullName;
                [temp addObject:person];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                [MBProgressHUD  hideHUD];
            });
        });
        _normalPeoples = temp;
    }
    return _normalPeoples;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [MBProgressHUD showMessage:@"正在加载联系人..."];
    
    [self addObserver:self forKeyPath:@"selectPersons.count" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"selectPersons.count"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"selectPersons.count"]) {
        if (self.selectPersons.count == 0) {
            self.navigationItem.rightBarButtonItem.enabled = NO;
            self.navigationItem.rightBarButtonItem.title = @"确定";
        }else{
            self.navigationItem.rightBarButtonItem.enabled = YES;
            self.navigationItem.rightBarButtonItem.title = [NSString stringWithFormat:@"确定(%ld)", self.selectPersons.count];
        }
    }
}

- (void)setupNav{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(exit)];
    UIBarButtonItem *right= [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(insertBlack)];
    right.enabled = NO;
    self.navigationItem.rightBarButtonItem = right;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertBlack{
    
}

- (void)exit{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UITableViewDataSource方法
// 每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.normalPeoples.count;
}
// 数据源
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CNFContactCell *cell = [CNFContactCell cellWithTableView:tableView];
    
    CNFPerson *person = self.normalPeoples[indexPath.row];
    cell.person = person;
    if (person.mark) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
//    GWPLog(@"%ld", );
    
    return cell;
}

#pragma mark - UITableViewDelegate
/**
 *  选中某行时会调用
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CNFPerson *person = self.normalPeoples[indexPath.row];
    person.mark = !person.mark;
    
    if (person.mark) {
        [self.selectPersons addObject:person];
    }else{
        [self.selectPersons removeObject:person];
    }
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
@end
