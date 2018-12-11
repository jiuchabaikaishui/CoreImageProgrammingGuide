//
//  CIPixellateTransition.m
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/12/11.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import "CIPixellateTransition.h"

@implementation CIPixellateTransition

- (CIImage *)outputImage {
    CIFilter *transition = [CIFilter filterWithName:@"CIDissolveTransition"];
    [transition setValue:self.inputImage forKey:kCIInputImageKey];
    [transition setValue:self.tagetImage forKey:kCIInputTargetImageKey];
    [transition setValue:@(self.time) forKey:kCIInputTimeKey];
    
    CGFloat scale = 90*(1 - 2*fabs(self.time - 0.5));
    if (scale > 0) {
        CIFilter *pixellate = [CIFilter filterWithName:@"CIPixellate"];
        [pixellate setValue:transition.outputImage forKey:kCIInputImageKey];
        [pixellate setValue:@(scale) forKey:kCIInputScaleKey];
        
        return pixellate.outputImage;
    }
    
    return transition.outputImage;
}

@end
