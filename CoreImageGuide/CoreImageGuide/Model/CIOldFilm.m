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
    
//    CIFilter *matrix = [CIFilter filterWithName:@"CIColorMatrix"];
//    [matrix setValue:<#(nullable id)#> forKey:<#(nonnull NSString *)#>];
    
    return sepia.outputImage;
}//

@end
