//
//  DSWeekCell.m
//  Calendar-OC
//
//  Created by duanshengwu on 2018/5/16.
//  Copyright © 2018年 D-James. All rights reserved.
//

#import "DSWeekCell.h"


@interface DSWeekCell()


@end


@implementation DSWeekCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *titleLabel = [UILabel new];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        
    }
    return self;
}

@end

