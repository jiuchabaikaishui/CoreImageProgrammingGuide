//
//  ColorViewController.m
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2019/1/29.
//  Copyright © 2019年 綦帅鹏. All rights reserved.
//

#import "ColorViewController.h"
#import "UIView+Common.h"

@interface ColorViewController ()

@end

@implementation ColorViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    @weakify(self);
    [self.view tapGestureRecognizerAction:^(UITapGestureRecognizer *tap) {
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

@end
