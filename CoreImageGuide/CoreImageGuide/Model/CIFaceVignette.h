//
//  CIFaceVignette.h
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/12/10.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import <CoreImage/CoreImage.h>

NS_ASSUME_NONNULL_BEGIN

@interface CIFaceVignette : CIFilter

@property (strong, nonatomic) CIImage *inputImage;
@property (assign, nonatomic) CGFloat faceOffset;
@property (assign, nonatomic) CGFloat edgeOffset;
@property (strong, nonatomic) CIColor *faceColor;
@property (strong, nonatomic) CIColor *edgeColor;

@end

NS_ASSUME_NONNULL_END
