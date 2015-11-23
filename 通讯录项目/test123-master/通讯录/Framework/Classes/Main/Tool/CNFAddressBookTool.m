//
//  CNFAddressBookTool.m
//  通讯录
//
//  Created by gwp on 15-5-18.
//  Copyright (c) 2015年 cnf. All rights reserved.
//

//#import "CNFAddressBookTool.h"
#import "CNFPerson.h"
#import "FMDB.h"


@implementation CNFAddressBookTool
/** 通讯录 */
static RHAddressBook *_AB;

/** 数据库 */
static FMDatabase *_DB;

+ (void)initialize{
    /** 初始化通讯录 */
    [self setupAB];
    
    /** 初始化数据库 */
    [self setupDB];
}

+ (void)setupDB{
    // 1、获取数据库文件位置
    NSString *dbPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"contact.sqlite"];
    
    // 2、打开数据库
    _DB = [FMDatabase databaseWithPath:dbPath];
    [_DB open];
    
    // 3、创表
    [_DB executeUpdate:@"create table if not exists t_contacts (id integer primary key, name text not null, history blob not null)"];
    [_DB executeUpdate:@"create table if not exists t_blackList (id integer primary key, name text not null)"];
    
}

/** 初始化通讯录 */
+ (void)setupAB{
    // 1、创建通讯录
    _AB = [[RHAddressBook alloc] init];
    
    // 2、判断是否授权
    if ([RHAddressBook authorizationStatus] == RHAuthorizationStatusNotDetermined){
        
        // 3、如果没有授权，主动要求授权
        [_AB requestAuthorizationWithCompletion:^(bool granted, NSError *error) {
            if (granted) {
                GWPLog(@"授权成功");
            }else{
                GWPLog(@"授权失败");
            }
        }];
        [GWPNotificationCenter postNotificationName:CNFAddressBookAuthorizationDidChangeNotification object:nil];
    }
}

+ (NSArray *)peoples{
    NSMutableArray *temp = [NSMutableArray array];
    
    for (RHPerson *person in _AB.peopleOrderedByLastName) {
        CNFPerson *p = [CNFPerson personWithRHPerson:person];
        [temp addObject:p];
    }
    return temp;
}

+ (NSArray *)RHPersons{
    return _AB.peopleOrderedByLastName;
}

+ (void)saveHistory:(CNFHistory *)history{
    history.time = [NSDate date];
    
    NSData *historyData = [NSKeyedArchiver archivedDataWithRootObject:history];
    BOOL res = [_DB executeUpdate:@"insert into t_contacts(name, history) values(?, ?);" withArgumentsInArray:@[history.name, historyData]];
    if (!res) GWPLog(@"历史记录插入数据库失败");
}

+ (NSArray *)historys{
    NSMutableArray *temp = [NSMutableArray array];
    
    FMResultSet *set = [_DB executeQuery:@"select history from t_contacts order by id desc"];
    while ([set next]) {
        CNFHistory *history = [NSKeyedUnarchiver unarchiveObjectWithData:[set objectForColumnName:@"history"]];
        [temp addObject:history];
    }
    
    return temp;
}

+ (void)insertBlackListWithPerson:(CNFPerson *)person{
    NSData *personData = [NSKeyedArchiver archivedDataWithRootObject:person.fullName];
    
    BOOL res = [_DB executeUpdate:@"insert into t_blackList(name) values(?);" withArgumentsInArray:@[personData]];
    if (!res) GWPLog(@"%@ 插入黑名单失败", person.fullName);
}

+ (void)insertBlackListWithPersons:(NSArray *)persons{
    for (CNFPerson *person in persons) {
        [self insertBlackListWithPerson:person];
    }
}

+ (void)removePersonFromBlackList:(CNFPerson *)person{
    BOOL res = [_DB executeUpdate:@"delete from t_blackList where name = ?;" withArgumentsInArray:@[person.fullName]];
    if (!res) GWPLog(@"%@ 移出黑名单失败", person.fullName);
}

+ (void)removePersonsFromBlackList:(NSArray *)persons{
    for (CNFPerson *person in persons) {
        [self removePersonFromBlackList:person];
    }
}

+ (NSArray *)blackPersons{
    NSMutableArray *temp = [NSMutableArray array];
    
    FMResultSet *set = [_DB executeQuery:@"select * from t_blackList"];
    while ([set next]) {
        NSString *name = [NSKeyedUnarchiver unarchiveObjectWithData:[set objectForColumnName:@"name"]];
        [temp addObject:name];
    }
    return temp;
}
@end
