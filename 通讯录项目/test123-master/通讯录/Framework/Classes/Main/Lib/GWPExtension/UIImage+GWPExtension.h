//
//  UIImage+GWPExtension.h
//  GWPExtension
//
//  Created by gwp on 15-5-13.
//  Copyright (c) 2015年 gwp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GWPExtension)
/**
 *  @function 裁剪成圆形图片
 *
 *  @param margin     边框宽度
 *  @param boardColor 边框颜色
 *
 *  @return 裁剪后的圆形图片
 */
- (instancetype)circleWithBoardWidth:(CGFloat)margin boardColor:(UIColor *)boardColor;

/**
 *  根据文件名裁剪圆形图片
 *
 *  @param name       图片文件名
 *  @param boardWidth 边框宽度
 *  @param boardColor 边框颜色
 *
 *  @return 裁剪后的圆形图片
 */
+ (instancetype)circleWithImageName:(NSString *)name boardWidth:(CGFloat)boardWidth boardColor:(UIColor *)boardColor;

/**
 *  @function 裁剪成圆角矩形图片
 *
 *  @param img    需要裁剪的图片
 *  @param radius 圆角半径
 *
 *  @return 裁剪后的圆角矩形图片
 */
- (instancetype)roundRectWithRadius:(CGFloat)radius;

/**
 *  根据图片名裁剪圆角图片
 *
 *  @param name   图片名
 *  @param radius 圆角半径
 *
 *  @return 裁剪后的圆角矩形图片
 */
+ (instancetype)roundRectWithName:(NSString *)name radius:(CGFloat)radius;

#warning TODO
/**
 *  @function 不改变图片边框的拉伸图片
 *
 *  @param img 原图
 *
 *  @return 拉伸后的新图
 */
- (instancetype)resizeableImage;


/**
 *  @function 以主色作为背景色，无拉伸增大图片；可以用来给图片加矩形相框
 *
 *  @param image   需要扩展的图片
 *  @param bgColor 新图片背景色
 *  @param size    新图片的大小
 *
 *  @return 返回处理后的图片
 */
- (instancetype)expansionWithBackground:(UIColor *)bgColor newSize:(CGSize)size;



/**
 *  @function 截屏
 *
 *  @param view 需要截取的View
 *
 *  @return 截取获得的的图片
 */
+ (instancetype)captureWithView:(UIView *)view;


/**
 *  @function 加水印（图片）
 *
 *  @param bgImage   背景图片（就是衬在下面的图片）
 *  @param logoImage logo图片
 *  @param scale     logo图片的缩放比例
 *
 *  @return 加过水印之后的新图片
 */
- (instancetype)waterImage:(UIImage *)waterImage andLogoScale:(CGFloat)scale;




/**
 *  @function 加水印（文字）
 *
 *  @param bgImage   背景图片（就是衬在下面的图片）
 *  @param text       水印文字
 *  @param attributes 水印文字的属性
 *
 *  @return 加过水印之后的新图片
 *
 *  *****************************  示例代码  ***************************************
 *
 *  NSDictionary *attrs = @{
 *  NSFontAttributeName : [UIFont boldSystemFontOfSize:8],
 *  NSForegroundColorAttributeName : [UIColor whiteColor]
 *  };
 *  UIImage *lastImage = [UIImage waterImageWithBackgroundImage:[UIImage imageNamed:@"scene"] andText:@"大熊出品出品出品出品大熊出品出品出品出品大熊出品出品出品出品" andTextAttributes:attrs];
 
 *  // 输出到屏幕上
 *  _imgView.image = lastImage;
 *  *****************************  示例end  ***************************************
 */
+ (instancetype)waterImageWithBackgroundImage:(UIImage *)bgImage andText:(NSString *)text andTextAttributes:(NSDictionary *)attributes;


@end
