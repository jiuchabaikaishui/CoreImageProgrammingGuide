//
//  CommonTableVieweHeaderView.h
//  ThreadingPrograming
//
//  Created by QSP on 2018/7/18.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "QSPTableViewHeaderView.h"

@interface CommonTableViewHeaderView : QSPTableViewHeaderView

- (CommonTableViewHeaderView * (^)(QSPTableViewSectionVM *))sectionVMSet;

@end
