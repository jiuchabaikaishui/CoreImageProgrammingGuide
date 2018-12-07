//
//  ChromaKeyViewController.m
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/12/7.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import "ChromaKeyViewController.h"
#import "CIChromaKey.h"

@interface ChromaKeyViewController ()
@property (weak, nonatomic) IBOutlet UISlider *minS;
@property (weak, nonatomic) IBOutlet UISlider *maxS;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UIImageView *colorIV;

@property (strong, nonatomic) UIImage *backImage;
@property (strong, nonatomic) UIImage *frontImage;

@end

@implementation ChromaKeyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"21E58PIC58i_1024" ofType:@"jpg"]];
    self.frontImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"21E58PIC58i_1024" ofType:@"jpg"]];
    [self updateImageV];
    
    CGSize size = self.colorIV.frame.size;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIGraphicsBeginImageContext(size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        for (int i = 0; i < size.width; i++) {
            CGContextMoveToPoint(context, i, 0);
            CGContextAddLineToPoint(context, i, size.width);
            UIColor *color = [UIColor colorWithHue:i/size.width saturation:1 brightness:1 alpha:1];
            [color setStroke];
            CGContextSetLineWidth(context, 1);
            CGContextStrokePath(context);
        }
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        dispatch_async(dispatch_get_main_queue(), ^{
            self.colorIV.image = image;
        });
    });
}
- (IBAction)backAction:(UIBarButtonItem *)sender {
}
- (IBAction)frontAction:(UIBarButtonItem *)sender {
}
- (IBAction)minAction:(UISlider *)sender {
    if (self.maxS.value < sender.value) {
        [self.maxS setValue:sender.value animated:NO];
    }
    [self updateImageV];
}
- (IBAction)maxAtion:(UISlider *)sender {
    if (self.minS.value > sender.value) {
        [self.minS setValue:sender.value animated:NO];
    }
    [self updateImageV];
}

- (void)updateImageV {
    CIChromaKey *filter = [[CIChromaKey alloc] init];
    filter.inputImage = [[CIImage alloc] initWithImage:self.frontImage];
    filter.minHueAngle = self.minS.value;
    filter.maxHueAngle = self.maxS.value;
    CIContext *context = [CIContext context];
    CGImageRef image = [context createCGImage:filter.outputImage fromRect:filter.outputImage.extent];
    self.imageV.image = [UIImage imageWithCGImage:image];
    CGImageRelease(image);
}

@end
