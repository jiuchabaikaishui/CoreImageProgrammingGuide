//
//  AnonymousFacesViewController.m
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/12/11.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import "AnonymousFacesViewController.h"
#import "CIAnonymousFaces.h"

@interface AnonymousFacesViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (strong, nonatomic) UIImage *currentI;

@end

@implementation AnonymousFacesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentI = self.imageV.image;
    [self updateImageV];
}
- (IBAction)reset:(UIBarButtonItem *)sender {
    if (self.imageV.image == self.currentI) {
        [sender setTitle:@"重置"];
        [self updateImageV];
    } else {
        self.imageV.image = self.currentI;
        [sender setTitle:@"马赛克"];
    }
}
- (void)updateImageV {
    CIAnonymousFaces *filter = [[CIAnonymousFaces alloc] init];
    filter.inputImage = [[CIImage alloc] initWithImage:self.imageV.image];
    CIContext *context = [CIContext context];
    CIImage *output = filter.outputImage;
    CGImageRef image = [context createCGImage:output fromRect:filter.inputImage.extent];
    UIImage *endImage = [UIImage imageWithCGImage:image];
    CGImageRelease(image);
    self.imageV.image = endImage;
}

@end
