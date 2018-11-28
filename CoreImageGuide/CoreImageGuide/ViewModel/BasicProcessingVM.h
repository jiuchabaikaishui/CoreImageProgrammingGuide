//
//  BasicProcessingVM.h
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/11/28.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import "BaseViewControllerVM.h"

NS_ASSUME_NONNULL_BEGIN

@interface BasicProcessingVM : BaseViewControllerVM

@property (strong, nonatomic, readonly) RACCommand *resetCommand;
@property (strong, nonatomic, readonly) RACCommand *addCommand;

@end

NS_ASSUME_NONNULL_END
