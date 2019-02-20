//
//  DSHeadReusableView.m
//  Calendar-OC
//
//  Created by duanshengwu on 2018/5/16.
//  Copyright © 2018年 D-James. All rights reserved.
//

#import "DSHeadReusableView.h"

@implementation DSHeadReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor lightGrayColor];
        
        
        UILabel *titleLabel = [UILabel new];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.centerY.equalTo(self);
        }];
    }
    return self;
}

@end
