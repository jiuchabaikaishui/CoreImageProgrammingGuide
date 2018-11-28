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
@synthesize mainVM = _mainVM;

#pragma mark - 属性方法
- (MainVM *)mainVM {
    return (MainVM *)self.vm;
}

#pragma mark - 控制器周期
- (instancetype)init {
    if (self = [super initWithVM:[[MainVM alloc] init]]) {
        
    }
    
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder andVM:[[MainVM alloc] init]]) {
        
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - 自定义方法
- (void)bindVM {
    [super bindVM];
    
    self.tableV.vmSet(self.mainVM.tableViewVM);
    
    @weakify(self);
    [self.mainVM.tableViewVM.didSelectRowSignal subscribeNext:^(QSPTableViewAndIndexPath *x) {
        @strongify(self);
        MainTableViewCellVM *cellVM = [x.tableView.vm rowVMWithIndexPath:x.indexPath];
        [self.navigationController pushViewController:[BaseViewController controllerWithVM:cellVM.nextVM andStoryboardID:cellVM.nextStoryboardID] animated:YES];
    }];
}


@end
