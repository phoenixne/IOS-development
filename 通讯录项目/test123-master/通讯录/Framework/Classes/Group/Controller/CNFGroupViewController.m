//
//  CNFGroupViewController.m
//  通讯录
//
//  Created by gwp on 15-5-18.
//  Copyright (c) 2015年 cnf. All rights reserved.
//

#import "CNFGroupViewController.h"
#import "CNFAddressBookTool.h"
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
 *  当没有任何分组时显示的按钮,用来提醒用户添加分组
 */
//@property (nonatomic, weak) UIButton *nothingBtn;
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
    self.tableView.sectionHeaderHeight = 44;
    
    // 监听通知
    [GWPNotificationCenter addObserver:self selector:@selector(createNewGroup:) name:CNFDidCreateNewGroupNotification object:nil];
    
    // 设置左边标题
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemCancel) target:self action:@selector(cancelBtnClick)];
    
    // 设置右边标题
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(addBtnClick)];
}

- (void)dealloc
{
    [GWPNotificationCenter removeObserver:self];
}

// 第一进入程序,初始化
- (void)initApp
{
    CNFPeopleGroup *defGroup = [[CNFPeopleGroup alloc] init];
    defGroup.name = @"未分组";
    defGroup.opened = YES;
    defGroup.persons = [CNFAddressBookTool peoples];
    [self.groups addObject:defGroup];
    [CNFArchiveTool archiveRootObject:self.groups];
//    [NSKeyedArchiver archiveRootObject:self.groups toFile:PersonsPath];
}

#pragma mark 懒加载
- (NSArray *)groups
{
    if (!_groups) {
        _groups = [NSMutableArray array];
        
        // 1.读取沙盒中的组模型数组
        NSArray *array = [CNFArchiveTool unarchiveObj];
//        NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:PersonsPath];
        
        // 2.赋值
        [_groups addObjectsFromArray:array];
        
//        for (int i = 0; i < 3; i++) {
//            CNFPeopleGroup *g = [[CNFPeopleGroup alloc] init];
//            NSString *str = [NSString stringWithFormat:@"di%dzu ==",i];
//            g.name = str;
//            g.opened = NO;
//            [_groups addObject:g];
//        }
    }
    return _groups;
}

#pragma mark - 方法监听
- (void)addBtnClick
{
    CNFNavigationController *Nav = [[CNFNavigationController alloc] initWithRootViewController:[[CNFNewGroupViewController alloc] init]];
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
    for (CNFPerson *p in persons) {
        p.groupType = currentMaxGroupTypeInfo + 1;
        NSLog(@"%@",p);
    }
    
    // 2.加到总数组中进行归档
    // 2.1把新建组包装成组模型
    CNFPeopleGroup *g = [[CNFPeopleGroup alloc] init];
    g.persons = [NSArray arrayWithArray:persons];
    g.name = name;
    // 2.2把组模型添加到总数组
    [self.groups addObject:g];
    
    // 2.3归档
    // 把新建组里的联系人从未分组中删除
    for (CNFPeopleGroup *g in self.groups) {
        if ([g.name isEqualToString:@"未分组"]) {
//            NSLog(@"删除之前未分组数量为%d",g.persons.count);
            // 遍历未分组中的所有联系人,发现组号不为0或1就删除
            for (CNFPerson *p in g.persons) {
                NSLog(@"%@",p);
                if (p.groupType == 0 || p.groupType == 1) {
//                    NSLog(@"%d",p.groupType);
                } else {
                    [g.persons delete:p];
                    NSLog(@"删除之后未分组数量为%lu",(unsigned long)g.persons.count);
                }
            }
            
            break;
        }
    }
    
    // 3.刷新表格
//    NSLog(@"%d",currentMaxGroupTypeInfo);
}

#pragma mark - Table view data source
/**
 *  总共有几组
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

/**
 *  每组有多少行
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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
    NSArray *peoples = [CNFAddressBookTool peoples];
    cell.person = peoples[indexPath.row];
    
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
