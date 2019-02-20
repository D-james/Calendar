//
//  NSDate+Category.m
//  Calendar-OC
//
//  Created by duanshengwu on 2018/5/15.
//  Copyright © 2018年 D-James. All rights reserved.
//

#import "NSDate+Category.h"


@implementation NSDate (Category)


#pragma mark - 获取特定日期月份第一天是周几
- (NSUInteger)getFirstWeekInMonth {
    NSDateComponents *dateComponent = [self getDateComponents];
    dateComponent.day = 1;
    
    NSDate *newMonthDate =[[NSCalendar currentCalendar] dateFromComponents:dateComponent];
    NSDateComponents *dateComponents = [newMonthDate getDateComponents];
    
    NSInteger week = dateComponents.weekday - 1;
    if (week == 0) {
        week = 7;
    }
    return week;
}

#pragma mark - 指定日期月份有多少天
- (NSUInteger)getDayNumOfMouth {
    
    NSUInteger daysInMouth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
    
    return daysInMouth;
}


#pragma mark - 获取指定日期的年月日
- (NSDateComponents *)getDateComponents {
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:self];
    
    return dateComponents;
}

#pragma mark - 获取指定日期是周几
- (NSUInteger)getWeek {
    NSUInteger week = [self getDateComponents].weekday;
    if (week == 0) {
        week = 7;
    }
    
    return week;
}


@end
