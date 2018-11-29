//
//  BaseViewController.m
//  Review
//
//  Created by 綦帅鹏 on 2018/11/13.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - 控制器周期
- (void)dealloc {
    DebugLog(@"%@销毁了", NSStringFromClass(self.class));
}
//+ (instancetype)controllerWithVM:(BaseViewControllerVM *)vm {
//    return [[self alloc] initWithVM:vm];
//}
//+ (instancetype)controllerWithVM:(BaseViewControllerVM *)vm andStoryboardID:(NSString *)storyboardID {
//    BaseViewController *controller = K_ViewControllerFromMainStorybardWithID(storyboardID);
//    [controller vmSet:vm];
//
//    return controller;
//}
//- (void)vmSet:(BaseViewControllerVM *)vm {
//    _vm = vm;
//}
//- (instancetype)initWithVM:(BaseViewControllerVM *)vm {
//    if (self = [super init]) {
//        _vm = vm;
//    }
//
//    return self;
//}
//-(instancetype)initWithCoder:(NSCoder *)aDecoder andVM:(BaseViewControllerVM *)vm {
//    if (self = [super initWithCoder:aDecoder]) {
//        _vm = vm;
//    }
//
//    return self;
//}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    [self settingUI];
//    [self bindVM];
//}
//
//- (void)settingUI{
//
//}
//- (void)bindVM {
//    if (![ConFunc blankOfStr:self.vm.title]) {
//        self.title = self.vm.title;
//    }
//}

@end
