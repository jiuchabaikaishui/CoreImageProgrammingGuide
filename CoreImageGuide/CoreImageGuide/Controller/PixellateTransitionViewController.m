//
//  PixellateTransitionViewController.m
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/12/11.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import "PixellateTransitionViewController.h"
#import "CIPixellateTransition.h"

@interface PixellateTransitionViewController ()
@property (weak, nonatomic) IBOutlet UISlider *timeS;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (strong, nonatomic) UIImage *currentI;
@property (strong, nonatomic) dispatch_queue_t queue;
@property (assign, nonatomic) float time;

@end

@implementation PixellateTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentI = self.imageV.image;
    self.queue = dispatch_queue_create("PixellateTransitionQueue", DISPATCH_QUEUE_SERIAL);
    [self updateImageV];
    
    @weakify(self);
    [[RACObserve(self, time) throttle:0.1] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self updateImageV];
    }];
}
- (IBAction)timeAction:(UISlider *)sender {
    self.time = sender.value;
    self.timeL.text = [NSString stringWithFormat:@"%.2f", sender.value];
}
- (void)updateImageV {
    dispatch_async(self.queue, ^{
        CIPixellateTransition *filter = [[CIPixellateTransition alloc] init];
        filter.inputImage = [[CIImage alloc] initWithImage:self.currentI];
        filter.tagetImage = [[CIImage alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"21E58PIC58i_1024" ofType:@"jpg"]]];
        filter.time = self.time;
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
