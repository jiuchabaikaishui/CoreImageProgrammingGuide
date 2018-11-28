//
//  MainTableVIewCellVM.h
//  Scanning
//
//  Created by 綦帅鹏 on 2018/11/16.
//  Copyright © 2018年 PowesunHolding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewControllerVM.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainTableViewCellVM : QSPTableViewCellVM

@property (strong, nonatomic, readonly) NSString *nextStoryboardID;
@property (strong, nonatomic, readonly) BaseViewControllerVM *nextVM;

- (MainTableViewCellVM * (^)(BaseViewControllerVM *))nextVMSet;
- (MainTableViewCellVM * (^)(NSString *))nextStoryboardIDSet;

@end

NS_ASSUME_NONNULL_END
