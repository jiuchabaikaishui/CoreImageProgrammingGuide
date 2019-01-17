//
//  OldFilmViewController.m
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/12/12.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import "OldFilmViewController.h"
#import "CIOldFilm.h"
#import <OpenGLES/OpenGLESAvailability.h>

@interface OldFilmViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
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
    [ConFunc cameraPhotoAlter:self removeAction:self.imageV.image ? ^{
        self.imageV.image = nil;
    } : nil];
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

#pragma mark - <UINavigationControllerDelegate,UIImagePickerControllerDelegate>代理方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *image = picker.allowsEditing ? [info valueForKey:UIImagePickerControllerEditedImage] : [info valueForKey:UIImagePickerControllerOriginalImage];
    
    self.currentI = image;
    [self updateImageV];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
