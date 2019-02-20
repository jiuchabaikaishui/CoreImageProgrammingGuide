//
//  PaintView.m
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2019/1/31.
//  Copyright © 2019年 綦帅鹏. All rights reserved.
//

#import "PaintView.h"

@interface PaintView ()

@property (strong, nonatomic) CIImageAccumulator *imageAccumulator;
@property (strong, nonatomic) CIFilter *brushF;
@property (strong, nonatomic) CIFilter *compositeF;
@property (strong, nonatomic) CIFilter *backgroundF;

@end

@implementation PaintView
- (CIFilter *)backgroundF {
    if (_backgroundF == nil) {
        _backgroundF = [CIFilter filterWithName:@"CIConstantColorGenerator" keysAndValues:@"inputColor", [CIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f], nil];
    }
    
    return _backgroundF;
}
- (void)setBrushSize:(NSInteger)brushSize {
    _brushSize = brushSize;
    [self.brushF setValue:@(brushSize) forKey:@"inputRadius1"];
}
- (void)setBrushColor:(UIColor *)brushColor {
    _brushColor = brushColor;
    [self.brushF setValue:[CIColor colorWithCGColor:brushColor.CGColor] forKey:@"inputColor0"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self defaultValue];
    }
    
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self defaultValue];
    }
    
    return self;
}
- (void)defaultValue {
    self.brushF = [CIFilter filterWithName: @"CIRadialGradient" keysAndValues:
                   @"inputColor1", [CIColor colorWithRed:0.0f green:0.0f
                                                    blue:0.0f alpha:0.0f], @"inputRadius0", @(0.0f), nil];
    self.brushColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
    self.brushSize = 2;
    self.compositeF = [CIFilter filterWithName: @"CISourceOverCompositing"];
}

- (void)clearScreen {
    self.backgroundF = nil;
    [self.imageAccumulator setImage:self.backgroundF.outputImage];
    [self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self touchesMoved:touches withEvent:event];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint loction = [touch locationInView:self];
    NSLog(@"----L:%@----", NSStringFromCGPoint(loction));
    
    [self.brushF setValue:[CIVector vectorWithX:loction.x Y:loction.y] forKey:@"inputCenter"];
    
    [self.compositeF setValue:self.brushF.outputImage forKey:@"inputImage"];
    [self.compositeF setValue:self.imageAccumulator.image forKey:@"inputBackgroundImage"];

    [self.imageAccumulator setImage:self.compositeF.outputImage dirtyRect:self.bounds];
    
    [self setNeedsDisplay];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self touchesBegan:touches withEvent:event];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    //imageAccumulator存在，并且尺寸没有变化，直接返回
    if ((self.imageAccumulator != nil) && (CGRectEqualToRect (self.bounds, [self.imageAccumulator extent]))) {
        return;
    }
    
    CIImageAccumulator *accumulator = [[CIImageAccumulator alloc] initWithExtent:self.bounds format:kCIFormatRGBA8];

    if (self.imageAccumulator) {
        self.backgroundF = [CIFilter filterWithName:@"CISourceOverCompositing"
                            keysAndValues:@"inputImage", [self.imageAccumulator image],
                  @"inputBackgroundImage", [accumulator image], nil];
        [accumulator setImage:self.backgroundF.outputImage];
    } else {
        [accumulator setImage:self.backgroundF.outputImage];
    }

    self.imageAccumulator = accumulator;
}
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    CGContextRef cgContext = UIGraphicsGetCurrentContext();
    CIContext *context = [CIContext contextWithCGContext:cgContext options:nil];
    [context drawImage:self.imageAccumulator.image inRect:rect fromRect:rect];
}

@end
