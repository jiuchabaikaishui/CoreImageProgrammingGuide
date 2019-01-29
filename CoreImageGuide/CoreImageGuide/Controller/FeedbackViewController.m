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

@interface FeedbackViewController ()

@property (weak, nonatomic) IBOutlet UIButton *colorB;
@property (weak, nonatomic) IBOutlet UIButton *sizeB;

@end

@implementation FeedbackViewController

#pragma mark - 控制器周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(20, 20) cornerRadius:0 strokeColor:[UIColor blackColor] strokeWidth:2 completed:^(UIImage *image) {
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
    [self presentViewController:nextC animated:YES completion:nil];
}
- (IBAction)sizeAction:(UIButton *)sender {
}

@end
