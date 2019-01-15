//
//  CIOldFilm.m
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/12/11.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import "CIOldFilm.h"

@implementation CIOldFilm

- (CIImage *)outputImage {
    CIFilter *sepia = [CIFilter filterWithName:@"CISepiaTone"];
    [sepia setValue:self.inputImage forKey:kCIInputImageKey];
    [sepia setValue:@(1) forKey:kCIInputIntensityKey];
    
//    if (self.type == CIOldFilmTypeMatrix) {
//        return compose.outputImage;
//    }
//    return sepia.outputImage;
    
    CIFilter *random = [CIFilter filterWithName:@"CIRandomGenerator"];
    
    CIFilter *matrix = [CIFilter filterWithName:@"CIColorMatrix"];
    [matrix setValue:random.outputImage forKey:kCIInputImageKey];
    CIVector *vector = [CIVector vectorWithX:0 Y:1 Z:0 W:0];
    CIVector *biasVector = [CIVector vectorWithX:0 Y:0 Z:0 W:0];
    [matrix setValue:vector forKey:@"inputRVector"];
    [matrix setValue:vector forKey:@"inputGVector"];
    [matrix setValue:vector forKey:@"inputBVector"];
//    [matrix setValue:[CIVector vectorWithX:0 Y:0 Z:0 W:0.3] forKey:@"inputAVector"];
    [matrix setValue:biasVector forKey:@"inputBiasVector"];
    
    CIFilter *compose = [CIFilter filterWithName:@"CISourceOverCompositing"];
    if (self.type == CIOldFilmTypeMatrix) {
        CIFilter *light = [CIFilter filterWithName:@"CIMinimumComponent"];
        [light setValue:random.outputImage forKeyPath:kCIInputImageKey];
        [compose setValue:light.outputImage forKey:kCIInputImageKey];
//        return light.outputImage;
    } else {
        [compose setValue:matrix.outputImage forKey:kCIInputImageKey];
//        return matrix.outputImage;
    }
    [compose setValue:sepia.outputImage forKey:kCIInputBackgroundImageKey];

    CIFilter *transform = [CIFilter filterWithName:@"CIAffineTransform"];
    [transform setValue:random.outputImage forKey:kCIInputImageKey];
    [transform setValue:[NSValue valueWithCGAffineTransform:CGAffineTransformMakeScale(1.5, 25)] forKey:kCIInputTransformKey];
    
//    return transform.outputImage;

    CIFilter *cyan = [CIFilter filterWithName:@"CIColorMatrix"];
    [cyan setValue:transform.outputImage forKey:kCIInputImageKey];
    vector = [CIVector vectorWithX:4 Y:0 Z:0 W:0];
    CIVector *otherVector = [CIVector vectorWithX:0 Y:0 Z:0 W:0];
    biasVector = [CIVector vectorWithX:0 Y:1 Z:1 W:1];
    [cyan setValue:vector forKey:@"inputRVector"];
    [cyan setValue:otherVector forKey:@"inputGVector"];
    [cyan setValue:otherVector forKey:@"inputBVector"];
    [cyan setValue:otherVector forKey:@"inputAVector"];
    [cyan setValue:biasVector forKey:@"inputBiasVector"];
    
//    return cyan.outputImage;

    CIFilter *dark = [CIFilter filterWithName:@"CIMinimumComponent"];
    [dark setValue:cyan.outputImage forKeyPath:kCIInputImageKey];
//    return dark.outputImage;

    CIFilter *mCompose = [CIFilter filterWithName:@"CIMultiplyCompositing"];
    [mCompose setValue:dark.outputImage forKey:kCIInputImageKey];
    [mCompose setValue:compose.outputImage forKey:kCIInputBackgroundImageKey];
    
    return mCompose.outputImage;
}//

@end
