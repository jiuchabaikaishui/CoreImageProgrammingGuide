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
        _tableViewVM.addSectionVMCreate(CommonTableViewSectionVM.class, ^(CommonTableViewSectionVM *sectionVM){
            sectionVM.headerClassSet(CommonTableViewHeaderView.class).headerTitleSet(@"面部检测").headerDetailSet(@"分析和查找图像中的人脸");
            sectionVM.addRowVMCreate(MainTableViewCellVM.class, ^(MainTableViewCellVM *cellVM){
                cellVM.accessoryTypeSet(UITableViewCellAccessoryDisclosureIndicator).cellClassSet(CommonTableViewCell.class).titleSet(@"检测面孔及其特征").detailSet(@"CIDetector类在图像中查找面空并分析特征");
                cellVM.segueIDSet(@"MainToFace");
            });
        });
        _tableViewVM.addSectionVMCreate(CommonTableViewSectionVM.class, ^(CommonTableViewSectionVM *sectionVM){
            sectionVM.headerClassSet(CommonTableViewHeaderView.class).headerTitleSet(@"自动增强图像").headerDetailSet(@"Core Image的自动增强功能可分析图像的直方图，然后改善图像");
            sectionVM.addRowVMCreate(MainTableViewCellVM.class, ^(MainTableViewCellVM *cellVM){
                cellVM.accessoryTypeSet(UITableViewCellAccessoryDisclosureIndicator).cellClassSet(CommonTableViewCell.class).titleSet(@"图像自动增强滤镜").detailSet(@"不必立即应用自动调整滤镜。可以保存滤镜名称和参数值以供日后使用。保存它们可让您的应用程序稍后执行增强功能，而无需再次分析图像。");
                cellVM.segueIDSet(@"MainToEnhance");
            });
        });
        _tableViewVM.addSectionVMCreate(CommonTableViewSectionVM.class, ^(CommonTableViewSectionVM *sectionVM){
            sectionVM.headerClassSet(CommonTableViewHeaderView.class).headerTitleSet(@"查询滤镜").headerDetailSet(@"Core Image提供的方法查询可用的内置滤镜以及有关每个滤镜的名称，输入参数，参数类型，默认值等相关信息");
            sectionVM.addRowVMCreate(MainTableViewCellVM.class, ^(MainTableViewCellVM *cellVM){
                cellVM.accessoryTypeSet(UITableViewCellAccessoryDisclosureIndicator).cellClassSet(CommonTableViewCell.class).titleSet(@"构建滤镜列表").detailSet(@"通过获取滤镜和属性列表来构建滤镜字典");
                cellVM.segueIDSet(@"MainToQuery");
            });
        });
    }
    
    return _tableViewVM;
}

@end
