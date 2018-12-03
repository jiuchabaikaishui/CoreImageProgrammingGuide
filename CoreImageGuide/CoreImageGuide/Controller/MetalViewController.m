//
//  MetalViewController.m
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/12/3.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import "MetalViewController.h"
#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>

@interface MetalViewController () <MTKViewDelegate>

@property (strong, nonatomic) id<MTLDevice> device;
@property (strong, nonatomic) id<MTLCommandQueue> commandQueue;
@property (strong, nonatomic) id<MTLTexture> sourceTexture;
@property (strong, nonatomic) CIContext *context;
@property (strong, nonatomic, readonly) CIFilter *filter;
@property (assign, nonatomic, readonly) CGColorSpaceRef colorSpace;

@end

@implementation MetalViewController

- (instancetype)init {
    if (self = [super init]) {
        _filter = [CIFilter filterWithName:@"CIGaussianBlur"];
        _colorSpace = CGColorSpaceCreateDeviceRGB();
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.device = MTLCreateSystemDefaultDevice();
    self.commandQueue = [self.device newCommandQueue];
    
    MTKView *view = (MTKView *)self.view;
    view.delegate = self;
    view.device = self.device;
    view.framebufferOnly = NO;
    
    self.context = [CIContext contextWithMTLDevice:self.device];
}

- (void)mtkView:(MTKView *)view drawableSizeWillChange:(CGSize)size {
    
}
- (void)drawInMTKView:(MTKView *)view {
    if (view.currentDrawable) {
        id<MTLCommandBuffer> commandBuffer = self.commandQueue.commandBuffer;
        CIImage *inputImage = [CIImage imageWithMTLTexture:self.sourceTexture options:nil];
        [self.filter setValue:inputImage forKey:kCIInputImageKey];
        [self.filter setValue:@(100) forKey:kCIInputRadiusKey];
        
        [self.context render:self.filter.outputImage toMTLTexture:[view depthStencilTexture] commandBuffer:commandBuffer bounds:inputImage.extent colorSpace:self.colorSpace];
        
        [commandBuffer presentDrawable:view.currentDrawable];
        [commandBuffer commit];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
