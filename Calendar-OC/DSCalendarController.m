//
//  DSCalendarController.m
//  Calendar-OC
//
//  Created by duanshengwu on 2019/2/20.
//  Copyright © 2019 D-James. All rights reserved.
//

#import "DSCalendarController.h"
#import "DSCalendarMethod.h"
#import "CalendarModel.h"

#import "NSDate+Category.h"
#import "DSCalendarView.h"


@interface DSCalendarController ()

@end

@implementation DSCalendarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //    NSString *dateStr = @"2018-5-13";
    //    NSString *dateStr2 = @"2019-5-13";
    //
    //    NSDateFormatter *formatter = [NSDateFormatter new];
    //    formatter.dateFormat = @"yyyy-MM-dd";
    //
    //    NSDate *date = [formatter dateFromString:dateStr];
    //    NSDate *date2 = [formatter dateFromString:dateStr2];
    
    NSDate *date = [NSDate new];
    NSDate *date2 = [NSDate dateWithTimeIntervalSinceNow:60*60*24*365];
    
    DSCalendarView *calendarV = [DSCalendarView new];
    [self.view addSubview:calendarV];
    [calendarV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    
    calendarV.dataArray = [[DSCalendarMethod new]setUpDataStartDate:date endDate:date2];
    calendarV.isSingleSelect = self.isSingleSelect;
}



@end
