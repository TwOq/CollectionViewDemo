//
//  FlowWaterLayout.m
//  CollectionView
//
//  Created by lizq on 16/6/23.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import "FlowWaterLayout.h"
#define WIDTH       (self.collectionView.frame.size.width)

@interface FlowWaterLayout ()
@property(strong, nonatomic) NSMutableArray *heightArrays;
@property(strong, nonatomic) NSMutableArray *attributes;
@property(assign, nonatomic) CGPoint lowPoint;
@property(assign, nonatomic) float heghtY;
@property(strong, nonatomic) NSMutableDictionary *baseDic;
@end

@implementation FlowWaterLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.heightArrays = [NSMutableArray arrayWithCapacity:0];
    self.attributes = [NSMutableArray arrayWithCapacity:0];
    self.baseDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [self calculateAttributes];
    
}

// 生成随机高度
- (void)calculateRandomHeight:(NSInteger)totalItems {
    
    for (int i = 0; i < totalItems; i++) {
        int x = arc4random() % 200 + 50;
        [self.heightArrays addObject:[NSString stringWithFormat:@"%d",x]];
    }
}

- (void)calculateAttributes {
    
    NSInteger totalItems = [self.collectionView numberOfItemsInSection:0];
    self.heghtY = 0;
    [self calculateRandomHeight:totalItems];
    
    for (int i = 0; i < totalItems; i++) {
        
        UICollectionViewLayoutAttributes *item = [super layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        
        //第一行 不做位置改变，只改变高度
        if (item.frame.origin.y != 0) {
            CGRect frame = item.frame;
            item.frame = CGRectMake(self.lowPoint.x, self.lowPoint.y + self.minimumLineSpacing, frame.size.width, [self.heightArrays[i] floatValue]);
        }else{
            CGRect frame = item.frame;
            item.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, [self.heightArrays[i] floatValue]);
        }
        //记录每一列最后一个元素的最小x坐标和最大y坐标
        [self.baseDic setValue:NSStringFromCGPoint(CGPointMake(item.frame.origin.x, CGRectGetMaxY(item.frame)))
                        forKey:[NSString stringWithFormat:@"%f",item.frame.origin.x]];
        
        //查找y坐标最小的点
        @autoreleasepool {
            NSString *tempKey = nil;
            float tempY = MAXFLOAT;
            for (NSString *key in self.baseDic.allKeys) {
                CGPoint point = CGPointFromString(self.baseDic[key]);
                if (point.y <= tempY) {
                    tempY = point.y;
                    tempKey = key;
                }
                if (point.y > self.heghtY) {
                    self.heghtY = point.y;
                }
            }
            self.lowPoint = CGPointFromString(self.baseDic[tempKey]);
        }
        
        [self.attributes addObject:item.copy];
    }

}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {

    return self.attributes;
}

- (CGSize)collectionViewContentSize{
    CGSize size = CGSizeMake(WIDTH, self.heghtY + self.minimumLineSpacing);
    return size;
}

@end
