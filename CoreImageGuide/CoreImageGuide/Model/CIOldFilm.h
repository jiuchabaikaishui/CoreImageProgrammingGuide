//
//  CIOldFilm.h
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/12/11.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import <CoreImage/CoreImage.h>

typedef NS_ENUM(NSInteger, CIOldFilmType) {
    CIOldFilmTypeRandom = 0,
    CIOldFilmTypeMatrix = 1
};

NS_ASSUME_NONNULL_BEGIN

@interface CIOldFilm : CIFilter

@property (strong, nonatomic) CIImage *inputImage;
@property (assign, nonatomic) CIOldFilmType type;

@end

NS_ASSUME_NONNULL_END
