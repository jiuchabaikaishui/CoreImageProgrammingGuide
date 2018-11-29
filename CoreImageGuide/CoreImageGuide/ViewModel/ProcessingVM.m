//
//  BasicProcessingVM.m
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/11/28.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import "ProcessingVM.h"

@implementation ProcessingVM

- (instancetype)init {
    if (self = [super init]) {
        _pictureCommand = [self emptyCommand];
        _addCommand = [self emptyCommand];
    }
    
    return self;
}

@end
