//
//  CommonTableViewCell.m
//  ThreadManagement
//
//  Created by QSP on 2018/7/23.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "CommonTableViewCell.h"

@interface CommonTableViewCell ()

@property (weak, nonatomic) UILabel *titleL;
@property (weak, nonatomic) UILabel *detailL;

@end

@implementation CommonTableViewCell

- (CommonTableViewCell *(^)(QSPTableViewCellVM *))cellVMSet {
    return ^(QSPTableViewCellVM *vm){
        self.titleL.text = vm.title;
        self.detailL.text = vm.detail;
        self.accessoryType = vm.accessoryType;
        
//        CGFloat X = 15.0;
//        CGFloat Y = 8.0;
//        CGFloat W = K_Screen_Width - X - 35;
//        CGFloat H = [vm.title boundingRectWithSize:CGSizeMake(W, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: K_CommonTableViewCellTitleFont} context:nil].size.height;
//        self.titleL.frame = CGRectMake(X, Y, W, H);
//
//        Y = Y + H + 4;
//        H = [vm.detail boundingRectWithSize:CGSizeMake(W, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: K_CommonTableViewCellDetailFont} context:nil].size.height;
//        self.detailL.frame = CGRectMake(X, Y, W, H);
//
//        vm.cellHeightSet(Y + H + 8);
        
        if ([vm isKindOfClass:CommonTableViewCellVM.class]) {
            CommonTableViewCellVM *commonVM = (CommonTableViewCellVM *)vm;
            self.titleL.frame = commonVM.titleRect;
            self.detailL.frame = commonVM.detailRect;
        }
        
        return self;
    };
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *titleL = [[UILabel alloc] init];
        titleL.numberOfLines = 0;
        titleL.textColor = self.textLabel.textColor;
        titleL.font = K_CommonTableViewCellTitleFont;
        [self.contentView addSubview:titleL];
        self.titleL = titleL;
        
        UILabel *detailL = [[UILabel alloc] init];
        detailL.numberOfLines = 0;
        detailL.textColor = self.detailTextLabel.textColor;
        detailL.font = K_CommonTableViewCellDetailFont;
        [self.contentView addSubview:detailL];
        self.detailL = detailL;
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
