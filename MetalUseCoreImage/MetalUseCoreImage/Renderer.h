//
//  Renderer.h
//  MetalUseCoreImage
//
//  Created by 綦帅鹏 on 2018/12/3.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import <MetalKit/MetalKit.h>

// Our platform independent renderer class.   Implements the MTKViewDelegate protocol which
//   allows it to accept per-frame update and drawable resize callbacks.
@interface Renderer : NSObject <MTKViewDelegate>

-(nonnull instancetype)initWithMetalKitView:(nonnull MTKView *)view;

@end

