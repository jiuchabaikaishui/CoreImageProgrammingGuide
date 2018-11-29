//
//  BasicProcessingViewController.m
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/11/28.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import "ProcessingViewController.h"

@interface ProcessingViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UIButton *resetB;
@property (weak, nonatomic) IBOutlet UIButton *addB;

@property (strong, nonatomic) UIImage *currentI;

@end

@implementation ProcessingViewController

#pragma mark - 属性方法
- (ProcessingVM *)processingVM {
    return (ProcessingVM *)self.vm;
}

#pragma mark - 控制器周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentI = self.imageV.image;
    @weakify(self);
    [RACObserve(self.imageV, image) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.resetB.enabled = self.imageV.image != self.currentI;
        self.addB.enabled = self.imageV.image;
    }];
}

#pragma mark - 触摸点击方法
- (IBAction)pictureAction:(UIBarButtonItem *)sender {
    [ConFunc cameraPhotoAlter:self removeAction:^{
        self.currentI = nil;
        self.imageV.image = nil;
    }];
}
- (IBAction)reseAction:(UIButton *)sender {
    self.imageV.image = self.currentI;
}
- (IBAction)addAction:(UIButton *)sender {
    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"];
    [filter setValue:@(0.8) forKey:kCIInputIntensityKey];
    [filter setValue:[[CIImage alloc] initWithImage:self.currentI] forKey:kCIInputImageKey];
    CIContext *context = [CIContext context];
    CGImageRef image = [context createCGImage:filter.outputImage fromRect:filter.outputImage.extent];
    self.imageV.image = [UIImage imageWithCGImage:image];
    CGImageRelease(image);
}

#pragma mark - <UINavigationControllerDelegate,UIImagePickerControllerDelegate>代理方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
    if (!image) {
        image = [info valueForKey:UIImagePickerControllerOriginalImage];
    }
    
    self.currentI = image;
    self.imageV.image = image;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
