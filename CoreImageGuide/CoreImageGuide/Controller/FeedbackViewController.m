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
#import "PaintView.h"

@interface FeedbackViewController ()

@property (weak, nonatomic) IBOutlet PaintView *paintV;
@property (weak, nonatomic) IBOutlet UIButton *colorB;
@property (weak, nonatomic) IBOutlet UIButton *sizeB;

@end

@implementation FeedbackViewController

#pragma mark - 控制器周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.sizeB setTitle:[NSString stringWithFormat:@"笔触大小：%zi", self.paintV.brushSize] forState:UIControlStateNormal];
    [UIImage imageWithColor:self.paintV.brushColor size:CGSizeMake(20, 20) cornerRadius:0 strokeColor:[UIColor blackColor] strokeWidth:2 completed:^(UIImage *image) {
        [self.colorB setImage:image forState:UIControlStateNormal];
    }];
}

#pragma mark - 触摸点击方法
- (IBAction)clearAction:(UIButton *)sender {
    [self.paintV clearScreen];
}
- (IBAction)colorAction:(UIButton *)sender {
    ColorViewController *nextC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"ColorInvertViewController"];
    nextC.color = self.paintV.brushColor;
    @weakify(self);
    nextC.ensureB = ^(UIColor *color) {
        @strongify(self);
        self.paintV.brushColor = color;
        [UIImage imageWithColor:self.paintV.brushColor size:CGSizeMake(20, 20) cornerRadius:0 strokeColor:[UIColor blackColor] strokeWidth:2 completed:^(UIImage *image) {
            [self.colorB setImage:image forState:UIControlStateNormal];
        }];
    };
    [self presentViewController:nextC animated:YES completion:nil];
}
- (IBAction)sizeAction:(UIButton *)sender {
    SizeViewController *nextC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SizeViewController"];
    nextC.color = self.paintV.brushColor;
    nextC.size = self.paintV.brushSize;
    @weakify(self);
    nextC.ensureB = ^(NSInteger size) {
        @strongify(self);
        self.paintV.brushSize = size;
        [self.sizeB setTitle:[NSString stringWithFormat:@"笔触大小：%zi", self.paintV.brushSize] forState:UIControlStateNormal];
    };
    [self presentViewController:nextC animated:YES completion:nil];
}

@end
