//
//  UIImage+Common.h
//  QRindoMerchant
//
//  Created by 綦帅鹏 on 2018/12/13.
//  Copyright © 2018年 DaXiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Common)

/**
 可拉伸的图片

 @param name 名称
 @param left 左边比例（0-1）
 @param top 顶部的比例（0-1）
 @return 图片
 */
+ (UIImage *)stretchImageWithNamed:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
/**
 中心可拉伸的图片

 @param name 名称
 @return 图片
 */
+ (UIImage *)centerStretchImageWithNamed:(NSString *)name;
/**
 可拉伸的图片

 @return 图片
 */
- (UIImage *)centerStretch;
/**
 中心可拉伸的图片

 @param left 左边比例（0-1）
 @param top 顶部的比例（0-1）
 @return 图片
 */
- (UIImage *)stretchFromLeft:(CGFloat)left top:(CGFloat)top;

/**
 生成虚线图片
 
 @param size 尺寸
 @param width 线宽
 @param begin 起点
 @param end 终点
 @param color 颜色
 @param lengths 虚实像素数组
 @param phase 相位
 @param completedB 完成block
 */
+ (void)dottedLineImageWithSize:(CGSize)size width:(CGFloat)width from:(CGPoint)begin to:(CGPoint)end color:(UIColor *)color lengths:(NSArray<NSNumber *> *)lengths phase:(CGFloat)phase completed:(void (^)(UIImage *image))completedB;
/**
 生成圆角颜色图像

 @param color 颜色
 @param size 尺寸
 @param radius 圆角
 @param completedB 完成block
 */
+ (void)imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)radius completed:(void (^)(UIImage *image))completedB;

/**
 生成圆角颜色图像
 
 @param color 颜色
 @param size 尺寸
 @param radius 圆角
 @param strokeC 描边颜色
 @param strokeW 描边宽度
 @param completedB 完成block
 */
+ (void)imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)radius strokeColor:(UIColor *)strokeC strokeWidth:(CGFloat)strokeW completed:(void (^)(UIImage *image))completedB;
/**
 生成图像

 @param size 尺寸
 @param drawB 绘制block
 @param completedB 完成block
 */
+ (void)genarateImageWithSize:(CGSize)size draw:(void (^)(CGSize size, CGContextRef context))drawB completed:(void (^)(UIImage *image))completedB;

@end

