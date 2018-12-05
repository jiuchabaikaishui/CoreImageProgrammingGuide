//
//  CommonTableViewSectionVM.m
//  ThreadManagement
//
//  Created by QSP on 2018/7/23.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "CommonTableViewSectionVM.h"

@interface CommonTableViewSectionVM ()

@property (assign, nonatomic) BOOL headerH;

@end

@implementation CommonTableViewSectionVM

- (void)setHeaderTitleRect:(CGRect)titleRect {
    _headerTitleRect = titleRect;
}
- (void)setHeaderDetailRect:(CGRect)detailRect {
    _headerDetailRect = detailRect;
}
- (QSPTableViewSectionVM *(^)(NSString *))headerTitleSet {
    return ^(NSString *title){
        super.headerTitleSet(title);
        
        CGFloat X = 15;
        CGFloat Y = 4;
        CGFloat W = K_Screen_Width - 2*X;
        CGFloat H = ceil([title boundingRectWithSize:CGSizeMake(W, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: K_CommonTableViewHeaderFooterViewFont} context:nil].size.height);
        self.headerTitleRect = CGRectMake(X, Y, W, H);
        
        if (self.headerDetail) {
            self.headerDetailSet(self.headerDetail);
        }
        
        if (!self.headerH) {
            super.headerHeightSet(Y + H + 4 + (self.headerDetailRect.size.height > 0 ? self.headerDetailRect.size.height + 4 : 0));
        }
        
        return self;
    };
}
- (QSPTableViewSectionVM *(^)(NSString *))headerDetailSet {
    return ^(NSString *detail){
        super.headerDetailSet(detail);
        
        CGFloat X = 15;
        CGFloat Y = self.headerTitleRect.origin.y + self.headerTitleRect.size.height +  4;
        CGFloat W = K_Screen_Width - 2*X;
        CGFloat H = ceil([detail boundingRectWithSize:CGSizeMake(W, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: K_CommonTableViewHeaderFooterViewFont} context:nil].size.height);
        self.headerDetailRect = CGRectMake(X, Y, W, H);
        
        if (!self.headerH) {
            super.headerHeightSet(Y + H + 4);
        }
        
        return self;
    };
}
- (QSPTableViewSectionVM *(^)(CGFloat))headerHeightSet {
    @weakify(self);
    return ^(CGFloat height) {
        @strongify(self);
        super.headerHeightSet(height);
        
        self.headerH = YES;
        
        return self;
    };
}
//- (QSPViewVM *(^)(id))dataMSet {
//    return ^(CommonM *data){
//        super.dataMSet(data);
//
//        CGFloat X = 15;
//        CGFloat Y = 4;
//        CGFloat W = K_QSPScreen_Width - 2*X;
//        CGFloat H = [data.title boundingRectWithSize:CGSizeMake(W, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: K_QSPTableViewHeaderFooterViewFont} context:nil].size.height;
//        self.headerTitleRect = CGRectMake(X, Y, W, H);
//
//        Y = Y + H + 8;
//        H = [data.detail boundingRectWithSize:CGSizeMake(W, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: K_QSPTableViewHeaderFooterViewFont} context:nil].size.height;
//        self.headerDetailRect = CGRectMake(X, Y, W, H);
//
//        self.headerHeightSet(Y + H + 4);
//
//        return self;
//    };
//}

- (instancetype)init {
    if (self = [super init]) {
        self.headerClassSet(CommonTableViewHeaderView.class);
    }
    
    return self;
}

@end
