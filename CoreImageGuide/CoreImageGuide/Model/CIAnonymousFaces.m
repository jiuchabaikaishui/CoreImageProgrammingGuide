//
//  CIAnonymousFaces.m
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/12/11.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import "CIAnonymousFaces.h"

@implementation CIAnonymousFaces

- (CIImage *)outputImage {
    CIFilter *pixellate = [CIFilter filterWithName:@"CIPixellate"];
    [pixellate setValue:self.inputImage forKey:kCIInputImageKey];
    [pixellate setValue:@(MAX(self.inputImage.extent.size.width, self.inputImage.extent.size.height)/60) forKey:kCIInputScaleKey];
    
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeFace context:[CIContext context] options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
    id orientation = [[self.inputImage properties] valueForKey: CFBridgingRelease(kCGImagePropertyOrientation)];
    NSArray *features = [detector featuresInImage:self.inputImage options:orientation ? @{CIDetectorImageOrientation: orientation} : nil];
    CIImage *maskI;
    for (CIFeature *feature in features) {
        CGPoint center = CGPointMake(feature.bounds.origin.x + feature.bounds.size.width/2.0, feature.bounds.origin.y + feature.bounds.size.height/2.0);
        CGFloat r = (feature.bounds.size.width + feature.bounds.size.height)/2;
        CIFilter *radial = [CIFilter filterWithName:@"CIRadialGradient"];
        [radial setValue:@(r) forKey:@"inputRadius0"];
        [radial setValue:@(r + 1) forKey:@"inputRadius1"];
        [radial setValue:[CIColor colorWithRed:1 green:1 blue:1 alpha:1] forKey:@"inputColor0"];
        [radial setValue:[CIColor colorWithRed:0 green:0 blue:0 alpha:0] forKey:@"inputColor1"];
        [radial setValue:[CIVector vectorWithX:center.x Y:center.y] forKey:kCIInputCenterKey];
        if (maskI) {
            CIFilter *compose = [CIFilter filterWithName:@"CISourceOverCompositing"];
            [compose setValue:maskI forKey:kCIInputBackgroundImageKey];
            [compose setValue:radial.outputImage forKey:kCIInputImageKey];
            maskI = [compose.outputImage imageByCroppingToRect:self.inputImage.extent];
        } else {
            maskI = radial.outputImage;
        }
    }
    
    if (maskI) {
        CIFilter *mask = [CIFilter filterWithName:@"CIBlendWithMask"];
        [mask setValue:pixellate.outputImage forKey:kCIInputImageKey];
        [mask setValue:self.inputImage forKey:kCIInputBackgroundImageKey];
        [mask setValue:maskI forKey:kCIInputMaskImageKey];
        return mask.outputImage;
    }
    
    return nil;
}

@end
