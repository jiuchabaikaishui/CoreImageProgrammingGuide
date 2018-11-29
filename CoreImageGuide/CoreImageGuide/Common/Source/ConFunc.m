//
//  ConFunc.m
//  Review
//
//  Created by 綦帅鹏 on 2018/11/13.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "ConFunc.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

@implementation ConFunc

+ (BOOL)blankOfStr:(NSString *)str {
    if (str == nil || str == NULL)
        return YES;
    
    if ([str isKindOfClass:[NSNull class]])
        return YES;
    
    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
        return YES;
    
    return NO;
}
+ (void)openSetting {
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([K_Application canOpenURL:url]) {
        if (@available(iOS 10.0, *)) {
            [K_Application openURL:url options:[NSDictionary dictionary] completionHandler:nil];
        } else {
            [K_Application openURL:url];
        }
    }
}
+ (void)cameraPhotoAlter:(UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate> *)controller removeAction:(void (^)(void))removeAction {
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"图片来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cameraA = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        AVAuthorizationStatus type = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (type == AVAuthorizationStatusRestricted || type == AVAuthorizationStatusDenied) {//受限或拒绝
            [ConFunc openSetting];
        } else {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if (granted) {
                        UIImagePickerController *nextCtr = [[UIImagePickerController alloc] init];
                        nextCtr.allowsEditing = NO;
                        nextCtr.delegate = controller;
                        nextCtr.sourceType = UIImagePickerControllerSourceTypeCamera;
                        [controller presentViewController:nextCtr animated:YES completion:nil];
                    } else {
                        [ConFunc openSetting];
                    }
                }];
            } else {
                UIAlertController *nextCtr = [UIAlertController alertControllerWithTitle:@"提示" message:@"该设备没有相机" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okA = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                [nextCtr addAction:okA];
                [controller presentViewController:nextCtr animated:YES completion:nil];
            }
        }
    }];
    [alter addAction:cameraA];
    UIAlertAction *photoA = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
            [ConFunc openSetting];
        } else {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) {
                    UIImagePickerController *nextCtr = [[UIImagePickerController alloc] init];
                    nextCtr.allowsEditing = NO;
                    nextCtr.delegate = controller;
                    nextCtr.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    [controller presentViewController:nextCtr animated:YES completion:nil];
                } else {
                    [ConFunc openSetting];
                }
            }];
        }
    }];
    [alter addAction:photoA];
    if (removeAction) {
        UIAlertAction *removeA = [UIAlertAction actionWithTitle:@"移除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            removeAction();
        }];
        [alter addAction:removeA];
    }
    UIAlertAction *cancelA = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alter addAction:cancelA];
    [controller presentViewController:alter animated:YES completion:nil];
}

@end
