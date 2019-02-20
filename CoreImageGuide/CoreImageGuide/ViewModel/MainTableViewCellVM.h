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

@interface MainTableViewCellVM : CommonTableViewCellVM

@property (strong, nonatomic, readonly) NSString *segueID;
@property (assign, nonatomic, readonly) BOOL realM;

- (MainTableViewCellVM * (^)(NSString *))segueIDSet;
- (MainTableViewCellVM * (^)(BOOL))realMSet;

@end

NS_ASSUME_NONNULL_END
