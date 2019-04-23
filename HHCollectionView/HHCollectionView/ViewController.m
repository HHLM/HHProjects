//
//  ViewController.m
//  HHCollectionView
//
//  Created by Now on 2019/4/20.
//  Copyright © 2019 任他疾风起. All rights reserved.
//

#import "ViewController.h"
#import "HHCollectionViewCell.h"
#define kCount  4
@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self config];
    
}
- (void)config {
    self.title = @"🏠";
    [self creatMainUI];
}
- (void)creatMainUI {
    CGFloat margin = 10;
    CGFloat width = self.view.bounds.size.width;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((width - (kCount+1) * 10 )/kCount, 160);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
    
    UICollectionView *collectView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectView.delegate = self;
    collectView.dataSource = self;
    collectView.backgroundColor = [UIColor cyanColor];
    collectView.pagingEnabled = NO;
    collectView.directionalLockEnabled = YES;
    collectView.alwaysBounceVertical = YES;
    [collectView registerNib:[UINib nibWithNibName:NSStringFromClass([HHCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([HHCollectionViewCell class])];
    [self.view addSubview:collectView];
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return kCount;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HHCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HHCollectionViewCell class]) forIndexPath:indexPath];
    NSInteger index = indexPath.section * 3 + indexPath.row;
    index = index % 24;
    cell.imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%zd.jpg", index]];
    return cell;
    return cell;
}


@end
