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
        _tableViewVM.addQSPSectionVMCreate(^(QSPTableViewSectionVM *sectionVM){
            sectionVM.headerClassSet(CommonTableViewHeaderView.class).headerTitleSet(@"图像处理").headerDetailSet(@"使用滤镜进行图像处理");
            sectionVM.addRowVMCreate(MainTableViewCellVM.class, ^(MainTableViewCellVM *cellVM){
                cellVM.accessoryTypeSet(UITableViewCellAccessoryDisclosureIndicator).cellClassSet(CommonTableViewCell.class).titleSet(@"滤镜基本使用").detailSet(@"需要注意的是CIContext是重量级对象，应该使用时创建重复使用");
                cellVM.segueIDSet(@"MainToProcessing");
            });
            sectionVM.addRowVMCreate(MainTableViewCellVM.class, ^(MainTableViewCellVM *cellVM){
                cellVM.segueIDSet(@"MainToCombine").accessoryTypeSet(UITableViewCellAccessoryDisclosureIndicator).cellClassSet(CommonTableViewCell.class).titleSet(@"合并滤镜").detailSet(@"需要注意的是CIContext是重量级对象，应该使用时创建重复使用");
            });
            sectionVM.addRowVMCreate(MainTableViewCellVM.class, ^(MainTableViewCellVM *cellVM){
                cellVM.segueIDSet(@"MainToVideo").accessoryTypeSet(UITableViewCellAccessoryDisclosureIndicator).cellClassSet(CommonTableViewCell.class).titleSet(@"处理视频").detailSet(@"使用AVVideoComposition对象在播放或导出期间将Core Image滤镜应用于视频的每个帧");
            });
            sectionVM.addRowVMCreate(MainTableViewCellVM.class, ^(MainTableViewCellVM *cellVM){
                cellVM.segueIDSet(@"MainToTetal").accessoryTypeSet(UITableViewCellAccessoryDisclosureIndicator).cellClassSet(CommonTableViewCell.class).titleSet(@"Metal渲染图片滤镜").detailSet(@"使用MetalKit视图（MTKView）渲染Core Image输出图像");
            });
        });
    }
    
    return _tableViewVM;
}

@end
