//
//  UIImage+CommonUtils.m
//  QRindoMerchant
//
//  Created by DaXiong on 2019/1/9.
//  Copyright © 2019年 DaXiong. All rights reserved.
//


#import "UIImage+CommonUtils.h"


@implementation UIImage (CommonUtils)

- (UIImage *)stretchableImageFromCenter
{
    return [self stretchableImageWithLeftCapWidth:self.size.width/2.0f
                                     topCapHeight:self.size.height/2.0f];
}

- (UIImage *)tileableImageForOriginal
{
    return [self resizableImageWithCapInsets:UIEdgeInsetsZero
                                resizingMode:UIImageResizingModeTile];
}



@end
