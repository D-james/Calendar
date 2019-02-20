//
//  DSCollectionReusableView.m
//  Calendar-OC
//
//  Created by duanshengwu on 2019/2/19.
//  Copyright © 2019 D-James. All rights reserved.
//

#import "DSCollectionReusableView.h"
#import "DSLayoutAttributes.h"

@interface DSCollectionReusableView()

@property (nonatomic, weak) UILabel *numLabel;
@end


@implementation DSCollectionReusableView


- (void)prepareForReuse {
    [super prepareForReuse];
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    //设置背景颜色
    DSLayoutAttributes *ecLayoutAttributes = (DSLayoutAttributes*)layoutAttributes;
    self.numLabel.text = ecLayoutAttributes.mouthStr;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitMonth) fromDate:[NSDate date]];
        NSInteger currentMouth = components.month;
        NSString *mouthStr = [NSString stringWithFormat:@"%lu",currentMouth];
        UILabel *numLabel = [UILabel new];
        [self addSubview:numLabel];
        self.numLabel = numLabel;
        [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self);
        }];
        numLabel.textAlignment = NSTextAlignmentCenter;
        numLabel.textColor = [UIColor cyanColor];
        numLabel.text = mouthStr;
        numLabel.font = [UIFont systemFontOfSize:300];
    }
    return self;
}





@end
