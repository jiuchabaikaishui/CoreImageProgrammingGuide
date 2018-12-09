//
//  CIColorInvert.h
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/12/7.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import <CoreImage/CoreImage.h>

NS_ASSUME_NONNULL_BEGIN

@interface CIColorInverte : CIFilter

@property (strong, nonatomic) CIImage *inputImage;

@end

NS_ASSUME_NONNULL_END
