//
//  MainTableVIewCellVM.m
//  Scanning
//
//  Created by 綦帅鹏 on 2018/11/16.
//  Copyright © 2018年 PowesunHolding. All rights reserved.
//

#import "MainTableViewCellVM.h"

@implementation MainTableViewCellVM

- (void)setNextVMSet:(BaseViewControllerVM *)nextVM {
    _nextVM = nextVM;
}
- (MainTableViewCellVM * (^)(BaseViewControllerVM *))nextVMSet {
    return ^(BaseViewControllerVM *vm) {
        self.nextVMSet = vm;
        
        return self;
    };
}
- (void)setNextStoryboardIDSet:(NSString *)storyboardID {
    _nextStoryboardID = storyboardID;
}
- (MainTableViewCellVM * (^)(NSString *))nextStoryboardIDSet {
    return ^(NSString *storyboardID){
        self.nextStoryboardIDSet = storyboardID;
        
        return self;
    };
}

@end
