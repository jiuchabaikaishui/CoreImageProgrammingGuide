//
//  BasicProcessingViewController.h
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/11/28.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import "BaseViewController.h"
#import "BasicProcessingVM.h"

NS_ASSUME_NONNULL_BEGIN

@interface BasicProcessingViewController : BaseViewController

@property (strong, nonatomic, readonly) BasicProcessingVM *processingVM;

@end

NS_ASSUME_NONNULL_END
