//
//  ColorViewController.m
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2019/1/29.
//  Copyright © 2019年 綦帅鹏. All rights reserved.
//

#import "ColorViewController.h"
#import "UIView+Common.h"
#import "UIImage+Common.h"

@interface ColorViewController ()
@property (weak, nonatomic) IBOutlet UIView *shadowV;
@property (weak, nonatomic) IBOutlet UIImageView *colorIV;
@property (weak, nonatomic) IBOutlet UISlider *redS;
@property (weak, nonatomic) IBOutlet UILabel *redV;
@property (weak, nonatomic) IBOutlet UISlider *greenS;
@property (weak, nonatomic) IBOutlet UILabel *greenV;
@property (weak, nonatomic) IBOutlet UISlider *blueS;
@property (weak, nonatomic) IBOutlet UILabel *blueV;
@property (weak, nonatomic) IBOutlet UISlider *alphaS;
@property (weak, nonatomic) IBOutlet UILabel *alphaV;

@end

@implementation ColorViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self defaultV];
    }
    
    return self;
}
- (void)defaultV {
    [self setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    self.color = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
    _currentC = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    [UIImage imageWithColor:self.color size:CGSizeMake(100.0f, 100.0f) cornerRadius:0.0f strokeColor:[UIColor blackColor] strokeWidth:5.0f completed:^(UIImage *image) {
        self.colorIV.image = image;
    }];
    
    CGColorRef colorRef = self.color.CGColor;
    const CGFloat *components = CGColorGetComponents(colorRef);
    float value = components[0]*255;
    self.redV.text = [NSString stringWithFormat:@"%.0f", value];
    self.redS.value = value;
    value = components[1]*255;
    self.greenV.text = [NSString stringWithFormat:@"%.0f", value];
    self.greenS.value = value;
    value = components[2]*255;
    self.blueV.text = [NSString stringWithFormat:@"%.0f", value];
    self.blueS.value = value;
    value = components[3]*255;
    self.alphaV.text = [NSString stringWithFormat:@"%.0f", value];
    self.alphaS.value = value;
    @weakify(self);
    [self.shadowV tapGestureRecognizerAction:^(UITapGestureRecognizer *tap) {
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (IBAction)redAction:(UISlider *)sender {
    self.redV.text = [NSString stringWithFormat:@"%.0f", sender.value];
    [self updateColor];
}
- (IBAction)greenAction:(UISlider *)sender {
    self.greenV.text = [NSString stringWithFormat:@"%.0f", sender.value];
    [self updateColor];
}
- (IBAction)blueAction:(UISlider *)sender {
    self.blueV.text = [NSString stringWithFormat:@"%.0f", sender.value];
    [self updateColor];
}
- (IBAction)alphaAction:(UISlider *)sender {
    self.alphaV.text = [NSString stringWithFormat:@"%.0f", sender.value];
    [self updateColor];
}
- (IBAction)ensureAction:(UIButton *)sender {
    if (self.ensureB) {
        self.ensureB(self.currentC);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)updateColor {
    _currentC = [UIColor colorWithRed:self.redS.value/255.0f green:self.greenS.value/255.0f blue:self.blueS.value/255.0f alpha:self.alphaS.value/255.0f];
    
    [UIImage imageWithColor:_currentC size:CGSizeMake(100.0f, 100.0f) cornerRadius:0.0f strokeColor:[UIColor blackColor] strokeWidth:5.0f completed:^(UIImage *image) {
        self.colorIV.image = image;
    }];
}

@end
