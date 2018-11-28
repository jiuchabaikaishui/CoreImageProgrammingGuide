//
//  CommonVM.h
//  ThreadingPrograming
//
//  Created by QSP on 2018/7/19.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveObjC.h"

@interface QSPViewVM : NSObject

typedef void (^QSPSetDataMBlock)(id);

- (RACCommand *)emptyCommand;
- (RACCommand *)emptyCommandWithEnabled:(RACSignal *)enabledSignal;

@end
