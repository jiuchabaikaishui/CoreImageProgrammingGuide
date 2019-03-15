//
//  RectangleViewController.m
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2019/3/15.
//  Copyright © 2019年 綦帅鹏. All rights reserved.
//

#import "RectangleViewController.h"

@interface RectangleViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *pictureB;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UIButton *resetB;
@property (weak, nonatomic) IBOutlet UIButton *detectorB;

@property (strong, nonatomic) UIImage *currentI;

@end

@implementation RectangleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentI = self.imageV.image;
    @weakify(self);
    [RACObserve(self.imageV, image) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.resetB.enabled = self.imageV.image != self.currentI;
        self.detectorB.enabled = self.imageV.image && self.imageV.image == self.currentI;
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
- (IBAction)detectorAction:(UIButton *)sender {
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeRectangle context:[CIContext context] options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
    CIImage *image = [[CIImage alloc] initWithImage:self.imageV.image];
    NSArray *features = [detector featuresInImage:image];
    
    if (features && features.count > 0) {
        CGSize size = self.currentI.size;
        UIGraphicsBeginImageContext(size);
        [self.imageV.image drawInRect: (CGRect){{0, 0}, size}];
        for (CIRectangleFeature *feature in features) {
            CGRect rect = (CGRect){{feature.bounds.origin.x, size.height - feature.bounds.origin.y - feature.bounds.size.height}, feature.bounds.size};
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextAddRect(context, rect);
            CGContextSetLineWidth(context, size.width/400);
            [[UIColor cyanColor] setStroke];
            CGContextDrawPath(context, kCGPathStroke);
            CGContextMoveToPoint(context, feature.topLeft.x, feature.topLeft.y);
            CGContextAddLineToPoint(context, feature.topRight.x, feature.topRight.y);
            CGContextAddLineToPoint(context, feature.bottomRight.x, feature.bottomRight.y);
            CGContextAddLineToPoint(context, feature.bottomLeft.x, feature.bottomLeft.y);
            CGContextClosePath(context);
            [[UIColor redColor] setStroke];
            CGContextDrawPath(context, kCGPathStroke);
        }
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        self.imageV.image = newImage;
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"没有检测到面孔" preferredStyle:UIAlertControllerStyleAlert];
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
