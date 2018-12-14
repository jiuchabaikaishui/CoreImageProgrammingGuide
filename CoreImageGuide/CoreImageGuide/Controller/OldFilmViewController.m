//
//  OldFilmViewController.m
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/12/12.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import "OldFilmViewController.h"
#import "CIOldFilm.h"

@interface OldFilmViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (strong, nonatomic) UIImage *currentI;
@property (assign, nonatomic) CIOldFilmType type;

@end

@implementation OldFilmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.imageV.backgroundColor = [UIColor blackColor];
    self.currentI = self.imageV.image;
    [self updateImageV];
}
- (IBAction)pictureAction:(UIBarButtonItem *)sender {
    if (self.type == CIOldFilmTypeRandom) {
        self.type = CIOldFilmTypeMatrix;
    } else if (self.type == CIOldFilmTypeMatrix) {
        self.type = CIOldFilmTypeRandom;
    }
    
    
    [self updateImageV];
}
- (void)updateImageV {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CIOldFilm *filter = [[CIOldFilm alloc] init];
        filter.inputImage = [[CIImage alloc] initWithImage:self.currentI];
        filter.type = self.type;
        CIContext *context = [CIContext context];
        CIImage *output = filter.outputImage;
        CGImageRef image = [context createCGImage:output fromRect:filter.inputImage.extent];
        UIImage *endImage = [UIImage imageWithCGImage:image];
        CGImageRelease(image);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageV.image = endImage;
        });
    });
}

@end
