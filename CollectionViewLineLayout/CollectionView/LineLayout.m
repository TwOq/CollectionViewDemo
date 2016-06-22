//
//  LineLayout.m
//  CollectionView
//
//  Created by lizq on 16/6/22.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import "LineLayout.h"

#define SIZSCALE 2.5
#define MINSCALE 3
#define WIDTH       (self.collectionView.frame.size.width)

@interface LineLayout ()
@property(strong, nonatomic) NSMutableArray *attriArray;

@end

@implementation LineLayout

- (void)prepareLayout{
    [super prepareLayout];
    //设置偏移
    self.sectionInset = UIEdgeInsetsMake(0, WIDTH/2 - self.itemSize.width/2, 0, WIDTH/2 - self.itemSize.width/2);
}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSMutableArray *attriArray = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *superAttributes = (NSMutableArray *)[super layoutAttributesForElementsInRect:rect];
    
    float collectionViewCenterX = WIDTH/SIZSCALE;
    
    for (UICollectionViewLayoutAttributes *item in superAttributes) {
        //判断item是否在显示区域
        if (CGRectIntersectsRect(item.frame, rect)) {
            float absX = fabs(item.center.x - self.collectionView.contentOffset.x);
            if (absX > collectionViewCenterX) {
                absX = fabs(absX - self.collectionView.frame.size.width);
            }
            //控制最大缩放比例
            absX = MIN(collectionViewCenterX, absX);
            //控制最小缩放比例
            absX = MAX(absX, collectionViewCenterX/MINSCALE);
            float scale = absX/collectionViewCenterX;
            item.transform = CGAffineTransformMakeScale(scale, scale);
        }
        [attriArray addObject:item];
    }
    return attriArray;
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}


@end
