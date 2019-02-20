//
//  DSWCalendarCell.m
//  Calendar-OC
//
//  Created by duanshengwu on 2018/5/15.
//  Copyright © 2018年 D-James. All rights reserved.
//

#import "DSWCalendarCell.h"

@interface DSWCalendarCell()

@property (weak, nonatomic) UILabel *numLabel;
@property (weak, nonatomic) UILabel *upInfoLabel;

@end

@implementation DSWCalendarCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *numLabel = [UILabel new];
        [self addSubview:numLabel];
        self.numLabel = numLabel;
        [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        
        
        UILabel *upInfoLabel = [UILabel new];
        [self addSubview:upInfoLabel];
        self.upInfoLabel = upInfoLabel;
        [upInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(numLabel.mas_top).offset(-3);
        }];
        upInfoLabel.font = [UIFont systemFontOfSize:13];
        upInfoLabel.textColor = [UIColor whiteColor];
        
    }
    
    return self;
}


- (void)setModel:(CalendarModel *)model {
    _model = model;
    
    if (model.dateStatus == Calendar_EmptyDate) {
        self.hidden = true;
    }else {
        self.hidden = false;
    }
    
    switch (model.dateStatus) {
        case Calendar_SelectedDate:
            self.backgroundColor = [UIColor purpleColor];
            self.numLabel.textColor = [UIColor whiteColor];
            break;
        case Calendar_StartDate:
        case Calendar_EndDate:
            self.backgroundColor = [UIColor redColor];
            self.numLabel.textColor = [UIColor whiteColor];
            break;
        case Calendar_PassedDate:
            self.backgroundColor = [UIColor clearColor];
            self.numLabel.textColor = [UIColor lightGrayColor];
            break;
        case Calendar_NormalDate:
            self.backgroundColor = [UIColor clearColor];
            self.numLabel.textColor = [UIColor blackColor];
            break;
        default:
            break;
    }
    
    switch (model.dateStatus) {
        case Calendar_StartDate:
            self.upInfoLabel.text = @"开始";
            break;
        case Calendar_EndDate:
            self.upInfoLabel.text = @"结束";
            break;
        default:
            self.upInfoLabel.text = @"";
            break;
    }

    self.numLabel.text = [NSString stringWithFormat:@"%lu",model.day];
}
@end
