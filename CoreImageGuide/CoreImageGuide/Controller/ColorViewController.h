//
//  ColorViewController.h
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2019/1/29.
//  Copyright © 2019年 綦帅鹏. All rights reserved.
//

#import "BaseViewController.h"

@interface ColorViewController : BaseViewController

@property (strong, nonatomic) UIColor *color;
@property (strong, nonatomic, readonly) UIColor *currentC;
@property (copy, nonatomic) void (^ensureB)(UIColor *color);

@end

NS_ASSUME_NONNULL_BEGIN

NS_ASSUME_NONNULL_END
