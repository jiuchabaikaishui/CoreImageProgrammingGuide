//
//  MainTableVIewCellVM.m
//  Scanning
//
//  Created by 綦帅鹏 on 2018/11/16.
//  Copyright © 2018年 PowesunHolding. All rights reserved.
//

#import "MainTableViewCellVM.h"

@implementation MainTableViewCellVM

- (void)setSegueIDSet:(NSString *)segueID {
    _segueID = segueID;
}
- (MainTableViewCellVM * (^)(NSString *))segueIDSet {
    return ^(NSString *segueID){
        self.segueIDSet = segueID;
        
        return self;
    };
}
- (void)setRealMSet:(BOOL)realM {
    _realM = realM;
}
- (MainTableViewCellVM * (^)(BOOL))realMSet {
    return ^(BOOL realM){
        self.realMSet = realM;
        
        return self;
    };
}

@end
