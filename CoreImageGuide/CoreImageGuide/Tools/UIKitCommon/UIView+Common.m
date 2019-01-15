//
//  UIView+Common.m
//  QRindoMerchant
//
//  Created by 綦帅鹏 on 2018/12/13.
//  Copyright © 2018年 DaXiong. All rights reserved.
//

#import "UIView+Common.h"
#import <objc/runtime.h>

#define TapName                                 @"cotegory_UIViewCommon_TapGestureRecognizer"
#define TapActionSELStr                         @"cotegory_UIViewCommon_TapGestureRecognizerAction:"
#define TapActionBlockName                      @"cotegory_UIViewCommon_TapGestureRecognizerActionBlock"

@implementation UIView (Common)

- (UITapGestureRecognizer *)tapGestureRecognizerAction:(TapBlock)actionB {
    objc_setAssociatedObject(self, TapActionBlockName, actionB, OBJC_ASSOCIATION_COPY_NONATOMIC);
    SEL sel = NSSelectorFromString(TapActionSELStr);
    class_addMethod(self.class, sel, (IMP)cotegory_UIViewCommon_TapGestureRecognizerMethed, "V@:@");
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:sel];
    [self addGestureRecognizer:tap];
    objc_setAssociatedObject(self, TapName, tap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return tap;
}
void cotegory_UIViewCommon_TapGestureRecognizerMethed(id self, SEL _cmd, UITapGestureRecognizer *sender) {
    TapBlock block = objc_getAssociatedObject(self, TapActionBlockName);
    if (block) {
        UITapGestureRecognizer *tap = objc_getAssociatedObject(self, TapName);
        if (tap) {
            block(tap);
        }
    }
}
- (UIView *)searchFirstResponder {
    if (self.isFirstResponder) {
        return self;
    } else {
        for (UIView *theView in self.subviews) {
            UIView *first = [theView searchFirstResponder];
            if (first) {
                return first;
            }
        }
    }
    
    return nil;
}

- (UIViewController *)controller {
    if ([self.nextResponder isKindOfClass:UIViewController.class]) {
        return (UIViewController *)self.nextResponder;
    } else if ([self.nextResponder isKindOfClass:UIView.class]) {
        return [((UIView *)self.nextResponder) controller];
    }
    
    return nil;
}

@end
