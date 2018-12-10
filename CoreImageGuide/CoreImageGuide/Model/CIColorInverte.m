//
//  CIColorInvert.m
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/12/7.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import "CIColorInverte.h"

@implementation CIColorInverte

- (CIImage *)outputImage {
    CIFilter *filter = [CIFilter filterWithName:@"CIColorMatrix"
                            withInputParameters: @{
                                                   kCIInputImageKey: self.inputImage,
                                                   @"inputRVector": [CIVector vectorWithX:-1 Y:0 Z:0],
                                                   @"inputGVector": [CIVector vectorWithX:0 Y:-1 Z:0],
                                                   @"inputBVector": [CIVector vectorWithX:0 Y:0 Z:-1],
                                                   @"inputBiasVector": [CIVector vectorWithX:1 Y:1 Z:1],
                                                   }];
    return [[filter.outputImage imageByClampingToExtent] imageByCroppingToRect:self.inputImage.extent];
}

@end
