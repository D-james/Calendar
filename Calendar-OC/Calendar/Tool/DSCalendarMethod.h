//
//  DSCalendarMethod.h
//  Calendar-OC
//
//  Created by duanshengwu on 2018/5/14.
//  Copyright © 2018年 D-James. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSCalendarMethod : NSObject

#pragma mark - 数据源方法
- (NSMutableArray *)setUpDataStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

@end
