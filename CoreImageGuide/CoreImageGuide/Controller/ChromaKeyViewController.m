//
//  ChromaKeyViewController.m
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/12/7.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import "ChromaKeyViewController.h"
#import "CIChromaKey.h"

typedef NS_ENUM(NSInteger, ChromaKeyViewControllerPictureType) {
    ChromaKeyViewControllerPictureTypeFront = 0,
    ChromaKeyViewControllerPictureTypeBack = 1
};
@interface ChromaKeyViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UISlider *minS;
@property (weak, nonatomic) IBOutlet UISlider *maxS;
@property (weak, nonatomic) IBOutlet UILabel *minL;
@property (weak, nonatomic) IBOutlet UILabel *maxL;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UIImageView *colorIV;
@property (assign, nonatomic) ChromaKeyViewControllerPictureType type;

@property (strong, nonatomic) UIImage *backImage;
@property (strong, nonatomic) UIImage *frontImage;

@end

@implementation ChromaKeyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"21E58PIC58i_1024" ofType:@"jpg"]];
    self.frontImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"2144026043-5a3b35ba01e59_articlex" ofType:@"jpeg"]];
    [self updateImageV];
    
    CGSize size = self.colorIV.frame.size;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIGraphicsBeginImageContext(size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        for (int i = 0; i < size.width; i++) {
            CGContextMoveToPoint(context, i, 0);
            CGContextAddLineToPoint(context, i, size.width);
            UIColor *color = [UIColor colorWithHue:i/size.width saturation:1 brightness:1 alpha:1];
            [color setStroke];
            CGContextSetLineWidth(context, 1);
            CGContextStrokePath(context);
        }
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        dispatch_async(dispatch_get_main_queue(), ^{
            self.colorIV.image = image;
        });
    });
}
- (IBAction)frontAction:(UIBarButtonItem *)sender {
    self.type = ChromaKeyViewControllerPictureTypeFront;
    [ConFunc cameraPhotoAlter:self removeAction:^{
        self.frontImage = nil;
        [self updateImageV];
    }];
}
- (IBAction)backAction:(UIBarButtonItem *)sender {
    self.type = ChromaKeyViewControllerPictureTypeBack;
    [ConFunc cameraPhotoAlter:self removeAction:^{
        self.backImage = nil;
        [self updateImageV];
    }];
}
- (IBAction)min:(UISlider *)sender {
    [self updateImageV];
}
- (IBAction)minAction:(UISlider *)sender {
    if (self.maxS.value < sender.value) {
        [self.maxS setValue:sender.value animated:NO];
        self.maxL.text = [NSString stringWithFormat:@"%.0f", sender.value];
    }
    self.minL.text = [NSString stringWithFormat:@"%.0f", sender.value];
}
- (IBAction)max:(UISlider *)sender {
    [self updateImageV];
}
- (IBAction)maxAction:(UISlider *)sender {
    if (self.minS.value > sender.value) {
        [self.minS setValue:sender.value animated:NO];
        self.minL.text = [NSString stringWithFormat:@"%.0f", sender.value];
    }
    self.maxL.text = [NSString stringWithFormat:@"%.0f", sender.value];
}

- (void)updateImageV {
    CGFloat min = self.minS.value;
    CGFloat max = self.maxS.value;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CIChromaKey *filter = [[CIChromaKey alloc] init];
        filter.inputImage = [[CIImage alloc] initWithImage:self.frontImage];
        filter.backImage = [[CIImage alloc] initWithImage:self.backImage];
        filter.minHueAngle = min;
        filter.maxHueAngle = max;
        CIContext *context = [CIContext context];
        CIImage *output = filter.outputImage;
        CGImageRef image = [context createCGImage:output fromRect:filter.backImage.extent];
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
    
    if (self.type == ChromaKeyViewControllerPictureTypeFront) {
        self.frontImage = image;
        [self updateImageV];
    } else if (self.type == ChromaKeyViewControllerPictureTypeBack) {
        self.backImage = image;
        [self updateImageV];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
