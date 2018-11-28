//
//  QSPTableViewHeaderFooterView.m
//  ThreadingPrograming
//
//  Created by QSP on 2018/7/19.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "QSPTableViewHeaderView.h"

@interface QSPTableViewHeaderView ()

@end

@implementation QSPTableViewHeaderView

- (void)setSectionVMSet:(QSPTableViewSectionVM *)sectionVM {
    _sectionVM = sectionVM;
    
    if (sectionVM.headerTitle) {
        self.textLabel.text = sectionVM.headerTitle;
    }
    if (sectionVM.headerDetail) {
        self.detailTextLabel.text = sectionVM.headerDetail;
    }
}
- (QSPTableViewHeaderView * (^)(QSPTableViewSectionVM *))sectionVMSet {
    return ^(QSPTableViewSectionVM *vm){
        self.sectionVMSet = vm;
        
        return self;
    };
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
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
