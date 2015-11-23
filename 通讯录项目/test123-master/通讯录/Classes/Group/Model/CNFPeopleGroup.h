//
//  CNFPeopleGroup.h
//  通讯录
//
//  Created by singer on 15-5-19.
//  Copyright (c) 2015年 cnf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CNFPeopleGroup : NSObject<NSCoding>

/**
 *  组的名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  数组中装的都是CNFPerson模型
 */
@property (nonatomic, strong) NSMutableArray *persons;

/**
 *  标识这组是否需要展开,  YES : 展开 ,  NO : 关闭
 */
@property (nonatomic, assign, getter = isOpened) BOOL opened;
@end
