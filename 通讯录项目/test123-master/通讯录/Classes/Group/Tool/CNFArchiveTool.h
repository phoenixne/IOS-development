//
//  CNFArchiveTool.h
//  通讯录
//
//  Created by singer on 15-5-19.
//  Copyright (c) 2015年 cnf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CNFArchiveTool : NSObject
/**
 *  保存对象到沙盒
 */
+ (void)archiveRootObject:(id)obj;

/**
 *  从沙盒中取出对象
 */
+ (id)unarchiveObj;

/**
 *  返回当前沙盒中共有几个分组(包含未分组)
 */
//+ (NSInteger)groupsCount;
@end
