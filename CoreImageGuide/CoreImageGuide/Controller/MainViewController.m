//
//  ViewController.m
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/11/27.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import "MainViewController.h"
#import "MainVM.h"
#import <Metal/Metal.h>

@interface MainViewController ()

@property (strong, nonatomic, readonly) MainVM *mainVM;

@property (weak, nonatomic) IBOutlet UITableView *tableV;

@end

@implementation MainViewController
@synthesize mainVM = _mainVM;

#pragma mark - 属性方法
- (MainVM *)mainVM {
    if (_mainVM == nil) {
        _mainVM = [[MainVM alloc] init];
    }
    
    return _mainVM;
}

#pragma mark - 控制器周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self bindVM];
}
#pragma mark - 自定义方法
- (void)bindVM {
    self.tableV.vmSet(self.mainVM.tableViewVM);
    
    @weakify(self);
    [self.mainVM.tableViewVM.didSelectRowSignal subscribeNext:^(QSPTableViewAndIndexPath *x) {
        @strongify(self);
        MainTableViewCellVM *cellVM = [x.tableView.vm rowVMWithIndexPath:x.indexPath];
        [self performSegueWithIdentifier:cellVM.segueID sender:cellVM];
    }];
}


@end
