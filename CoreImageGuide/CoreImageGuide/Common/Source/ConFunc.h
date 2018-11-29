//
//  ConFunc.h
//  Review
//
//  Created by 綦帅鹏 on 2018/11/13.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConFunc : NSObject

/**
 字符串判空
 */
+ (BOOL)blankOfStr:(NSString *)str;
+ (void)openSetting;
+ (void)cameraPhotoAlter:(UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate> *)controller removeAction:(void (^)(void))removeAction;

@end

NS_ASSUME_NONNULL_END
