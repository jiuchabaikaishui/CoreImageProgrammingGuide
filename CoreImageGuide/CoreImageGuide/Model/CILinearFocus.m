//
//  CILinearFocus.m
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/12/11.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import "CILinearFocus.h"

@implementation CILinearFocus

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.value = 0.8;
        self.begin = CGPointMake(0, 0.25);
        self.focus = CGPointMake(0, 0.5);
        self.end = CGPointMake(0, 0.75);
    }
    return self;
}
- (CIImage *)outputImage {
    CIFilter *line = [CIFilter filterWithName:@"CILinearGradient"];
    CGSize size = self.inputImage.extent.size;
    [line setValue:[CIVector vectorWithX:size.width*self.end.x Y:size.height*self.end.y] forKey:@"inputPoint0"];
    [line setValue:[CIVector vectorWithX:size.width*self.focus.x Y:size.height*self.focus.y] forKey:@"inputPoint1"];
    [line setValue:[CIColor colorWithRed:self.value green:self.value blue:self.value alpha:1] forKey:@"inputColor0"];
    [line setValue:[CIColor colorWithRed:self.value green:self.value blue:self.value alpha:0] forKey:@"inputColor1"];
    
    CIFilter *lineO = [CIFilter filterWithName:@"CILinearGradient"];
    [lineO setValue:[CIVector vectorWithX:size.width*self.begin.x Y:size.height*self.begin.y] forKey:@"inputPoint0"];
    [lineO setValue:[CIVector vectorWithX:size.width*self.focus.x Y:size.height*self.focus.y] forKey:@"inputPoint1"];
    [lineO setValue:[CIColor colorWithRed:self.value green:self.value blue:self.value alpha:1] forKey:@"inputColor0"];
    [lineO setValue:[CIColor colorWithRed:self.value green:self.value blue:self.value alpha:0] forKey:@"inputColor1"];
    
    CIFilter *addition = [CIFilter filterWithName:@"CIAdditionCompositing"];
    [addition setValue:line.outputImage forKey:kCIInputImageKey];
    [addition setValue:lineO.outputImage forKey:kCIInputBackgroundImageKey];
    
    CIFilter *blur = [CIFilter filterWithName:@"CIGaussianBlur"];
    [blur setValue:@(10) forKey:kCIInputRadiusKey];
    [blur setValue:self.inputImage forKey:kCIInputImageKey];
    
    CIFilter *mask = [CIFilter filterWithName:@"CIBlendWithMask"];
    [mask setValue:blur.outputImage forKey:kCIInputImageKey];
    [mask setValue:self.inputImage forKey:kCIInputBackgroundImageKey];
    [mask setValue:addition.outputImage forKey:kCIInputMaskImageKey];
    
    return mask.outputImage;
}

@end
