//
//  BasicProcessingVM.m
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/11/28.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import "BasicProcessingVM.h"

@implementation BasicProcessingVM

- (instancetype)init {
    if (self = [super init]) {
        _resetCommand = [self emptyCommand];
        _addCommand = [self emptyCommand];
    }
    
    return self;
}

@end
