//
//  ViewController.m
//  CollectionView
//
//  Created by lizq on 16/6/22.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import "ViewController.h"
#import "LineLayout.h"

#define ITEMNUMBER 20

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(strong, nonatomic) UICollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LineLayout *layout = [[LineLayout alloc] init];
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.itemSize = CGSizeMake((self.view.frame.size.width - 40)/5, (self.view.frame.size.width - 30)/4);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, (self.view.frame.size.width - 30)/4 + 20) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"item"];
    [self.view addSubview:self.collectionView];
    

}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor purpleColor];
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return ITEMNUMBER;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
