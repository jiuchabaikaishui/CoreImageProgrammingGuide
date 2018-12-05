//
//  CommonTableViewCellVM.m
//  ThreadManagement
//
//  Created by QSP on 2018/7/23.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "CommonTableViewCellVM.h"

@interface CommonTableViewCellVM ()

@property (assign, nonatomic) BOOL height;

@end

@implementation CommonTableViewCellVM

- (void)setTitleRect:(CGRect)titleRect {
    _titleRect = titleRect;
}
- (void)setDetailRect:(CGRect)detailRect {
    _detailRect = detailRect;
}
- (QSPTableViewCellVM *(^)(NSString *))titleSet {
    return ^(NSString *title) {
        super.titleSet(title);
        
        CGFloat X = 15.0;
        CGFloat Y = 8.0;
        CGFloat W = K_Screen_Width - X - 35;
        CGFloat H = ceil([title boundingRectWithSize:CGSizeMake(W, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: K_CommonTableViewCellTitleFont} context:nil].size.height);
        self.titleRect = CGRectMake(X, Y, W, H);
        
        if (self.detail) {
            self.detailSet(self.detail);
        }
        
        if (!self.height) {
            super.cellHeightSet(ceil(Y + H + 8 + (self.detailRect.size.height > 0 ? self.detailRect.size.height + 4 : 0)));
        }
        
        return self;
    };
}
- (QSPTableViewCellVM *(^)(NSString *))detailSet {
    return ^(NSString *detail) {
        super.detailSet(detail);
        
        CGFloat X = 15.0;
        CGFloat Y = self.titleRect.origin.y + self.titleRect.size.height + 4;
        CGFloat W = K_Screen_Width - X - 35;
        CGFloat H = ceil([detail boundingRectWithSize:CGSizeMake(W, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: K_CommonTableViewCellDetailFont} context:nil].size.height);
        self.detailRect = CGRectMake(X, Y, W, H);
        
        if (!self.height) {
            super.cellHeightSet(Y + H + 8);
        }
        
        return self;
    };
}
- (QSPTableViewCellVM *(^)(CGFloat))cellHeightSet {
    @weakify(self);
    return ^(CGFloat height) {
        @strongify(self);
        super.cellHeightSet(height);
        self.height = YES;
        
        return self;
    };
}

- (instancetype)init {
    if (self = [super init]) {
        self.cellClassSet(CommonTableViewCell.class).styleSet(UITableViewCellStyleDefault).accessoryTypeSet(UITableViewCellAccessoryDisclosureIndicator);
    }
    
    return self;
}

@end
