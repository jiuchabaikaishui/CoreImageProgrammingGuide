//
//  MainTableVIewCellVM.m
//  Scanning
//
//  Created by 綦帅鹏 on 2018/11/16.
//  Copyright © 2018年 PowesunHolding. All rights reserved.
//

#import "MainTableViewCellVM.h"

@implementation MainTableViewCellVM

- (void)setNextVMSet:(BaseViewControllerVM * _Nonnull)nextVM {
    _nextVM = nextVM;
}
- (MainTableViewCellVM * (^)(BaseViewControllerVM *))nextVMSet {
    return ^(BaseViewControllerVM *vm) {
        self.nextVMSet = vm;
        
        return self;
    };
}

@end
