//
//  DSCalendarFlowLayout.m
//  Calendar-OC
//
//  Created by duanshengwu on 2018/5/16.
//  Copyright © 2018年 D-James. All rights reserved.
//

#import "DSCalendarFlowLayout.h"
#import "DSHeadReusableView.h"
#import "DSLayoutAttributes.h"
#import "DSCollectionReusableView.h"

@interface DSCalendarFlowLayout ()


@end


@implementation DSCalendarFlowLayout

static NSString *kDecorationReuseIdentifier = @"kDecorationReuseIdentifier";

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)prepareLayout {
    [super prepareLayout];

    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    CGFloat itemWidth = self.collectionView.frame.size.width/7.0;
    self.itemSize = CGSizeMake(itemWidth, 74);
    
    [self registerClass:[DSCollectionReusableView class] forDecorationViewOfKind:kDecorationReuseIdentifier];
    
//    if (@available(iOS 10.0, *)) {
//        self.collectionView.prefetchingEnabled = false;
//    } else {
//        // Fallback on earlier versions
//    }
}


- (BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect)newBound {
    
    return true;
    
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind atIndexPath:(NSIndexPath *)indexPath top:(CGFloat)top {// 实现该方法
    
//    UICollectionViewLayoutAttributes *layoutAttribute = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:decorationViewKind withIndexPath:indexPath];
    
    DSLayoutAttributes *layoutAttribute = [DSLayoutAttributes layoutAttributesForDecorationViewOfKind:decorationViewKind withIndexPath:indexPath];

    layoutAttribute.mouthStr = [NSString stringWithFormat:@"%@",self.monthArray[indexPath.section]];
    
    layoutAttribute.frame = CGRectMake(0, top, [UIScreen mainScreen].bounds.size.width, 375);
    layoutAttribute.zIndex = -1;
    
    
    return layoutAttribute;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *superAttrs = [super layoutAttributesForElementsInRect:rect];
    
    //消除cell之间的列间距
    for(int i = 1; i < superAttrs.count; ++i) {
        UICollectionViewLayoutAttributes *currentLayoutAttributes = superAttrs[i];
        UICollectionViewLayoutAttributes *prevLayoutAttributes = superAttrs[i - 1];
        if (currentLayoutAttributes.indexPath.section != prevLayoutAttributes.indexPath.section) {
            continue;
        }
        NSInteger maximumSpacing = 0;
        NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);

        if(origin + maximumSpacing + currentLayoutAttributes.frame.size.width < self.collectionViewContentSize.width) {
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = origin + maximumSpacing;
            currentLayoutAttributes.frame = frame;
        }
    }
    
    
    NSMutableArray *attrs = [NSMutableArray arrayWithArray:superAttrs];
    
//    避免多次调用设置section背景图片
    NSInteger sectionNum = 0;
    BOOL isSet = true;
    for (UICollectionViewLayoutAttributes *attr in superAttrs) {

        if (isSet) {
            if (attr.indexPath.section == 0) {
                sectionNum = attr.indexPath.section;
                
            }else {
                sectionNum = attr.indexPath.section + 1;//只计算当前显示的分组
                
            }
            isSet = false;
        }
        
        if (sectionNum == attr.indexPath.section) {

            [attrs addObject:[self layoutAttributesForDecorationViewOfKind:kDecorationReuseIdentifier atIndexPath:attr.indexPath top:attr.frame.origin.y]];
            
            sectionNum ++;
        }
        
    }

    return attrs;
    
}


//- (CGRect)fixSlit:(CGRect)rect colCount:(CGFloat)colCount {
//
//    CGFloat space = 0;
//    CGFloat totalSpace = (colCount - 1) * space; // 总共留出的距离
//    CGFloat itemWidth = (rect.size.width - totalSpace) / colCount;  // 按照真实屏幕算出的cell宽度
//    CGFloat fixValue = 1 / [UIScreen mainScreen].scale; //（1px=0.5pt,6p为3px=1pt）
//    CGFloat realItemWidth = floor(itemWidth) + fixValue; // 取整加fixValue
//    if (realItemWidth < itemWidth) { // 有可能原cell宽度小数点后一位大于0.5
//        realItemWidth += 0.5;
//    }
//    CGFloat realWidth = colCount * realItemWidth + totalSpace; // 算出屏幕等分后满足`1px=0.5pt`实际的宽度
//    CGFloat pointX = (realWidth - rect.size.width) / 2 ;// 偏移距离
//    rect.origin.x = -pointX; // 向左偏移
//    rect.size.width = realWidth;
//    rect.size.width = (rect.size.width - totalSpace) / colCount;
//
//    return rect; // 每个cell真实宽度
//}
//
//for (UICollectionViewLayoutAttributes *attr in superAttrs) {
//
//    if (attr.frame.origin.x == 0) {
//        CGFloat width = self.collectionView.frame.size.width;
//        CGFloat itemWidth = floor(self.collectionView.frame.size.width/7.0);
//        CGFloat firstWidth = width - 6*itemWidth;
//        CGRect frame = CGRectMake(attr.frame.origin.x, attr.frame.origin.y, firstWidth, attr.frame.size.height);
//        attr.frame = frame;
//    }
//}


@end
