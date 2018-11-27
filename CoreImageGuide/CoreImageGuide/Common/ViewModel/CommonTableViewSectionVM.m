//
//  CommonTableViewSectionVM.m
//  ThreadManagement
//
//  Created by QSP on 2018/7/23.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "CommonTableViewSectionVM.h"
#import "CommonTableViewHeaderView.h"

@implementation CommonTableViewSectionVM

- (void)setHeaderTitleRect:(id)titleRect {
    _headerTitleRect = titleRect;
}
- (void)setHeaderDetailRect:(id)detailRect {
    _headerDetailRect = detailRect;
}
- (QSPViewVM *(^)(id))dataMSet {
    return ^(CommonM *data){
        super.dataMSet(data);
        
        if ([data isKindOfClass:CommonM.class]) {
            CGFloat X = 15;
            CGFloat Y = 4;
            CGFloat W = K_QSPScreen_Width - 2*X;
            CGFloat H = [data.title ? data.title : self.headerTitle boundingRectWithSize:CGSizeMake(W, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: K_QSPTableViewHeaderFooterViewFont} context:nil].size.height;
            self.headerTitleRect = [NSValue valueWithCGRect:CGRectMake(X, Y, W, H)];
            
//            CGFloat detail_H = [data.detail boundingRectWithSize:CGSizeMake(W, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: K_QSPTableViewHeaderFooterViewFont} context:nil].size.height;
//            if ([ConFunc blankOfStr:data.title]) {
//                if ([ConFunc blankOfStr:data.detail]) {
//                } else {
//                    self.headerDetailRect = CGRectMake(X, Y, W, detail_H);
//
//                    self.headerHeightSet(Y + detail_H + 4);
//                }
//            } else {
//                self.headerTitleRect = CGRectMake(X, Y, W, H);
//
//                if ([ConFunc blankOfStr:data.detail]) {
//                    self.headerHeightSet(Y + H + 4);
//                } else {
//                    Y = Y + H + 8;
//                    self.headerDetailRect = CGRectMake(X, Y, W, detail_H);
//
//                    self.headerHeightSet(Y + detail_H + 4);
//                }
//            }
            
            Y = Y + H + 8;
            H = [data.detail ? data.detail : self.headerDetail boundingRectWithSize:CGSizeMake(W, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: K_QSPTableViewHeaderFooterViewFont} context:nil].size.height;
            self.headerDetailRect = [NSValue valueWithCGRect:CGRectMake(X, Y, W, H)];
            
            self.headerHeightSet(Y + H + 4);
        }
        
        return self;
    };
}

- (instancetype)init {
    if (self = [super init]) {
        self.headerClassSet(CommonTableViewHeaderView.class);
    }
    
    return self;
}

@end
