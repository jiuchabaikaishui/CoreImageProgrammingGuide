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
@property (weak, nonatomic) IBOutlet UILabel *minL;
@property (weak, nonatomic) IBOutlet UILabel *maxL;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UIImageView *colorIV;

@property (strong, nonatomic) UIImage *backImage;
@property (strong, nonatomic) UIImage *frontImage;

@end

@implementation ChromaKeyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"21E58PIC58i_1024" ofType:@"jpg"]];
    self.frontImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"017ea858d26364a801219c77d07b5c.jpg@1280w_1l_2o_100sh" ofType:@"jpg"]];
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
        self.maxL.text = [NSString stringWithFormat:@"%.2f", sender.value];
    }
    self.minL.text = [NSString stringWithFormat:@"%.2f", sender.value];
    [self updateImageV];
}
- (IBAction)maxAtion:(UISlider *)sender {
    if (self.minS.value > sender.value) {
        [self.minS setValue:sender.value animated:NO];
        self.minL.text = [NSString stringWithFormat:@"%.2f", sender.value];
    }
    self.maxL.text = [NSString stringWithFormat:@"%.2f", sender.value];
    [self updateImageV];
}

- (void)updateImageV {
    CGFloat min = self.minS.value;
    CGFloat max = self.maxS.value;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CIChromaKey *filter = [[CIChromaKey alloc] init];
        filter.inputImage = [[CIImage alloc] initWithImage:self.frontImage];
        filter.minHueAngle = min;
        filter.maxHueAngle = max;
        CIContext *context = [CIContext context];
        CGImageRef image = [context createCGImage:filter.outputImage fromRect:filter.outputImage.extent];
        UIImage *endImage = [UIImage imageWithCGImage:image];
        CGImageRelease(image);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageV.image = endImage;
        });
    });
}

@end
