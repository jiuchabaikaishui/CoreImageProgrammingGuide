//
//  UIImage+CommonUtils.h
//  QRindoMerchant
//
//  Created by DaXiong on 2019/1/9.
//  Copyright © 2019年 DaXiong. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface UIImage (CommonUtils)

/**
 *  从水平和竖直方向的中心线拉伸的图片
 *  @return:object  拉伸后的图片
 */
- (UIImage *)stretchableImageFromCenter;


/**
 *  获取平铺后的图片
 *  @return:object  平铺后的图片
 */
- (UIImage *)tileableImageForOriginal;

@end

