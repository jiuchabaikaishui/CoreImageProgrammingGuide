//
//  VideoViewController.m
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/12/3.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import "VideoViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface VideoViewController ()

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [K_MainBundle pathForResource:@"录屏480" ofType:@"mov"];
    AVAsset *asset = [AVAsset assetWithURL:[NSURL fileURLWithPath:path]];
    AVPlayerItem *item = [AVPlayerItem playerItemWithAsset:asset];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
    layer.backgroundColor = [UIColor redColor].CGColor;
    CGFloat Y = self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height;
    CGFloat H = (K_Screen_Height - Y - (Y > 64 ? 34 : 0))/2.0;
    layer.frame = CGRectMake(0, Y, K_Screen_Width, H);
    [self.view.layer addSublayer:layer];
    
    asset = [AVAsset assetWithURL:[NSURL fileURLWithPath:path]];
    item = [AVPlayerItem playerItemWithAsset:asset];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    AVVideoComposition *composition = [AVVideoComposition videoCompositionWithAsset:asset applyingCIFiltersWithHandler:^(AVAsynchronousCIImageFilteringRequest * _Nonnull request) {
        CIImage *image = request.sourceImage.imageByClampingToExtent;
        [filter setValue:image forKey:kCIInputImageKey];
        
        CGFloat seconds = CMTimeGetSeconds(request.compositionTime);
        [filter setValue:@(seconds) forKey:kCIInputRadiusKey];
        CIImage *output = [filter.outputImage imageByCroppingToRect:image.extent];
        [request finishWithImage:output context:nil];
    }];
    item.videoComposition = composition;
    AVPlayer *otherPlayer = [AVPlayer playerWithPlayerItem:item];
    layer = [AVPlayerLayer playerLayerWithPlayer:otherPlayer];
    layer.backgroundColor = [UIColor greenColor].CGColor;
    layer.frame = CGRectMake(0, Y + H, K_Screen_Width, H);
    [self.view.layer addSublayer:layer];
    
    [player play];
    [otherPlayer play];
}

@end
