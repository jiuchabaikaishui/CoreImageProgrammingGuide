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
    
    CIFilter *random = [CIFilter filterWithName:@"CIRandomGenerator"];
    
    if (self.type == CIOldFilmTypeMatrix) {
        CIFilter *matrix = [CIFilter filterWithName:@"CIColorMatrix"];
        [matrix setValue:random.outputImage forKey:kCIInputImageKey];
        CIVector *vector = [CIVector vectorWithX:0 Y:1 Z:0 W:0];
        CIVector *biasVector = [CIVector vectorWithX:0 Y:0 Z:0 W:0];
        [matrix setValue:[CIVector vectorWithX:1 Y:0 Z:0 W:0] forKey:@"inputRVector"];
        [matrix setValue:[CIVector vectorWithX:0 Y:1 Z:0 W:0] forKey:@"inputGVector"];
        [matrix setValue:[CIVector vectorWithX:0 Y:0 Z:1 W:0] forKey:@"inputBVector"];
        [matrix setValue:vector forKey:@"inputRVector"];
        [matrix setValue:vector forKey:@"inputGVector"];
        [matrix setValue:vector forKey:@"inputBVector"];
        [matrix setValue:biasVector forKey:@"inputBiasVector"];
        
        return matrix.outputImage;
    }
    
//    CIFilter *compose = [CIFilter filterWithName:@"CISourceOverCompositing"];
//    [compose setValue:matrix.outputImage forKey:kCIInputImageKey];
//    [compose setValue:sepia.outputImage forKey:kCIInputBackgroundImageKey];

//    CIFilter *transform = [CIFilter filterWithName:@"CIAffineTransform"];
//    [transform setValue:random.outputImage forKey:kCIInputImageKey];
//    [transform setValue:[NSValue valueWithCGAffineTransform:CGAffineTransformMakeScale(2.5, 25)] forKey:kCIInputTransformKey];
//
//    CIFilter *cyan = [CIFilter filterWithName:@"CIColorMatrix"];
//    [cyan setValue:transform.outputImage forKey:kCIInputImageKey];
//    vector = [CIVector vectorWithX:4 Y:0 Z:0 W:0];
//    otherVector = [CIVector vectorWithX:0 Y:0 Z:0 W:0];
//    biasVector = [CIVector vectorWithX:0 Y:1 Z:1 W:1];
//    [cyan setValue:vector forKey:@"inputRVector"];
//    [cyan setValue:otherVector forKey:@"inputGVector"];
//    [cyan setValue:otherVector forKey:@"inputBVector"];
//    [cyan setValue:otherVector forKey:@"inputAVector"];
//    [cyan setValue:biasVector forKey:@"inputBiasVector"];
//
//    CIFilter *dark = [CIFilter filterWithName:@"CIMinimumComponent"];
//    [dark setValue:cyan.outputImage forKeyPath:kCIInputImageKey];
//
//    CIFilter *mCompose = [CIFilter filterWithName:@"CIMultiplyCompositing"];
//    [mCompose setValue:dark.outputImage forKey:kCIInputImageKey];
//    [mCompose setValue:compose.outputImage forKey:kCIInputBackgroundImageKey];
    
    return random.outputImage;
}//

@end
