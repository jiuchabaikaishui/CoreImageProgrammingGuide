//
//  BaseViewController.h
//  Review
//
//  Created by 綦帅鹏 on 2018/11/13.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewControllerVM.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

@property (strong, nonatomic, readonly) BaseViewControllerVM *vm;

//+ (instancetype)controllerWithVM:(BaseViewControllerVM *)vm andStoryboardID:(NSString *)storyboardID;
//+ (instancetype)controllerWithVM:(BaseViewControllerVM *)vm;
//- (instancetype)initWithVM:(BaseViewControllerVM *)vm;
//-(instancetype)initWithCoder:(NSCoder *)aDecoder andVM:(BaseViewControllerVM *)vm;
//
//- (void)settingUI;
//- (void)bindVM;

@end

NS_ASSUME_NONNULL_END
