//
//  GWPExtension.h
//  GWPExtension
//
//  Created by gwp on 15-5-14.
//  Copyright (c) 2015年 gwp. All rights reserved.
//

#ifndef GWPExtension_GWPExtension_h
#define GWPExtension_GWPExtension_h

#import "UIView+GWPExtension.h"
#import "UIImage+GWPExtension.h"

#endif

#ifdef __OBJC__

#ifdef DEBUG
#define LogMethod \
NSLog(@"method:%s  line:%d\n---------------------------", __func__, __LINE__);
#define GWPLog(...) \
NSLog(@"\nmethod\t:\t%s  \nline\t:\t%d \nlog\t:\t%@\n---------------------------", __func__, __LINE__, [NSString stringWithFormat:__VA_ARGS__]);
#else
#define LogMethod
#define GWPLog(...)
#endif // DEBUG


#pragma mark - 通知中心
#define GWPNotificationCenter [NSNotificationCenter defaultCenter]

#pragma mark - 颜色相关（RGB颜色、随机色）
/** RGB颜色 */
#define GWPRGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
/** 随机色 */
#define GWPRandomColor GWPRGBColor(arc4random_uniform(255),arc4random_uniform(255),arc4random_uniform(255))

#endif  // __OBJC__