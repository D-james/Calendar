//
//  DSCalendarMethod.m
//  Calendar-OC
//
//  Created by duanshengwu on 2018/5/14.
//  Copyright © 2018年 D-James. All rights reserved.
/*
日历思路：
 
 1.首先明确UI控件：collectionView
 2.关键：数据问题NSCalendar
    获取指定月份有多少天，第一天是星期几
 
 利用NSCalendar 和 NSDateComponents 之间的转换把数据转换为model
 */

#import "DSCalendarMethod.h"
#import "NSDate+Category.h"
#import "CalendarModel.h"

@interface DSCalendarMethod()

//@property (strong, nonatomic) NSCalendar *calendar;

@end

@implementation DSCalendarMethod


#pragma mark - 数据源方法
- (NSMutableArray *)setUpDataStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    
    NSTimeInterval timeInterval = [endDate timeIntervalSinceDate:startDate];
    if (timeInterval < 0) {
        return nil;
    }
    
    NSTimeInterval todayTime = [[NSDate new]timeIntervalSince1970];
    
//    计算开始结束日期之间相差几个月
    NSInteger monthInterval;
    
    NSDateComponents *startComponents = [startDate getDateComponents];
    NSDateComponents *endComponents = [endDate getDateComponents];
    
    NSInteger startYear = startComponents.year;
    NSInteger endYear = endComponents.year;
    
    NSInteger startMonth = startComponents.month;
    NSInteger endMonth = endComponents.month;
    
    monthInterval = (endYear - startYear) * 12 + (endMonth - startMonth) + 1;
    
    
    NSMutableArray *dataArray = [NSMutableArray new];
    
    
    for (int i = 0; i < monthInterval; i++) {
        
        NSMutableArray *monthArray = [NSMutableArray array];
        
        NSDateComponents *newComponent = [NSDateComponents new];
        NSInteger nowYear = startYear + (startMonth + i)/12;
        newComponent.year = nowYear;
        
        NSInteger monthYu = (startMonth + i) % 12;
        NSInteger nowMonth = monthYu ? monthYu : 12;
        newComponent.month = nowMonth;
        newComponent.day = 1;
        
        NSDate *newDate = [[NSCalendar currentCalendar]dateFromComponents:newComponent];
        
//        本月第一天是周几
        NSInteger weekFirstDay = [newDate getFirstWeekInMonth];
        
//        再本月第一天之前添加空的数据模型
        if (weekFirstDay == 7) {
            weekFirstDay = 0;
        }
        for (int j = 0; j < weekFirstDay; j++) {
            CalendarModel *model = [CalendarModel new];
            model.dateStatus = Calendar_EmptyDate;
            [monthArray addObject:model];
        }
        
//        添加有数据的数据模型
        NSInteger daysMonth = [newDate getDayNumOfMouth];
        
        for (int k = 1; k <= daysMonth ; k++) {
            CalendarModel *model = [CalendarModel new];
            
            model.year = nowYear;
            model.month = nowMonth;
            model.day = k;
            
//            计算周几
            newComponent.day = k;
            NSDate *weekDate = [[NSCalendar currentCalendar]dateFromComponents:newComponent];
            model.week = [weekDate getWeek];
            
            NSTimeInterval modelTimeStamp = weekDate.timeIntervalSince1970 + 60*60*24 - 1;
            if (modelTimeStamp < todayTime) {
                model.dateStatus = Calendar_PassedDate;
            }else{
                model.dateStatus = Calendar_NormalDate;
            }
            
            [monthArray addObject:model];
        }
        
        [dataArray addObject:monthArray];
    }
    
    return dataArray;
}



@end
