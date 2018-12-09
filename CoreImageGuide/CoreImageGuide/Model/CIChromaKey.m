//
//  CIChromaKey.m
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/12/7.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import "CIChromaKey.h"

@implementation CIChromaKey

static void RGBtoHSV( float r, float g, float b, float *h, float *s, float *v )
{
    float min, max, delta;
    min = MIN( r, MIN( g, b ));
    max = MAX( r, MAX( g, b ));
    *v = max;               // v
    delta = max - min;
    if( max != 0 )
        *s = delta / max;       // s
    else {
        // r = g = b = 0        // s = 0, v is undefined
        *s = 0;
        *h = 0;
        return;
    }
    if( r == max )
        *h = (g - b)/delta;     // between yellow & magenta
    else if( g == max )
        *h = 2 + (b - r)/delta; // between cyan & yellow
    else
        *h = 4 + (r - g)/delta; // between magenta & cyan
    *h *= 60;               // degrees
    if( *h < 0 )
        *h += 360;
    
    *h /= 360;
}
- (CIImage *)outputImage {
    unsigned int size = 256;
    float *cubeData = malloc(size*size*size*sizeof(float)*4);
    float rgb[3], hsv[3], *c = cubeData;
    for (int b = 0; b < size; b++) {
        rgb[2] = b/(double)size;
        for (int g = 0; g < size; g++) {
            rgb[1] = g/(double)size;
            for (int r = 0; r < size; r++) {
                rgb[0] = r/(double)size;
                RGBtoHSV(rgb[0], rgb[1], rgb[2], hsv, hsv + 1, hsv + 2);
                float alpha = hsv[0] > self.minHueAngle && hsv[0] < self.maxHueAngle ? 1.0f : 0.0f;
                c[0] = rgb[0]*alpha;
                c[1] = rgb[1]*alpha;
                c[2] = rgb[2]*alpha;
                c[3] = alpha;
                c += 4;
            }
        }
    }
    
    NSData *data = [NSData dataWithBytesNoCopy:cubeData length:size*size*size*sizeof(float)*4 freeWhenDone:YES];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorCube"];
    [filter setValue:data forKey:@"inputCubeData"];
    [filter setValue:self.inputImage forKey:kCIInputImageKey];
    return filter.outputImage;
}

@end
