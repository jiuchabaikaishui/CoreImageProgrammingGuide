//
//  BasicProcessingViewController.m
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/11/28.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import "BasicProcessingViewController.h"

@interface BasicProcessingViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UIButton *resetB;
@property (weak, nonatomic) IBOutlet UIButton *addB;

@end

@implementation BasicProcessingViewController

#pragma mark - 属性方法
- (BasicProcessingVM *)processingVM {
    return (BasicProcessingVM *)self.vm;
}

#pragma mark - 控制器周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - 自定义方法
- (void)bindVM {
    [super bindVM];
    
    self.addB.rac_command = self.processingVM.addCommand;
    [self.processingVM.addCommand.executionSignals subscribeNext:^(id  _Nullable x) {
        CIContext *context = [CIContext context];
        CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"];
        [filter setValue:@(0.8) forKey:kCIInputIntensityKey];
        [filter setValue:[[CIImage alloc] initWithImage:self.imageV.image] forKey:kCIInputImageKey];
        CGImageRef image = [context createCGImage:filter.outputImage fromRect:filter.outputImage.extent];
        self.imageV.image = [UIImage imageWithCGImage:image];
        CGImageRelease(image);
    }];
}

@end
