//
//  CNFArchiveTool.m
//  通讯录
//
//  Created by singer on 15-5-19.
//  Copyright (c) 2015年 cnf. All rights reserved.
//


#define PersonsPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"persons.archiver"]

#import "CNFArchiveTool.h"

@implementation CNFArchiveTool

+ (void)archiveRootObject:(id)obj
{
    [NSKeyedArchiver archiveRootObject:obj toFile:PersonsPath];
}

+ (id)unarchiveObj
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:PersonsPath];
}

//+ (NSInteger)groupsCount
//{
//    NSArray *a = [self unarchiveObj];
//    return a.count;
//}
@end
