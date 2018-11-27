//
//  CommonTableVieweHeaderView.m
//  ThreadingPrograming
//
//  Created by QSP on 2018/7/18.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "CommonTableViewHeaderView.h"

@interface CommonTableViewHeaderView()

@end

@implementation CommonTableViewHeaderView
- (QSPTableViewHeaderView * (^)(CommonTableViewSectionVM *))sectionVMSet {
    return ^(CommonTableViewSectionVM *vm){
        super.sectionVMSet(vm);
        
        CommonM *commonM = vm.dataM;
        if (commonM) {
            self.titleL.text = commonM.title;
            self.detailL.text = commonM.detail;
        }
        if (vm.headerTitleRect) {
            self.titleL.frame = [vm.headerTitleRect CGRectValue];
        }
        if (vm.headerDetailRect) {
            self.detailL.frame = [vm.headerDetailRect CGRectValue];
        }
        
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
