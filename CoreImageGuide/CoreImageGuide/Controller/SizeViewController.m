//
//  SizeViewController.m
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2019/1/29.
//  Copyright © 2019年 綦帅鹏. All rights reserved.
//

#import "SizeViewController.h"
#import "UIView+Common.h"
#import "UIImage+Common.h"

@interface SizeViewController ()
@property (weak, nonatomic) IBOutlet UIView *shardowV;
@property (weak, nonatomic) IBOutlet UIImageView *sizeIV;
@property (weak, nonatomic) IBOutlet UISlider *sizeS;
@property (weak, nonatomic) IBOutlet UILabel *sizeL;

@end

@implementation SizeViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self defaultValue];
    }
    
    return self;
}
- (void)defaultValue {
    [self setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    self.color = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
    self.size = 2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    if (self.size < self.sizeS.minimumValue) {
        self.size = (NSInteger)self.sizeS.minimumValue;
    }
    self.sizeL.text = [NSString stringWithFormat:@"%zi", self.size];
    self.sizeS.value = (float)self.size;
    [self updateImage];
    
    @weakify(self);
    [self.shardowV tapGestureRecognizerAction:^(UITapGestureRecognizer *tap) {
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (IBAction)sizeAction:(UISlider *)sender {
    self.size = (NSInteger)sender.value;
    self.sizeL.text = [NSString stringWithFormat:@"%zi", self.size];
    [self updateImage];
}
- (IBAction)ensureAction:(UIButton *)sender {
    if (self.ensureB) {
        self.ensureB((NSInteger)self.sizeS.value);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)updateImage {
    [UIImage genarateImageWithSize:CGSizeMake(self.size + 1.0f, self.size + 1.0f) draw:^(CGSize size, CGContextRef context) {
        CGContextAddEllipseInRect(context, (CGRect){{0.5f, 0.5f}, CGSizeMake(size.width - 1.0f, size.height - 1.0f)});
        CGContextSetLineWidth(context, 1.0f);
        [self.color setFill];
        [[UIColor blackColor] setStroke];
        CGContextDrawPath(context, kCGPathFillStroke);
    } completed:^(UIImage *image) {
        self.sizeIV.image = image;
    }];
}

@end
