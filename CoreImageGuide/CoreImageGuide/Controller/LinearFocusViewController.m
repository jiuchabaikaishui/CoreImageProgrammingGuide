//
//  LinearFocusViewController.m
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/12/11.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import "LinearFocusViewController.h"
#import "CILinearFocus.h"

@interface LinearFocusViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (strong, nonatomic) UIImage *currentI;

@end

@implementation LinearFocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentI = self.imageV.image;
    [self updateImageV];
}
- (IBAction)resetAtion:(UIBarButtonItem *)sender {
    if (self.imageV.image == self.currentI) {
        [sender setTitle:@"重置"];
        [self updateImageV];
    } else {
        self.imageV.image = self.currentI;
        [sender setTitle:@"聚焦"];
    }
}
- (void)updateImageV {
    CILinearFocus *filter = [[CILinearFocus alloc] init];
    filter.inputImage = [[CIImage alloc] initWithImage:self.imageV.image];
    CIContext *context = [CIContext context];
    CIImage *output = filter.outputImage;
    CGImageRef image = [context createCGImage:output fromRect:filter.inputImage.extent];
    UIImage *endImage = [UIImage imageWithCGImage:image];
    CGImageRelease(image);
    self.imageV.image = endImage;
}

@end
