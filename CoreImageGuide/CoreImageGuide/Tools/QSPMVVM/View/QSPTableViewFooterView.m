//
//  QSPTableViewFooterView.m
//  ThreadingPrograming
//
//  Created by QSP on 2018/7/23.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "QSPTableViewFooterView.h"

@interface QSPTableViewFooterView()

@end

@implementation QSPTableViewFooterView

- (void)setSectionVMSet:(QSPTableViewSectionVM *)sectionVM {
    _sectionVM = sectionVM;
    
    if (sectionVM.footerTitle) {
        self.textLabel.text = sectionVM.footerTitle;
    }
    if (sectionVM.footerDetail) {
        self.detailTextLabel.text = sectionVM.footerDetail;
    }
}
- (QSPTableViewFooterView * (^)(QSPTableViewSectionVM *))sectionVMSet {
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
