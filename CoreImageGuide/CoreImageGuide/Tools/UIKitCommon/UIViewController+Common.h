//
//  UIViewController+Common.h
//  QRindoMerchant
//
//  Created by 綦帅鹏 on 2018/12/24.
//  Copyright © 2018年 DaXiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Common.h"

typedef void (^KeyboardNotificationBlock)(BOOL show, NSNotification *sender);

/**
 键盘变化block

 @param show 显示还是隐藏
 @param distance 键盘顶部与第一响应者底部的距离
 @param notification 键盘通知对象
 */
typedef void (^KeyboardWillChangeBlock)(BOOL show, CGFloat distance, NSNotification *notification);

@interface KeyboardNotifcationObject : NSObject

+ (instancetype)objectWithNotificationBlock:(KeyboardNotificationBlock)block;
- (instancetype)initWithNotificationBlock:(KeyboardNotificationBlock)block;

@end

@interface UIViewController (Common)

@property (strong, nonatomic, readonly) KeyboardNotifcationObject *keyboardObj;

- (void)autoMoveByKeyboard;
- (void)keyboardWillChange:(KeyboardWillChangeBlock)block;

@end

