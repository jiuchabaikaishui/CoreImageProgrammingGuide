//
//  FaceVignetteViewController.m
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/12/10.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import "FaceVignetteViewController.h"
#import "CIFaceVignette.h"

@interface FaceVignetteViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end

@implementation FaceVignetteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateImageV];
}

- (IBAction)pictureAction:(UIBarButtonItem *)sender {
    [ConFunc cameraPhotoAlter:self removeAction:self.imageV.image ? ^{
        self.imageV.image = nil;
    } : nil];
}
- (void)updateImageV {
    CIImage *sourceI = [[CIImage alloc] initWithImage:self.imageV.image];
    CIFaceVignette *filter = [[CIFaceVignette alloc] init];
    filter.inputImage = sourceI;
    CIContext *context = [CIContext context];
    CIImage *output = filter.outputImage;
    CGImageRef image = [context createCGImage:output fromRect:sourceI.extent];
    UIImage *endImage = [UIImage imageWithCGImage:image];
    CGImageRelease(image);
    self.imageV.image = endImage;
}

#pragma mark - <UINavigationControllerDelegate,UIImagePickerControllerDelegate>代理方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *image = picker.allowsEditing ? [info valueForKey:UIImagePickerControllerEditedImage] : [info valueForKey:UIImagePickerControllerOriginalImage];
    
    self.imageV.image = image;
    [self updateImageV];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
