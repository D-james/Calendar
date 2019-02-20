//
//  DSCalendarView.h
//  Calendar-OC
//
//  Created by duanshengwu on 2018/5/16.
//  Copyright © 2018年 D-James. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarModel.h"

@interface DSCalendarView : UIView

@property (strong, nonatomic) NSMutableArray<NSArray <CalendarModel *>*> *dataArray;

@property (assign, nonatomic) bool isSingleSelect;//yes 日期单选， no 日期区间选择

@end
