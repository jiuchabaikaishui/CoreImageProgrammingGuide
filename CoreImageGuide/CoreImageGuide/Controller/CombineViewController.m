//
//  ContactViewController.m
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/11/29.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import "CombineViewController.h"

@interface CombineViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UIButton *resetB;
@property (weak, nonatomic) IBOutlet UIButton *colorB;
@property (weak, nonatomic) IBOutlet UIButton *bloomB;
@property (weak, nonatomic) IBOutlet UIButton *combineB;

@property (strong, nonatomic) UIImage *currentI;

@end

@implementation CombineViewController

#pragma mark - 控制器周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentI = self.imageV.image;
    @weakify(self);
    [RACObserve(self.imageV, image) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.resetB.enabled = self.imageV.image != self.currentI;
        self.colorB.enabled = self.imageV.image;
        self.bloomB.enabled = self.imageV.image;
        self.combineB.enabled = self.imageV.image;
    }];
}

#pragma mark - 触摸点击方法
- (IBAction)pictureAction:(UIBarButtonItem *)sender {
    [ConFunc cameraPhotoAlter:self removeAction:self.currentI ? ^{
        self.currentI = nil;
        self.imageV.image = nil;
    } : nil];
}
- (IBAction)resetAction:(UIButton *)sender {
    self.imageV.image = self.currentI;
}
- (IBAction)colorAction:(UIButton *)sender {
    CIFilter *filter = [CIFilter filterWithName:@"CIPhotoEffectProcess" withInputParameters:@{kCIInputImageKey: [[CIImage alloc] initWithImage:self.currentI]}];
    CIContext *context = [CIContext context];
    CGImageRef image = [context createCGImage:filter.outputImage fromRect:filter.outputImage.extent];
    self.imageV.image = [UIImage imageWithCGImage:image];
    CGImageRelease(image);
}
- (IBAction)bloomAction:(UIButton *)sender {
    CIImage *sourceI = [[CIImage alloc] initWithImage:self.currentI];
    CIFilter *filter = [CIFilter filterWithName:@"CIBloom" withInputParameters:@{kCIInputImageKey:sourceI.imageByClampingToExtent, kCIInputRadiusKey: @(10), kCIInputIntensityKey: @(1)}];
    CIContext *context = [CIContext context];
    CGImageRef image = [context createCGImage:[filter.outputImage imageByCroppingToRect:sourceI.extent] fromRect:sourceI.extent];
    self.imageV.image = [UIImage imageWithCGImage:image];
    CGImageRelease(image);
}
- (IBAction)combine:(UIButton *)sender {
    CIImage *sourceI = [[CIImage alloc] initWithImage:self.currentI];
    CIFilter *filter = [CIFilter filterWithName:@"CIPhotoEffectProcess" withInputParameters:@{kCIInputImageKey: sourceI}];
    CIImage *ciImage = [filter.outputImage.imageByClampingToExtent imageByApplyingFilter:@"CIBloom" withInputParameters:@{kCIInputRadiusKey: @(10), kCIInputIntensityKey: @(1.0)}];
    CIContext *context = [CIContext context];
    CGImageRef image = [context createCGImage:[ciImage imageByCroppingToRect:sourceI.extent] fromRect:sourceI.extent];
    self.imageV.image = [UIImage imageWithCGImage:image];
    CGImageRelease(image);
}

#pragma mark - <UINavigationControllerDelegate,UIImagePickerControllerDelegate>代理方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *image = picker.allowsEditing ? [info valueForKey:UIImagePickerControllerEditedImage] : [info valueForKey:UIImagePickerControllerOriginalImage];
    
    self.currentI = image;
    self.imageV.image = image;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
