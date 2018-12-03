//
//  CommonDefine.h
//  ThreadingPrograming
//
//  Created by apple on 2018/7/30.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#ifndef CommonDefine_h
#define CommonDefine_h

#import "ConFunc.h"
#import "CommonM.h"
#import "CommonTableViewCell.h"
#import "CommonTableViewHeaderView.h"
#import "UITableView+QSPMVVM.h"


#define K_Screen_Bounds         [UIScreen mainScreen].bounds
#define K_Screen_Size           K_Screen_Bounds.size
#define K_Screen_Width          K_Screen_Size.width
#define K_Screen_Height         K_Screen_Size.height

#define K_CommonTableViewHeaderFooterViewFont          [UIFont systemFontOfSize:13]
#define K_CommonTableViewCellTitleFont                 [UIFont systemFontOfSize:17]
#define K_CommonTableViewCellDetailFont                [UIFont systemFontOfSize:12]

#define MethodNotImplementedInSubclass()      @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"你必须在%@的子类中重写%@方法。", NSStringFromClass(self.class), NSStringFromSelector(_cmd)] userInfo:nil]

#define K_WeakSelf          __weak typeof(self) weakSelf = self;
#define K_Application       [UIApplication sharedApplication]
#define K_MainBundle        [NSBundle mainBundle]

#define K_ViewControllerFromMainStorybardWithID(ID)          [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:ID]
#endif /* CommonDefine_h */
