//
//  PaintView.h
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2019/1/31.
//  Copyright © 2019年 綦帅鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaintView : UIView

@property (strong, nonatomic) UIColor *brushColor;
@property (assign, nonatomic) NSInteger brushSize;

/**
 清屏
 */
- (void)clearScreen;

@end

NS_ASSUME_NONNULL_BEGIN

NS_ASSUME_NONNULL_END
