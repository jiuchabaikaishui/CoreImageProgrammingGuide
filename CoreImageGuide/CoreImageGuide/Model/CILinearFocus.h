//
//  CILinearFocus.h
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/12/11.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import <CoreImage/CoreImage.h>

NS_ASSUME_NONNULL_BEGIN

@interface CILinearFocus : CIFilter

@property (assign, nonatomic) CGFloat value;
@property (strong, nonatomic) CIImage *inputImage;
@property (assign, nonatomic) CGPoint begin;
@property (assign, nonatomic) CGPoint focus;
@property (assign, nonatomic) CGPoint end;

@end

NS_ASSUME_NONNULL_END
