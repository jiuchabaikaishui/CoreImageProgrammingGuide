//
//  MainVM.m
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/11/27.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import "MainVM.h"

@implementation MainVM
@synthesize tableViewVM = _tableViewVM;

- (QSPTableViewVM *)tableViewVM {
    if (_tableViewVM == nil) {
        _tableViewVM = [QSPTableViewVM create:nil];
        _tableViewVM.addSectionVMCreate(CommonTableViewSectionVM.class, ^(CommonTableViewSectionVM *sectionVM){
            sectionVM.headerTitleSet(@"图像处理").headerDetailSet(@"使用滤镜进行图像处理");
        });
    }
    
    return _tableViewVM;
}

@end
