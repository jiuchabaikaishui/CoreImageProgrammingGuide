//
//  QueryViewController.m
//  CoreImageGuide
//
//  Created by 綦帅鹏 on 2018/12/5.
//  Copyright © 2018年 綦帅鹏. All rights reserved.
//

#import "QueryViewController.h"
#import "QueryVM.h"

@interface QueryViewController ()

@property (strong, nonatomic, readonly) QueryVM *queryVM;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation QueryViewController
@synthesize queryVM = _queryVM;

- (QueryVM *)queryVM {
    if (_queryVM == nil) {
        _queryVM = [[QueryVM alloc] init];
    }
    
    return _queryVM;
}

#pragma mark - 控制器周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self bindVM];
}
#pragma mark - 自定义方法
- (void)bindVM {
    self.tableView.vmSet(self.queryVM.tableViewVM);
    
//    @weakify(self);
//    [self.queryVM.tableViewVM.didSelectRowSignal subscribeNext:^(QSPTableViewAndIndexPath *x) {
//        @strongify(self);
//        QSPTableViewCellVM *cellVM = [x.tableView.vm rowVMWithIndexPath:x.indexPath];
//    }];
}

@end
