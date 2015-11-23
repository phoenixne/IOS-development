//
//  CNFNewGroupViewController.m
//  通讯录
//
//  Created by singer on 15-5-19.
//  Copyright (c) 2015年 cnf. All rights reserved.
//

#import "CNFNewGroupViewController.h"
#import "CNFPerson.h"
#import "CNFPeopleGroup.h"
//#import "CNFPersonViewCell.h"
#import "CNFArchiveTool.h"
#import "CNFGroupSelecteCell.h"

@interface CNFNewGroupViewController ()<UITableViewDataSource,UITableViewDelegate>
/**
 *  存放着选好的CNFPerson模型
 */
@property (nonatomic , strong) NSMutableArray *selectedPersons;
/**
 *  存放着所有待选的CNFPerson模型
 */
@property (nonatomic , strong) NSArray *allPersons;

// 待选联系人列表
@property (weak, nonatomic) IBOutlet UITableView *tableView;

// 文本输入框
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@implementation CNFNewGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.textField becomeFirstResponder];
    self.navigationItem.title = @"新增分组";
    
    // 设置左边标题
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemCancel) target:self action:@selector(cancelBtnClick)];
    
    // 设置右边标题
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemDone) target:self action:@selector(addBtnClick)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    // 监听文本输入框文本改变
    [GWPNotificationCenter addObserver:self selector:@selector(textFieldDidChanged) name:UITextFieldTextDidChangeNotification object:self.textField];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // 1.读取沙盒中的组模型数组
    NSArray *array = [CNFArchiveTool unarchiveObj];
    for (CNFPeopleGroup *g in array) {
        if ([g.name isEqualToString:@"未分组"]) {
            self.allPersons = [NSArray arrayWithArray:g.persons];
            break;
        }
    }
}

#pragma mark - 懒加载
- (NSMutableArray *)selectedPersons
{
    if (!_selectedPersons) {
        _selectedPersons = [NSMutableArray array];
    }
    return _selectedPersons;
}

- (void)dealloc
{
    [GWPNotificationCenter removeObserver:self];
}

#pragma mark - 监听按钮点击
- (void)cancelBtnClick
{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 点击了添加按钮
- (void)addBtnClick
{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    if (self.selectedPersons == nil) return;
    [GWPNotificationCenter postNotificationName:CNFDidCreateNewGroupNotification object:self userInfo:@{@"persons" : self.selectedPersons, @"name" : self.textField.text}];
    // 1.归档
//    NSString *unArchiverKey = [NSString stringWithFormat:@"%@.archiver",self.textField.text];
//    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:unArchiverKey];
//    [NSKeyedArchiver archiveRootObject:self.persons toFile:path];
//    // 2.保存分组名
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:unArchiverKey forKey:self.textField.text];
//    [defaults synchronize];
}

- (void)textFieldDidChanged
{
    self.navigationItem.rightBarButtonItem.enabled = self.textField.text.length;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allPersons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建一个Cell
    CNFGroupSelecteCell *cell = [CNFGroupSelecteCell cellWithTableView:tableView];
    
    // 2.传递一个模型给Cell
    cell.person = self.allPersons[indexPath.row];
    
    // 3.返回
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
/**
 *  选中某行时会调用
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CNFGroupSelecteCell *cell = (CNFGroupSelecteCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    // 1.取出选中的联系人
    CNFPerson *p = self.allPersons[indexPath.row];
    
    // 判断是否需要打钩,添加打钩的联系人到数组中
    p.groupType = !p.groupType;
    if (p.groupType == 1) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.selectedPersons addObject:p];
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [self.selectedPersons removeObject:p];
    }
}
@end
