//
//  CNFAllViewController.m
//  通讯录
//
//  Created by gwp on 15-5-18.
//  Copyright (c) 2015年 cnf. All rights reserved.
//

#import "CNFAllViewController.h"
//#import "CNFAddressBookTool.h"
#import "CNFPersonViewCell.h"
#import "CNFNavigationController.h"
#import <AddressBookUI/AddressBookUI.h>
#import "CNFPerson.h"
#import "CNFPhoneNumber.h"
#import <MessageUI/MessageUI.h>
#import "CNFHistory.h"


@interface CNFAllViewController ()<ABNewPersonViewControllerDelegate, ABPersonViewControllerDelegate, UIActionSheetDelegate, CNFPersonViewCellDelegate, MFMessageComposeViewControllerDelegate>

/** 添加contact */
@property (nonatomic, strong) ABNewPersonViewController *addPeopleVc;

/** 查看、修改contact */
@property (nonatomic, strong) ABPersonViewController *personVc;

/** 即将被删除的联系人的index */
@property (nonatomic, assign) NSIndexPath *willDeleteIndexPath;

/** 用于打电话的webView */
@property (nonatomic, strong) UIWebView *webView;

/** 用于发短信 */
@property (nonatomic, strong) MFMessageComposeViewController *messageVc;

/** 全部联系人 */
@property (nonatomic, strong) NSArray *peoples;
@end

@implementation CNFAllViewController
#pragma mark - 懒加载
- (NSArray *)peoples{
    if (!_peoples) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            _peoples = [CNFAddressBookTool peoples];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        });
        
    }
    return _peoples;
}


- (ABNewPersonViewController *)addPeopleVc{
    if (!_addPeopleVc) {
        _addPeopleVc = [[ABNewPersonViewController alloc] init];
        _addPeopleVc.newPersonViewDelegate = self;
    }
    return _addPeopleVc;
}

- (ABPersonViewController *)personVc{
    if (!_personVc) {
        _personVc = [[ABPersonViewController alloc] init];
        _personVc.personViewDelegate = self;
    }
    return _personVc;
}


#pragma mark - 初始化方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // cell高度
    self.tableView.rowHeight = 60;
    
    
    // 监听授权改变事件
    [GWPNotificationCenter addObserver:self.tableView selector:@selector(reloadData) name:CNFAddressBookAuthorizationDidChangeNotification object:nil];
    
    // 设置导航条
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addContact)];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"联系人" style:UIBarButtonItemStyleDone target:nil action:nil];
}

#pragma 处理点击事件、通知
/** 添加联系人 */
- (void)addContact{
    CNFNavigationController *nav = [[CNFNavigationController alloc] initWithRootViewController:self.addPeopleVc];
    [self presentViewController:nav animated:YES completion:nil];
}


#pragma mark - CNFPersonViewCellDelegate - 打电话、发短信
- (void)personViewCell:(CNFPersonViewCell *)cell callTo:(CNFPerson *)person{
    /** 保存记录 */
    CNFHistory *history = [[CNFHistory alloc] init];
    history.name = person.fullName;
    history.behavior = CNFHistoryBehaviorCall;
    [CNFAddressBookTool saveHistory:history];
    
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    }
    NSString *urlStr = [NSString stringWithFormat:@"tel://%@",person.firstPhoneNumber.value];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
}

- (void)personViewCell:(CNFPersonViewCell *)cell sendMessageTo:(CNFPerson *)person{
    /** 保存记录 */
    CNFHistory *history = [[CNFHistory alloc] init];
    history.name = person.fullName;
    history.behavior = CNFHistoryBehaviorSendMessage;
    [CNFAddressBookTool saveHistory:history];
    
    MFMessageComposeViewController *vc = [[MFMessageComposeViewController alloc] init];
    self.messageVc = vc;
    
    // 设置短信内容
    vc.body = @"吃饭了没？";
    // 设置收件人列表
    vc.recipients = @[person.firstPhoneNumber.value];
    // 设置代理
    vc.messageComposeDelegate = self;
    
    // 显示控制器
    [self presentViewController:vc animated:YES completion:nil];
    
    
}


#pragma mark - UITableViewDataSource方法
// 每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.peoples.count;
}
// 数据源
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 创建cell
    CNFPersonViewCell *cell = [CNFPersonViewCell cellWithTableView:tableView];
    cell.delegate = self;
    
    // 传递模型
    cell.person = self.peoples[indexPath.row];
    
    // 返回cell
    return cell;
}


#pragma mark - UITableViewDelegate方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RHPerson *person = [CNFAddressBookTool RHPersons][indexPath.row];
//    RHMultiValue *phoneNumbers = person.phoneNumbers;
    
    
    
    ABPersonViewController *personViewController = [[ABPersonViewController alloc] init];
    
    //setup (tell the view controller to use our underlying address book instance, so our person object is directly updated on our behalf)
    [person.addressBook performAddressBookAction:^(ABAddressBookRef addressBookRef) {
        personViewController.addressBook =addressBookRef;
    } waitUntilDone:YES];
    
    personViewController.displayedPerson = person.recordRef;
    personViewController.allowsEditing = YES;
    
    [self.navigationController pushViewController:personViewController animated:YES];
}


/** 设置编辑类型（删除或添加） */
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    LogMethod
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"删除操作不可逆，确定删除？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [sheet showInView:self.view];
    
    self.willDeleteIndexPath = indexPath;
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) { // 确认按钮
        RHPerson *person = [CNFAddressBookTool RHPersons][self.willDeleteIndexPath.row];
        
        ABAddressBookRef book = ABAddressBookCreateWithOptions(NULL, NULL);
        ABRecordRef recordRef = ABAddressBookGetPersonWithRecordID(book, person.recordID);
        
        ABAddressBookRemoveRecord(book, recordRef, NULL);//删除
        ABAddressBookSave(book, NULL);//删除之后提交更改
        
        [self.tableView deleteRowsAtIndexPaths:@[self.willDeleteIndexPath] withRowAnimation:UITableViewRowAnimationTop];
        self.willDeleteIndexPath = nil;
        CFRelease(book);
    }
}

#pragma mark - ABNewPersonViewControllerDelegate
- (void)newPersonViewController:(ABNewPersonViewController *)newPersonView didCompleteWithNewPerson:(ABRecordRef)person{
    LogMethod
    [newPersonView dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
}

#pragma mark - ABPersonViewControllerDelegate
- (BOOL)personViewController:(ABPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    LogMethod
    [self.tableView reloadData];
    
    return NO;
}

#pragma mark - MFMessageComposeViewControllerDelegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [controller dismissViewControllerAnimated:YES completion:nil];
    if (result == MessageComposeResultCancelled) {
        [MBProgressHUD showError:@"取消发送"];
    } else if (result == MessageComposeResultSent) {
        [MBProgressHUD showSuccess:@"已经发出"];
    } else {
        [MBProgressHUD showError:@"发送失败"];
    }
    
}
@end
