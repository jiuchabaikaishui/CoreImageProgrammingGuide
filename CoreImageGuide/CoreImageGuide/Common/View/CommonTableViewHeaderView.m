//
//  CommonTableVieweHeaderView.m
//  ThreadingPrograming
//
//  Created by QSP on 2018/7/18.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "CommonTableViewHeaderView.h"

@interface CommonTableViewHeaderView()

@property (weak, nonatomic, readonly) UILabel *titleL;
@property (weak, nonatomic, readonly) UILabel *detailL;

@end

@implementation CommonTableViewHeaderView
- (QSPTableViewHeaderView * (^)(QSPTableViewSectionVM *))sectionVMSet {
    return ^(QSPTableViewSectionVM *vm){
        self.titleL.text = vm.headerTitle;
        self.detailL.text = vm.headerDetail;
        
//        CGFloat X = 15;
//        CGFloat Y = 4;
//        CGFloat W = K_Screen_Width - 2*X;
//        CGFloat H = [vm.headerTitle boundingRectWithSize:CGSizeMake(W, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: K_CommonTableViewHeaderFooterViewFont} context:nil].size.height;
//        self.titleL.frame = CGRectMake(X, Y, W, H);
//
//        Y = Y + H + 8;
//        H = [vm.headerDetail boundingRectWithSize:CGSizeMake(W, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: K_CommonTableViewHeaderFooterViewFont} context:nil].size.height;
//        self.detailL.frame = CGRectMake(X, Y, W, H);
//
//        vm.headerHeightSet(Y + H + 4);
        
        if ([vm isKindOfClass:CommonTableViewSectionVM.class]) {
            CommonTableViewSectionVM *commonVM = (CommonTableViewSectionVM *)vm;
            self.titleL.frame = commonVM.headerTitleRect;
            self.detailL.frame = commonVM.headerDetailRect;
        }
        
        return self;
    };
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UILabel *titleL = [[UILabel alloc] init];
        titleL.numberOfLines = 0;
        titleL.textColor = self.textLabel.textColor;
        titleL.font = K_CommonTableViewHeaderFooterViewFont;
        [self.contentView addSubview:titleL];
        _titleL = titleL;
        
        UILabel *detailL = [[UILabel alloc] init];
        detailL.numberOfLines = 0;
        detailL.textColor = self.detailTextLabel.textColor;
        detailL.font = K_CommonTableViewHeaderFooterViewFont;
        [self.contentView addSubview:detailL];
        _detailL = detailL;
        
        CGFloat X = 15;
        CGFloat Y = 4;
        CGFloat W = K_Screen_Width - 2*X;
        CGFloat H = 22;
        self.titleL.frame = CGRectMake(X, Y, W, H);
        
        Y = Y + H + 4;
        self.detailL.frame = CGRectMake(X, Y, W, H);
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
