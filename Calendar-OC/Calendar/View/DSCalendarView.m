//
//  DSCalendarView.m
//  Calendar-OC
//
//  Created by duanshengwu on 2018/5/16.
//  Copyright © 2018年 D-James. All rights reserved.
//

#import "DSCalendarView.h"
#import "DSWCalendarCell.h"
#import "DSWeekCell.h"
#import "DSHeadReusableView.h"
#import "DSCalendarFlowLayout.h"

@interface DSCalendarView()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) DSCalendarFlowLayout *flowLayout;

@property (weak, nonatomic) UICollectionView *weekCollectionView;
@property (weak, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSArray<NSString *> *weekArray;
@property (strong, nonatomic) NSMutableArray *monthArray;


@property (assign, nonatomic) bool isFirstSelect;

@property (strong, nonatomic) NSIndexPath *startIndexPath;

@end

static NSString *cellID = @"cellID";
static NSString *weekCellID = @"weekCellID";
static NSString *HeadReusableViewID = @"HeadReusableViewID";

@implementation DSCalendarView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.isFirstSelect = true;
        
        [self setUpUI];
        
    }
    return self;
}

- (void)setUpUI {
    
    [self initWeekView];
    [self initCalendarView];
    
}

- (void)initWeekView {
    self.weekArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/7, 40);
    
    UICollectionView *weekCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [self addSubview:weekCollectionView];
    self.weekCollectionView = weekCollectionView;
    CGFloat topSpace = [UIApplication sharedApplication].statusBarFrame.size.height;
    [weekCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topSpace + 44);
        make.left.right.equalTo(self);
        make.height.equalTo(@40);
    }];
    
    weekCollectionView.dataSource = self;
    weekCollectionView.backgroundColor = [UIColor whiteColor];
    weekCollectionView.scrollEnabled = false;
    
    [weekCollectionView registerClass:DSWeekCell.class forCellWithReuseIdentifier:weekCellID];

}

- (void)initCalendarView {

    
    DSCalendarFlowLayout *flowLayout = [DSCalendarFlowLayout new];
    self.flowLayout = flowLayout;
    flowLayout.sectionHeadersPinToVisibleBounds = true;
    
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.left.bottom.equalTo(self);
        make.top.equalTo(self.weekCollectionView.mas_bottom);
    }];
    
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerClass:[DSWCalendarCell class] forCellWithReuseIdentifier:cellID];
    [collectionView registerClass:[DSHeadReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeadReusableViewID];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (collectionView == self.weekCollectionView) {
        return 1;
    }
    return self.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.weekCollectionView) {
        return self.weekArray.count;
    }
    return self.dataArray[section].count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == self.weekCollectionView) {
        DSWeekCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:weekCellID forIndexPath:indexPath];
        cell.titleLabel.text = self.weekArray[indexPath.row];
        
        return cell;
        
    }else {
        DSWCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
        
        cell.model = self.dataArray[indexPath.section][indexPath.row];
        
        return cell;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        DSHeadReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeadReusableViewID forIndexPath:indexPath];
        CalendarModel *model = self.dataArray[indexPath.section].lastObject;
        headView.titleLabel.text = [NSString stringWithFormat:@"%lu年%lu月",model.year,model.month];
        
        return headView;
    }else{
        return nil;
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(0, 40);
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger clickSection = indexPath.section;
    NSInteger clickRow = indexPath.row;
    CalendarModel *clickModel = self.dataArray[clickSection][clickRow];
    
    if (clickModel.dateStatus == Calendar_EmptyDate || clickModel.dateStatus == Calendar_PassedDate) {
        return;
    }
    if (self.isSingleSelect == true) {
        [self reductionData];
        clickModel.dateStatus = Calendar_SelectedDate;
    }else {//区间选择
        BOOL isShouldStartDate = false;

        if (self.isFirstSelect == false) {//如果选择的结束日期小于开始时间则变为选择开始时间
            if (clickSection == self.startIndexPath.section && clickRow > self.startIndexPath.row) {
                isShouldStartDate = false;
            }else if (clickSection > self.startIndexPath.section) {
                isShouldStartDate = false;
            }else{
                isShouldStartDate = true;
            }
        }else {
            isShouldStartDate = true;
        }
        
        if (isShouldStartDate) {//选择起始日期
            self.isFirstSelect = false;
            [self reductionData];
            for (int i = 0; i < self.dataArray.count; i++) {
                for (int k = 0; k < self.dataArray[i].count; k++) {
                    CalendarModel *model = self.dataArray[i][k];
                    if (i < clickSection || (i == clickSection && k < clickRow)) {
//                        if (model.dateStatus != Calendar_EmptyDate) {
//                            model.dateStatus = Calendar_PassedDate;
//                        }
                    }else if (i == clickSection && k == clickRow) {
                        if (model.dateStatus != Calendar_EmptyDate) {
                            model.dateStatus = Calendar_StartDate;
                            self.startIndexPath = indexPath;
                        }
                    }
                }
            }
        }else {
            self.isFirstSelect = true;
            for (NSInteger i = self.startIndexPath.section; i <= clickSection; i++) {
                for (int k = 0; k < self.dataArray[i].count; k++) {
                    CalendarModel *model = self.dataArray[i][k];
                    if (i == self.startIndexPath.section && i == clickSection && k > self.startIndexPath.row && k <= clickRow) {
                        model.dateStatus = Calendar_SelectedDate;
                    }else if (clickSection > self.startIndexPath.section) {
                        if (i == self.startIndexPath.section) {
                            if (model.dateStatus != Calendar_EmptyDate && k > self.startIndexPath.row) {
                                model.dateStatus = Calendar_SelectedDate;
                            }
                        }else if (i > self.startIndexPath.section && i < clickSection) {
                            if (model.dateStatus != Calendar_EmptyDate) {
                                model.dateStatus = Calendar_SelectedDate;
                            }
                        }else if (i == clickSection) {
                            if (k <= clickRow) {
                                if (model.dateStatus != Calendar_EmptyDate) {
                                    model.dateStatus = Calendar_SelectedDate;
                                }
                            }
                        }
                    }

                }
            }
            clickModel.dateStatus = Calendar_EndDate;
        }
    }
    
    [collectionView reloadData];
}


//还原数据为初始状态
- (void)reductionData {
    for (NSArray *mouthArray in self.dataArray) {
        for (CalendarModel *model in mouthArray) {
            if (model.dateStatus == Calendar_EmptyDate || model.dateStatus == Calendar_PassedDate) {
                
            }else{
                model.dateStatus = Calendar_NormalDate;
            }
        }
    }
}


#pragma mark - lazy load

- (void)setDataArray:(NSMutableArray<NSArray<CalendarModel *> *> *)dataArray {
    _dataArray = dataArray;
    
    for (NSArray<CalendarModel *> *monthArray in dataArray) {
        NSInteger monthNum = monthArray.lastObject.month;
        [self.monthArray addObject:@(monthNum)];
    }
    self.flowLayout.monthArray = self.monthArray;
    
    [self.collectionView reloadData];
}

- (NSMutableArray *)monthArray {
    if (_monthArray == nil) {
        _monthArray = [NSMutableArray array];
    }
    
    return _monthArray;
}


- (void)dealloc {
    NSLog(@"%s",__func__);
}


@end
