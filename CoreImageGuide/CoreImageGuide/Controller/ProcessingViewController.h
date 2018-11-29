//
//  BasicProcessingViewController.h
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/11/28.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import "BaseViewController.h"
#import "ProcessingVM.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProcessingViewController : BaseViewController

@property (strong, nonatomic, readonly) ProcessingVM *processingVM;

@end

NS_ASSUME_NONNULL_END
