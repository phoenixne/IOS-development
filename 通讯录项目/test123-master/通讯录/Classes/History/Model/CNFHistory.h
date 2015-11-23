//
//  CNFHistory.h
//  通讯录
//
//  Created by gwp on 15-5-20.
//  Copyright (c) 2015年 cnf. All rights reserved.
//

#import <Foundation/Foundation.h>


/** 操作的行为 */
typedef enum {
    CNFHistoryBehaviorCall = 0,   // 大电话
    CNFHistoryBehaviorSendMessage // 发短信
}CNFHistoryBehavior;

@interface CNFHistory : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) CNFHistoryBehavior behavior;
@property (nonatomic, strong) NSDate *time;
@end
