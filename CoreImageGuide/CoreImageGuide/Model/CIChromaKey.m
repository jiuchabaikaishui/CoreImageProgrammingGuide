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
}
- (CIImage *)outputImage {
    //分配内存
    unsigned int size = 64;
    float *cubeData = malloc(size*size*size*sizeof(float)*4);
    float rgb[3], hsv[3], *c = cubeData;
    //使用从0到1的简单渐变填充多维数据集
    for (int b = 0; b < size; b++) {
        rgb[2] = b/(double)size;//蓝色值
        for (int g = 0; g < size; g++) {
            rgb[1] = g/(double)size;//绿色值
            for (int r = 0; r < size; r++) {
                rgb[0] = r/(double)size;//红色值
                //将RGB转换为HSV
                //您可以在Internet上找到公开可用的rgbToHSV功能
                RGBtoHSV(rgb[0], rgb[1], rgb[2], hsv, hsv + 1, hsv + 2);
                //使用色调值确定要透明的内容
                //最小和最大色调角取决于
                //要删除的颜色
                float alpha = hsv[0] > self.minHueAngle && hsv[0] < self.maxHueAngle ? 0.0f : 1.0f;
                //计算多维数据集的预乘alpha值
                c[0] = rgb[0]*alpha;
                c[1] = rgb[1]*alpha;
                c[2] = rgb[2]*alpha;
                c[3] = alpha;
                c += 4;//将指针前进到内存中以获取下一个颜色值
            }
        }
    }
    
    //使用多维数据集数据创建内存
    NSData *data = [NSData dataWithBytesNoCopy:cubeData length:size*size*size*sizeof(float)*4 freeWhenDone:YES];
    CIFilter *colorCube = [CIFilter filterWithName:@"CIColorCube"];
    [colorCube setValue:@(size) forKey:@"inputCubeDimension"];
    //设置多维数据集的数据
    [colorCube setValue:data forKey:@"inputCubeData"];
    [colorCube setValue:self.inputImage forKey:kCIInputImageKey];
    
    CIFilter *compose = [CIFilter filterWithName:@"CISourceOverCompositing"];
    [compose setValue:colorCube.outputImage forKey:kCIInputImageKey];
    [compose setValue:self.backImage forKey:kCIInputBackgroundImageKey];
    
    return compose.outputImage;
}

@end
