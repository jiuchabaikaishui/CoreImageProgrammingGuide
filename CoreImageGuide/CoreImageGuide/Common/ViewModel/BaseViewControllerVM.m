//
//  BaseVM.m
//  Review
//
//  Created by 綦帅鹏 on 2018/11/13.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "BaseViewControllerVM.h"

@implementation BaseViewControllerVM

- (void)dealloc {
    DebugLog(@"%@销毁了", NSStringFromClass(self.class));
}
- (void)setTitleSet:(NSString *)title {
    _title = title;
}
- (BaseViewControllerVM * (^)(NSString *))titleSet {
    @weakify(self)
    return ^(NSString *title) {
        @strongify(self)
        self.titleSet = title;
        
        return self;
    };
}

@end
