//
//  SizeViewController.h
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2019/1/29.
//  Copyright © 2019年 綦帅鹏. All rights reserved.
//

#import "BaseViewController.h"

@interface SizeViewController : BaseViewController
@property (strong, nonatomic) UIColor *color;
@property (assign, nonatomic) NSInteger size;
@property (copy, nonatomic) void (^ensureB)(NSInteger size);

@end

NS_ASSUME_NONNULL_BEGIN

NS_ASSUME_NONNULL_END
