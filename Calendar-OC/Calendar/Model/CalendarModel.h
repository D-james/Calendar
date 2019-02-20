//
//  CalendarModel.h
//  Calendar-OC
//
//  Created by duanshengwu on 2018/5/14.
//  Copyright © 2018年 D-James. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    Calendar_EmptyDate,
    Calendar_NormalDate,
    Calendar_PassedDate,//日期区间选择，选择开始日期后，之前的日期置灰
    Calendar_SelectedDate,
    Calendar_StartDate,
    Calendar_EndDate,
} CellDateState;



@interface CalendarModel : NSObject

@property (assign, nonatomic) CellDateState dateStatus;

@property (assign, nonatomic) NSInteger day;
@property (assign, nonatomic) NSInteger month;
@property (assign, nonatomic) NSInteger year;
@property (assign, nonatomic) NSInteger week;

@property (assign, nonatomic) NSInteger lunarDay;//农历


@end
