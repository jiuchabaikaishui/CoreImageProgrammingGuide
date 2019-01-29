//
//  UIViewController+Common.m
//  QRindoMerchant
//
//  Created by 綦帅鹏 on 2018/12/24.
//  Copyright © 2018年 DaXiong. All rights reserved.
//

#import "UIViewController+Common.h"
#import <objc/runtime.h>

#define K_Default_NotificationCenter        [NSNotificationCenter defaultCenter]
#define K_KeyboardNotifcationObject_Name    "keyboardObj"
#define K_Weak_Self                         typeof(self) __weak weakSelf = self;

@interface KeyboardNotifcationObject ()

@property (copy, nonatomic, readonly) KeyboardNotificationBlock keyboardNotificationB;

@end

@implementation KeyboardNotifcationObject

- (void)dealloc {
    [self removeNotifycations];
}


+ (instancetype)objectWithNotificationBlock:(KeyboardNotificationBlock)block {
    return [[self alloc] initWithNotificationBlock:block];
}
- (instancetype)initWithNotificationBlock:(KeyboardNotificationBlock)block {
    if (self = [super init]) {
        _keyboardNotificationB = block;
        [self registerNotifycations];
    }
    
    return self;
}
- (void)updateNotificationBlock:(KeyboardNotificationBlock)block {
    _keyboardNotificationB = block;
}

- (void)registerNotifycations {
    [K_Default_NotificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [K_Default_NotificationCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)removeNotifycations {
    [K_Default_NotificationCenter removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [K_Default_NotificationCenter removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyboardWillShow:(NSNotification *)sender {
    if (self.keyboardNotificationB) {
        self.keyboardNotificationB(YES, sender);
    }
}
- (void)keyboardWillHide:(NSNotification *)sender {
    if (self.keyboardNotificationB) {
        self.keyboardNotificationB(NO, sender);
    }
}

@end

@implementation UIViewController (Common)

- (KeyboardNotifcationObject *)keyboardObj {
    KeyboardNotifcationObject *obj = objc_getAssociatedObject(self, K_KeyboardNotifcationObject_Name);
    if (obj == nil) {
        obj = [KeyboardNotifcationObject objectWithNotificationBlock:nil];
        objc_setAssociatedObject(self, K_KeyboardNotifcationObject_Name, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return obj;
}
- (void)autoMoveByKeyboard {
    K_Weak_Self
    [self.keyboardObj updateNotificationBlock:^(BOOL show, NSNotification *sender) {
        UIView *firstV = [weakSelf.view searchFirstResponder];
        CGRect rect = [firstV convertRect:firstV.bounds toView:weakSelf.view];
        CGFloat distance = rect.origin.y + rect.size.height - [[sender.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
        
        //首尾式动画
        [UIView beginAnimations:nil context:nil];
        //设置动画时间
        [UIView setAnimationDuration:[[sender.userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
        //设置动画节奏
        [UIView setAnimationCurve:[[sender.userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue]];
        if (show) {
            if (distance > 0)
                weakSelf.view.transform = CGAffineTransformMakeTranslation(0, -(distance + 10.0f));
        } else {
            weakSelf.view.transform = CGAffineTransformIdentity;
        }
        
        [UIView commitAnimations];
    }];
}
- (void)keyboardWillChange:(KeyboardWillChangeBlock)block {
    K_Weak_Self
    [self.keyboardObj updateNotificationBlock:^(BOOL show, NSNotification *sender) {
        UIView *firstV = [weakSelf.view searchFirstResponder];
        CGRect rect = [firstV convertRect:firstV.bounds toView:weakSelf.view];
        CGFloat distance = rect.origin.y + rect.size.height - [[sender.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
        if (block) {
            block(show, distance, sender);
        }
    }];
}

@end
