//
//  CNFAddressBookTool.h
//  通讯录
//
//  Created by gwp on 15-5-18.
//  Copyright (c) 2015年 cnf. All rights reserved.
//  通讯录工具类

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import "CNFHistory.h"

@class CNFPhoneNumber, CNFPerson;


@interface CNFAddressBookTool : NSObject
/** 返回所有联系人 装着 CNFPerson 模型*/
+ (NSArray *)peoples;

/** 返回所有联系人 装着 RHPerson 模型*/
+ (NSArray *)RHPersons;

/**
 *  保存历史记录
 *
 *  @param history   历史记录
 */
+ (void)saveHistory:(CNFHistory *)history;

/** 返回所有历史记录 */
+ (NSArray *)historys;

/**
 *  将某个联系人插入黑名单
 *
 *  @param person 联系人
 */
+ (void)insertBlackListWithPerson:(CNFPerson *)person;

/**
 *  批量插入黑名单
 *
 *  @param persons 联系人数组（装的CNFPerson）
 */
+ (void)insertBlackListWithPersons:(NSArray *)persons;

/**
 *  将某个联系人从黑名单移除
 *
 *  @param person 联系人
 */
+ (void)removePersonFromBlackList:(CNFPerson *)person;
/**
 *  批量移出黑名单
 *
 *  @param person 联系人数组（CNFPerson）
 */
+ (void)removePersonsFromBlackList:(NSArray *)persons;

/** 返回所有黑名单联系人（CNFPerson.fullName） */
+ (NSArray *)blackPersons;
@end
