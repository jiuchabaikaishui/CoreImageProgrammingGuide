//
//  ViewController.m
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/11/27.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableV;

@end

@implementation MainViewController

#pragma mark - 属性方法
- (MainVM *)mainVM {
    return (MainVM *)super.vm;
}

#pragma mark - 控制器周期
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder andVM:[[MainVM alloc] init]]) {
        
    }
    
    return self;
}
- (instancetype)init {
    if (self = [super initWithVM:[[MainVM alloc] init]]) {
        
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingUI];
    [self bindVM];
}

#pragma mark - 自定义方法
- (void)settingUI {
    
}
- (void)bindVM {
    self.tableV.vmSet(self.mainVM.tableViewVM);
//    @weakify(self);
//    [self.mainVM.tableViewVM.didSelectRowSignal subscribeNext:^(QSPTableViewAndIndexPath *x) {
//        @strongify(self);
//        MainTableViewCellVM *cellVM = [x.tableView.vm rowVMWithIndexPath:x.indexPath];
//    }];
}


@end
