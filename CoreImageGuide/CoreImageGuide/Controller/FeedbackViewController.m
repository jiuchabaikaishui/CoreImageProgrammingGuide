//
//  FeedbackViewController.m
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2019/1/15.
//  Copyright © 2019年 綦帅鹏. All rights reserved.
//

#import "FeedbackViewController.h"
#import "UIImage+Common.h"
#import "ColorViewController.h"
#import "SizeViewController.h"

@interface FeedbackViewController ()

@property (weak, nonatomic) IBOutlet UIButton *colorB;
@property (weak, nonatomic) IBOutlet UIButton *sizeB;
@property (strong, nonatomic) UIColor *color;
@property (assign, nonatomic) NSInteger size;

@end

@implementation FeedbackViewController

#pragma mark - 控制器周期方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.color = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIImage imageWithColor:self.color size:CGSizeMake(20, 20) cornerRadius:0 strokeColor:[UIColor blackColor] strokeWidth:2 completed:^(UIImage *image) {
        [self.colorB setImage:image forState:UIControlStateNormal];
    }];
}

#pragma mark - 触摸点击方法
- (IBAction)backAction:(UIButton *)sender {
}
- (IBAction)forwardAction:(UIButton *)sender {
}
- (IBAction)colorAction:(UIButton *)sender {
    ColorViewController *nextC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"ColorInvertViewController"];
    nextC.color = self.color;
    @weakify(self);
    nextC.ensureB = ^(UIColor *color) {
        @strongify(self);
        self.color = color;
        [UIImage imageWithColor:self.color size:CGSizeMake(20, 20) cornerRadius:0 strokeColor:[UIColor blackColor] strokeWidth:2 completed:^(UIImage *image) {
            [self.colorB setImage:image forState:UIControlStateNormal];
        }];
    };
    [self presentViewController:nextC animated:YES completion:nil];
}
- (IBAction)sizeAction:(UIButton *)sender {
    SizeViewController *nextC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SizeViewController"];
    nextC.color = self.color;
    @weakify(self);
    nextC.ensureB = ^(NSInteger size) {
        @strongify(self);
        self.size = size;
        [self.sizeB setTitle:[NSString stringWithFormat:@"笔触大小：%zi", self.size] forState:UIControlStateNormal];
    };
    [self presentViewController:nextC animated:YES completion:nil];
}

@end
