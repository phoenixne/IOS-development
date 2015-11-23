//
//  UIView+GWPExtension.h
//  大熊微博
//
//  Created by gwp on 15-4-17.
//  Copyright (c) 2015年 gwp. All rights reserved.
//


// 用于直接修改继承自UIView的控件的x,y,width,height,size,origin,centerX,centerY等值，而不需要先获取frame在进行修改


#import <UIKit/UIKit.h>

@interface UIView (GWPExtension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize  size;
@property (nonatomic, assign) CGPoint origin;
@end
