//
//  CNFPhoneNumber.h
//  通讯录
//
//  Created by gwp on 15-5-19.
//  Copyright (c) 2015年 cnf. All rights reserved.
//  电话模型

#import <Foundation/Foundation.h>

typedef enum {
    CNFPhoneNumberTypeHome = 0,
    CNFPhoneNumberTypeWork,
    CNFPhoneNumberTypeIPhone,
    CNFPhoneNumberTypeMobile,
    CNFPhoneNumberTypeMain,
    CNFPhoneNumberTypeOther
}CNFPhoneNumberType;

@interface CNFPhoneNumber : NSObject<NSCoding>
/** 电话号码类型 */
@property (nonatomic, assign) CNFPhoneNumberType type;

/** 电话号码内容 */
@property (nonatomic, copy) NSString *value;
@end
