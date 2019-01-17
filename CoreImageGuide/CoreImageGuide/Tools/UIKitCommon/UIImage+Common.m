//
//  UIImage+Common.m
//  QRindoMerchant
//
//  Created by 綦帅鹏 on 2018/12/13.
//  Copyright © 2018年 DaXiong. All rights reserved.
//

#import "UIImage+Common.h"

@implementation UIImage (Common)

+ (UIImage *)stretchImageWithNamed:(NSString *)name left:(CGFloat)left top:(CGFloat)top {
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchFromLeft:left top:top];
}
+ (UIImage *)centerStretchImageWithNamed:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    return [image centerStretch];
}
- (UIImage *)centerStretch {
    return [self stretchFromLeft:0.5 top:0.5];
}
- (UIImage *)stretchFromLeft:(CGFloat)left top:(CGFloat)top {
    CGFloat X = self.size.width*left;
    CGFloat Y = self.size.height*top;
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(Y, X, Y, X)];
}
+ (void)dottedLineImageWithSize:(CGSize)size width:(CGFloat)width from:(CGPoint)begin to:(CGPoint)end color:(UIColor *)color lengths:(NSArray<NSNumber *> *)lengths phase:(CGFloat)phase completed:(void (^)(UIImage *image))completedB {
    [self genarateImageWithSize:size draw:^(CGSize size, CGContextRef context) {
        CGContextMoveToPoint(context, begin.x, begin.y);
        CGContextAddLineToPoint(context, end.x, end.y);
        CGFloat arr[lengths.count];
        for (NSInteger index = 0; index < lengths.count; index++) {
            arr[index] = [[lengths objectAtIndex:index] doubleValue];
        }
        CGContextSetLineDash(context, 0, arr, 1);
        CGContextStrokePath(context);
        CGContextSetLineWidth(context, width);
        [color setStroke];
    } completed:^(UIImage *image) {
        if (completedB) {
            completedB(image);
        }
    }];
}
+ (void)imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)radius completed:(void (^)(UIImage *image))completedB {
    [self imageWithColor:color size:size cornerRadius:radius strokeColor:nil strokeWidth:0 completed:completedB];
    [self genarateImageWithSize:size draw:^(CGSize size, CGContextRef context) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:(CGRect){{0, 0}, size} cornerRadius:radius];
        [color setFill];
        [color setStroke];
        [path fill];
    } completed:^(UIImage *image) {
        if (completedB) {
            completedB(image);
        }
    }];
}
+ (void)imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)radius strokeColor:(UIColor *)strokeC strokeWidth:(CGFloat)strokeW completed:(void (^)(UIImage *image))completedB {
    [self genarateImageWithSize:size draw:^(CGSize size, CGContextRef context) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:(CGRect){{0, 0}, size} cornerRadius:radius];
        if (strokeW != 0) {
            [path setLineWidth:strokeW];
        }
        if (color) {
            [color setFill];
            [path fill];
        }
        if (strokeC) {
            [strokeC setStroke];
            [path stroke];
        }
    } completed:^(UIImage *image) {
        if (completedB) {
            completedB(image);
        }
    }];
}
+ (void)genarateImageWithSize:(CGSize)size draw:(void (^)(CGSize size, CGContextRef context))drawB completed:(void (^)(UIImage *image))completedB {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIGraphicsBeginImageContext(size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        if (drawB) {
            drawB(size, context);
        }
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        CGContextRestoreGState(context);
        UIGraphicsEndImageContext();
        if (completedB) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completedB(image);
            });
        }
    });
}

@end
