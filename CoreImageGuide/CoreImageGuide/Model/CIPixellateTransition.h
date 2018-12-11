//
//  CIPixellateTransition.h
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/12/11.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import <CoreImage/CoreImage.h>

NS_ASSUME_NONNULL_BEGIN

@interface CIPixellateTransition : CIFilter

@property (strong, nonatomic) CIImage *inputImage;
@property (strong, nonatomic) CIImage *tagetImage;
@property (assign, nonatomic) CGFloat time;

@end

NS_ASSUME_NONNULL_END
