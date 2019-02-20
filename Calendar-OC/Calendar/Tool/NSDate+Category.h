//
//  NSDate+Category.h
//  Calendar-OC
//
//  Created by duanshengwu on 2018/5/15.
//  Copyright © 2018年 D-James. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Category)

#pragma mark - 获取特定日期月份第一天是周几
- (NSUInteger)getFirstWeekInMonth;

#pragma mark - 指定日期月份有多少天
- (NSUInteger)getDayNumOfMouth;

#pragma mark - 获取指定日期的年月日
- (NSDateComponents *)getDateComponents;

#pragma mark - 获取指定日期是周几
- (NSUInteger)getWeek;


@end
