//
//  UIView+Common.h
//  QRindoMerchant
//
//  Created by 綦帅鹏 on 2018/12/13.
//  Copyright © 2018年 DaXiong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TapBlock)(UITapGestureRecognizer *tap);

@interface UIView (Common)

/**
 添加点击手势

 @param actionB 执行手势方法
 @return 手势对象
 */
- (UITapGestureRecognizer *)tapGestureRecognizerAction:(TapBlock)actionB;

/**
 寻找第一响应者

 @return 第一响应者
 */
- (UIView *)searchFirstResponder;

/**
 视图所处控制器

 @return 控制器
 */
- (UIViewController *)controller;

@end
