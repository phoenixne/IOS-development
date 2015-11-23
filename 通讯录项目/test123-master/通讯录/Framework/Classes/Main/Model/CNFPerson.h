//
//  CNFPerson.h
//  通讯录
//
//  Created by gwp on 15-5-19.
//  Copyright (c) 2015年 cnf. All rights reserved.
//  人模型，由RHPerson转换而来

#import <Foundation/Foundation.h>
@class RHPerson, CNFPhoneNumber;

@interface CNFPerson : NSObject<NSCoding>
/** 用于标记该Person是否被选中。可用于任何需要标记的场景，默认NO */
@property (nonatomic, assign) BOOL mark;

/** 属于哪个组  默认值为0,属于未分组  值等于1时为新建分组时所选的联系人(暂时的,当新建分组页面被销毁时会被清空) */
@property (nonatomic, assign) NSInteger groupType;

/** 中国姓名的 姓氏 */
@property (nonatomic, copy) NSString *xing;

/** 中国姓名的 名字 */
@property (nonatomic, copy) NSString *name;

/** person 的全名（按照中国姓名的组合方式，如果没有名字，会返回公司名） */
@property (nonatomic, copy) NSString *fullName;

/** 公司、组织 */
@property (nonatomic, copy) NSString *organization;

/** 第一个电话号码 */
@property (nonatomic, strong) CNFPhoneNumber *firstPhoneNumber;

/** 所有电话号码数组，装的都是 CNFPhoneNumber模型 */
@property (nonatomic, strong) NSArray *allPhoneNumber;

/** RHPerson转CNFPerson */
+ (instancetype)personWithRHPerson:(RHPerson *)RHPerson;
@end
