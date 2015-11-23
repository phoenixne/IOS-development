//
//  CNFGroupViewController.m
//  通讯录
//
//  Created by gwp on 15-5-18.
//  Copyright (c) 2015年 cnf. All rights reserved.
//

#import "CNFGroupViewController.h"
//#import "CNFAddressBookTool.h"
#import "CNFPersonViewCell.h"
#import "CNFGroupHeaderView.h"
#import "CNFPeopleGroup.h"
#import "CNFPerson.h"
#import "CNFNewGroupViewController.h"
#import "CNFNavigationController.h"
#import "CNFArchiveTool.h"


@interface CNFGroupViewController ()<CNFHeaderViewDelegate>
/**
 *  里面存放着组模型
 */
@property (nonatomic , strong) NSMutableArray *groups;

/**
 *  未分组的组别里面存放的CNFPerson模型
 */
@property (nonatomic , strong) CNFPeopleGroup *unGrouped;
@end

@implementation CNFGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.groups.count == 0) {
        [self initApp];
    }
    
    // 设置每行Cell之间不要线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 每一组头部控件的高度
    self.tableView.sectionHeaderHeight = 60;
    
    // 监听通知
    [GWPNotificationCenter addObserver:self selector:@selector(createNewGroup:) name:CNFDidCreateNewGroupNotification object:nil];
    
    // 设置左边标题
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemCancel) target:self action:@selector(cancelBtnClick)];
    
    // 设置右边标题
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(addBtnClick)];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [CNFArchiveTool archiveRootObject:self.groups];
}

- (void)dealloc
{
    [GWPNotificationCenter removeObserver:self];
}

// 第一进入程序,初始化
- (void)initApp
{
    CNFPeopleGroup *defGroup = [[CNFPeopleGroup alloc] init];
    
    // 异步完成(联系人)数据加载
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        defGroup.persons = (NSMutableArray *)[CNFAddressBookTool peoples];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            defGroup.name = @"未分组";
            defGroup.opened = YES;
            for (CNFPerson *p in defGroup.persons) {
                // 设置默认组别为0
                p.groupType = 0;
            }
            [self.groups addObject:defGroup];
            [self.tableView reloadData];
            // 存档
            [CNFArchiveTool archiveRootObject:self.groups];
        });
    });
}

#pragma mark 懒加载
- (NSArray *)groups
{
    if (!_groups) {
        // 1.读取沙盒中的组模型数组
        NSArray *array = [CNFArchiveTool unarchiveObj];
        
        // 2.赋值
        _groups = [NSMutableArray arrayWithArray:array];
    }
    return _groups;
}

- (CNFPeopleGroup *)unGrouped
{
    if (!_unGrouped) {
        for (CNFPeopleGroup *g in self.groups) {
            if ([g.name isEqualToString:@"未分组"]) {
                _unGrouped = g;
            }
        }
    }
    return _unGrouped;
}


#pragma mark - 方法监听
- (void)addBtnClick
{
    CNFNavigationController *Nav = [[CNFNavigationController alloc] initWithRootViewController:[[CNFNewGroupViewController alloc] initWithPersons:self.unGrouped.persons]];
    [self presentViewController:Nav animated:YES completion:nil];
}

/**
 *  监听到新建分组
 *
 *  @param info 传回新建分组中包含哪些人
 */
- (void)createNewGroup:(NSNotification *)info
{
    // 1.取出传回的数组,和组名称
    NSString *name = info.userInfo[@"name"];
    NSArray *persons = info.userInfo[@"persons"];
    // 遍历,把组类型改成目前最大类型数加1
    NSInteger currentMaxGroupTypeInfo = self.groups.count;
    for (CNFPerson *person1 in persons) {
        NSString *userName = person1.fullName;
        for (CNFPerson *person0 in self.unGrouped.persons) {
            if ([person0.fullName isEqualToString:userName]) {
                person0.groupType = person1.groupType = currentMaxGroupTypeInfo + 1;
            }
        }
    }
    
    // 2.加到总数组中进行归档
    // 2.1把新建组包装成组模型
    CNFPeopleGroup *g = [[CNFPeopleGroup alloc] init];
    g.persons = [NSMutableArray arrayWithArray:persons];
    g.name = name;
    // 2.2把组模型添加到总数组
    [self.groups addObject:g];
    
    // 2.3归档
    [CNFArchiveTool archiveRootObject:self.groups];
    
    // 3.刷新表格
    [self.tableView reloadData];
}

#pragma mark - Table view data source
/**
 *  总共有几组
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //更新未分组中的联系人
    [self updateUnGroup];
    
    return self.groups.count;
}

/**
 *  更新未分组中的联系人
 */
- (void)updateUnGroup
{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (CNFPerson *p in self.unGrouped.persons) {
        if (p.groupType == 0) {
            [tempArray addObject:p];
        }
    }
    [_unGrouped.persons removeAllObjects];
    [_unGrouped.persons addObjectsFromArray:tempArray];
}

/**
 *  每组有多少行
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CNFPeopleGroup *g = self.groups[section];
    if (g.isOpened) {
        return g.persons.count;
    } else {
        return 0;
    }
}

#pragma mark - tableViewDelegate
/**
 *  每行显示的内容
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建一个Cell
    CNFPersonViewCell *cell = [CNFPersonViewCell cellWithTableView:tableView];
    
    // 2.传递一个模型给Cell
    CNFPeopleGroup *g = self.groups[indexPath.section];
    cell.person = g.persons[indexPath.row];
    
    // 3.返回
    return cell;
}

/**
 *  设置每组的header
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // 1.创建headerView
    CNFGroupHeaderView *header = [CNFGroupHeaderView viewWithTableView:tableView];
    // 2.传递模型
    header.group = self.groups[section];
    header.delegate = self;
    // 3.返回
    return header;
}
#pragma mark - CNFHeaderViewDelegate
- (void)headerViewDidClickedNameView:(CNFGroupHeaderView *)headerView
{
    [self.tableView reloadData];
}

@end
