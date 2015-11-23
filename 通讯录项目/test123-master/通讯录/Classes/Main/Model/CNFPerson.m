//
//  CNFPerson.m
//  通讯录
//
//  Created by gwp on 15-5-19.
//  Copyright (c) 2015年 cnf. All rights reserved.
//

#import "CNFPerson.h"
#import "CNFPhoneNumber.h"
#import "NSObject+MJCoding.h"


@implementation CNFPerson

// 归档的实现
MJCodingImplementation

+ (instancetype)personWithRHPerson:(RHPerson *)RHPerson{
    CNFPerson *person = [[CNFPerson alloc] init];
    
    // 取出前、中、后名字
    RHPerson.middleName = RHPerson.middleName ? RHPerson.middleName : @"";
    RHPerson.lastName = RHPerson.lastName ? RHPerson.lastName : @"";
    RHPerson.firstName = RHPerson.firstName ? RHPerson.firstName : @"";
    
    // 中文的 姓氏 => 英文的
    person.xing = RHPerson.lastName;
    person.name = [NSString stringWithFormat:@"%@%@", RHPerson.firstName, RHPerson.middleName];
    person.fullName = [person nameOfPerson:RHPerson];
    person.organization = RHPerson.organization;
    person.firstPhoneNumber = [person firstPhoneNumberOfPerson:RHPerson];
    person.allPhoneNumber = [person allPhoneNumberOfPerson:RHPerson];
    
    return person;
}

/** person 的（按照中国姓名的组合方式，如果没有名字，会返回公司名） */
- (NSString *)nameOfPerson:(RHPerson *)person{
    // 将要输出的结果
    NSString *res = nil;
    
    // 取出前、中、后名字
    person.middleName = person.middleName ? person.middleName : @"";
    person.lastName = person.lastName ? person.lastName : @"";
    person.firstName = person.firstName ? person.firstName : @"";
    
    // 拼接，
    NSString *name = [NSString stringWithFormat:@"%@%@%@", person.middleName, person.lastName, person.firstName];
    // 如果名字长度==0，用公司名代替名字
    if (name.length == 0) {
        res = person.organization;
    }else{
        res = name;
    }
    return res;
}

- (CNFPhoneNumber *)firstPhoneNumberOfPerson:(RHPerson *)RHPerson{
    if ([self allPhoneNumberOfPerson:RHPerson].count) {
        return [self allPhoneNumberOfPerson:RHPerson][0];
    }else{
        return nil;
    }
}

/** 装的都是 CNFPhoneNumber模型 */
- (NSArray *)allPhoneNumberOfPerson:(RHPerson *)person{
    NSMutableArray *all = [NSMutableArray array];
    
    RHMultiValue *RHPhoneNumbers = person.phoneNumbers;

    NSInteger count = RHPhoneNumbers.count;
    for (int i = 0; i < count; i++) {
        CNFPhoneNumber *phoneNumber = [[CNFPhoneNumber alloc] init];
        
        //遍历每个号码中的label(比如:手机 家庭 公司)
        NSString* label = [RHPhoneNumbers labelAtIndex:i];
        //遍历出号码
        NSString* number = [RHPhoneNumbers valueAtIndex:i];
        
        if ([label isEqualToString:@"_$!<Home>!$_"]) {
            phoneNumber.type = CNFPhoneNumberTypeHome;
        }else if ([label isEqualToString:@"_$!<Work>!$_"]) {
            phoneNumber.type = CNFPhoneNumberTypeWork;
        }else if ([label isEqualToString:@"iPhone"]) {
            phoneNumber.type = CNFPhoneNumberTypeIPhone;
        }else if ([label isEqualToString:@"_$!<Mobile>!$_"]) {
            phoneNumber.type = CNFPhoneNumberTypeMobile;
        }else if ([label isEqualToString:@"_$!<Main>!$_"]) {
            phoneNumber.type = CNFPhoneNumberTypeMain;
        }else{
            phoneNumber.type = CNFPhoneNumberTypeOther;
        }
        
        phoneNumber.value = number;
        [all addObject:phoneNumber];
    }
    
//    CFIndex phoneCount = ABMultiValueGetCount(phones);
//    for (int i=0; i<phoneCount; i++) {
//        CFStringRef pName = ABMultiValueCopyLabelAtIndex(phones, i);
//        CFStringRef value = ABMultiValueCopyValueAtIndex(phones, 0);
//        CNFPhoneNumber *phoneNumber = [[CNFPhoneNumber alloc] init];
//        
//        NSString *pNameOC = (__bridge NSString *)(pName);
//        if ([pNameOC isEqualToString:@"_$!<Home>!$_"]) {
//            phoneNumber.type = CNFPhoneNumberTypeHome;
//        }else if ([pNameOC isEqualToString:@"_$!<Work>!$_"]) {
//            phoneNumber.type = CNFPhoneNumberTypeWork;
//        }else if ([pNameOC isEqualToString:@"iPhone"]) {
//            phoneNumber.type = CNFPhoneNumberTypeIPhone;
//        }else if ([pNameOC isEqualToString:@"_$!<Mobile>!$_"]) {
//            phoneNumber.type = CNFPhoneNumberTypeMobile;
//        }else if ([pNameOC isEqualToString:@"_$!<Main>!$_"]) {
//            phoneNumber.type = CNFPhoneNumberTypeMain;
//        }else{
//            phoneNumber.type = CNFPhoneNumberTypeOther;
//        }
//        phoneNumber.value = (__bridge_transfer NSString *)value;
//        [all addObject:phoneNumber];
//    }
    return all;
}

@end
