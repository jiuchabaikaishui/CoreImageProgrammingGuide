//
//  CommonVM.m
//  ThreadingPrograming
//
//  Created by QSP on 2018/7/19.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "QSPViewVM.h"

@implementation QSPViewVM

- (RACCommand *)emptyCommand {
    return [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal empty];
    }];
}
- (RACCommand *)emptyCommandWithEnabled:(RACSignal *)enabledSignal {
    return [[RACCommand alloc] initWithEnabled:enabledSignal signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal empty];
    }];
}

@end
