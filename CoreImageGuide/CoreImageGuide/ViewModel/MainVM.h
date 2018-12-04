//
//  MainVM.h
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/11/27.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import "BaseViewControllerVM.h"
#import "MainTableViewCellVM.h"
#import "ProcessingViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainVM : BaseViewControllerVM

@property (strong, nonatomic, readonly) QSPTableViewVM *tableViewVM;

@end

NS_ASSUME_NONNULL_END
