//
//  QueryVM.m
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/12/5.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import "QueryVM.h"

@implementation QueryVM
@synthesize tableViewVM = _tableViewVM;

- (QSPTableViewVM *)tableViewVM {
    if (_tableViewVM == nil) {
        _tableViewVM = [QSPTableViewVM create:nil];
        
        NSArray *categorys = @[
                               kCICategoryDistortionEffect,
                               kCICategoryGeometryAdjustment,
                               kCICategoryCompositeOperation,
                               kCICategoryHalftoneEffect,
                               kCICategoryColorAdjustment,
                               kCICategoryColorEffect,
                               kCICategoryTransition,
                               kCICategoryTileEffect,
                               kCICategoryGenerator,
                               kCICategoryGradient,
                               kCICategoryStylize,
                               kCICategorySharpen,
                               kCICategoryBlur
                               ];
        for (NSString *category in categorys) {
            _tableViewVM.addSectionVMCreate(CommonTableViewSectionVM.class, ^(CommonTableViewSectionVM *sectionVM){
                sectionVM.headerTitleSet(category);
                for (NSString *name in [CIFilter filterNamesInCategory:category]) {
                    CIFilter *filter = [CIFilter filterWithName:name];
                    
                    if (filter) {
                        sectionVM.addQSPRowVMCreate(^(QSPTableViewCellVM *cellVM){
                            NSDictionary *attributes = [filter attributes];
                            id detail = attributes[kCIAttributeFilterDisplayName];
                            cellVM.styleSet(UITableViewCellStyleSubtitle).titleSet(name).detailSet(detail);
                            DebugLog(@"\n--------------------%@:\n%@", name, attributes);
                        });
                    } else {
                        DebugLog(@"\n----不能创建%@滤镜----", name);
                    }
                }
            });
        }
    }
    
    return _tableViewVM;
}

@end
