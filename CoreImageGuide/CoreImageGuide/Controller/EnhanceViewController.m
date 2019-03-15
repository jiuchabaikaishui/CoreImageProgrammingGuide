//
//  EnhanceViewController.m
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/12/4.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import "EnhanceViewController.h"

@interface EnhanceViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UIButton *resetB;
@property (weak, nonatomic) IBOutlet UIButton *enhanceB;

@property (strong, nonatomic) UIImage *currentI;

@end

@implementation EnhanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentI = self.imageV.image;
    @weakify(self);
    [RACObserve(self.imageV, image) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.resetB.enabled = self.imageV.image != self.currentI;
        self.enhanceB.enabled = self.imageV.image && self.imageV.image == self.currentI;
    }];
}
- (IBAction)pictureAction:(UIBarButtonItem *)sender {
    [ConFunc cameraPhotoAlter:self removeAction:self.currentI ? ^{
        self.currentI = nil;
        self.imageV.image = nil;
    } : nil];
}
- (IBAction)resetAction:(UIButton *)sender {
    self.imageV.image = self.currentI;
}
- (IBAction)enhanceAction:(UIButton *)sender {
    CIImage *image = [[CIImage alloc] initWithImage:self.currentI];
    id orientation = [[image properties] valueForKey:CFBridgingRelease(kCGImagePropertyOrientation)];
    NSArray *adjustments = [image autoAdjustmentFiltersWithOptions:orientation ? @{CIDetectorImageOrientation: orientation} : nil];
    if (adjustments && adjustments.count) {
        for (CIFilter *filter in adjustments) {
            [filter setValue:image forKey:kCIInputImageKey];
            image = filter.outputImage;
        }
        
        CIContext *context = [CIContext context];
        CGImageRef imageCG = [context createCGImage:image fromRect:image.extent];
        self.imageV.image = [UIImage imageWithCGImage:imageCG];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"没有图像增强可用" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
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
