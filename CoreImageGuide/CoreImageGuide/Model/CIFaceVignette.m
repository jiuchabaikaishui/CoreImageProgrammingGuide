//
//  CIFaceVignette.m
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/12/10.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import "CIFaceVignette.h"

@implementation CIFaceVignette

- (instancetype)init {
    if (self = [super init]) {
        self.faceOffset = 50;
        self.edgeOffset = 0;
        self.faceColor = [CIColor colorWithRed:1 green:1 blue:1 alpha:0];
        self.edgeColor = [CIColor colorWithRed:1 green:1 blue:1 alpha:1];
    }
    
    return self;
}

- (CIImage *)outputImage {
    if (self.inputImage) {
        CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeFace context:[CIContext context] options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
        id orientation = [[self.inputImage properties] valueForKey: CFBridgingRelease(kCGImagePropertyOrientation)];
        NSArray *features = [detector featuresInImage:self.inputImage options:orientation ? @{CIDetectorImageOrientation: orientation} : nil];
        if (features && features.count > 0) {
            CIFeature *feature = [features firstObject];
            
            CIFilter *filter = [CIFilter filterWithName:@"CIRadialGradient"];
            [filter setValue:@((self.inputImage.extent.size.width > self.inputImage.extent.size.height ? self.inputImage.extent.size.width : self.inputImage.extent.size.height) + self.edgeOffset) forKey:@"inputRadius0"];
            [filter setValue:@(feature.bounds.size.height + self.faceOffset) forKey:@"inputRadius1"];
            [filter setValue:self.edgeColor forKey:@"inputColor0"];
            [filter setValue:self.faceColor forKey:@"inputColor1"];
            [filter setValue:[CIVector vectorWithX:feature.bounds.origin.x + feature.bounds.size.width/2 Y:feature.bounds.origin.y + feature.bounds.size.height/2] forKey:@"inputCenter"];
            
            CIFilter *compose = [CIFilter filterWithName:@"CISourceOverCompositing"];
            [compose setValue:filter.outputImage forKey:kCIInputImageKey];
            [compose setValue:self.inputImage forKey:kCIInputBackgroundImageKey];
            
            return compose.outputImage;
        }
    }
    
    return nil;
}

@end
