//
//  QSPRowVM.h
//  ThreadingPrograming
//
//  Created by QSP on 2018/7/19.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "QSPViewVM.h"
#import <UIKit/UIKit.h>

typedef void (^QSPSelectedBlock)(UITableView *tableView, NSIndexPath *indexPath);

@interface QSPTableViewCellVM : QSPViewVM

@property (assign, nonatomic, readonly) Class cellClass;
@property (strong, nonatomic, readonly) id cellHeight;
@property (assign, nonatomic, readonly) UITableViewCellStyle style;
@property (assign, nonatomic, readonly) UITableViewCellAccessoryType accessoryType;
@property (copy, nonatomic, readonly) NSString *icon;
@property (copy, nonatomic, readonly) NSString *title;
@property (copy, nonatomic, readonly) NSString *detail;
@property (copy, nonatomic, readonly) QSPSelectedBlock selectedBlock;

- (QSPTableViewCellVM * (^)(Class))cellClassSet;
- (QSPTableViewCellVM * (^)(CGFloat))cellHeightSet;
- (QSPTableViewCellVM * (^)(UITableViewCellStyle))styleSet;
- (QSPTableViewCellVM * (^)(UITableViewCellAccessoryType))accessoryTypeSet;
- (QSPTableViewCellVM * (^)(NSString *))iconSet;
- (QSPTableViewCellVM * (^)(NSString *))titleSet;
- (QSPTableViewCellVM * (^)(NSString *))detailSet;
- (QSPTableViewCellVM * (^)(QSPSelectedBlock))selectedBlockSet;

@end
