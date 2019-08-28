//
//  DaYiSelectedProjectView.m
//  DaYi_Common
//
//  Created by Fukai on 2019/8/12.
//  Copyright © 2019 FuKai. All rights reserved.
//

#import "DaYiSelectedProjectCardView.h"
#import "DYProjectCardView.h"
#import "DYProjectCardCollectionViewCell.h"

@interface DaYiSelectedProjectCardView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)QMUICollectionViewPagingLayout * collectionViewLayout;
@property (nonatomic, strong)UIPageControl * pageControl;

@end

@implementation DaYiSelectedProjectCardView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_offset(0.0);
        }];
        [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(20.0);
            make.left.right.mas_offset(0.0);
            make.bottom.mas_offset(0.0);
        }];
    }
    return self;
}

#pragma mark -- UICollectionViewDelegate,UICollectionViewDataSource --

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DYProjectCardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DYProjectCardCollectionViewCell" forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedProjectModel:)]) {
        [self.delegate didSelectedProjectModel:self.list[indexPath.row]];
    }
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeMake(CGRectGetWidth(collectionView.bounds) - UIEdgeInsetsGetHorizontalValue(self.collectionViewLayout.sectionInset), CGRectGetHeight(collectionView.bounds) - UIEdgeInsetsGetVerticalValue(self.collectionViewLayout.sectionInset));
    return size;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSLog(@"非人为拖动完毕");
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"人为拖动完毕");
    
    NSIndexPath * indexPath = self.collectionView.qmui_indexPathForFirstVisibleCell;
    if (scrollView.contentOffset.x <= 0) {
        self.pageControl.currentPage = 0;
    }else if(indexPath.row + 1 >= self.list.count){
        self.pageControl.currentPage = self.list.count - 1;
    }else{
        self.pageControl.currentPage = indexPath.row + 1;
    }
    [self.pageControl updateCurrentPageDisplay];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedProjectModel:)]) {
        [self.delegate selectedProjectModel:self.list[self.pageControl.currentPage]];
    }
}

#pragma mark -- setter getter --

- (QMUICollectionViewPagingLayout *)collectionViewLayout{
    if (!_collectionViewLayout) {
        _collectionViewLayout = [[QMUICollectionViewPagingLayout alloc] initWithStyle:QMUICollectionViewPagingLayoutStyleDefault];
        _collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.collectionViewLayout.sectionInset = UIEdgeInsetsMake(5, 30, 5, 30);
    }
    return _collectionViewLayout;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.collectionViewLayout];
        _collectionView.backgroundColor = UIColorClear;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[DYProjectCardCollectionViewCell class] forCellWithReuseIdentifier:@"DYProjectCardCollectionViewCell"];
        [self addSubview:_collectionView];
    }
    return _collectionView;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]init];
//        [_pageControl setValue:[UIImage imageNamed:@"image1"] forKeyPath:@"_pageImage"];
//        [_pageControl setValue:[UIImage imageNamed:@"image2"] forKeyPath:@"_currentPageImage"];
        _pageControl.pageIndicatorTintColor = UIColorRed;
        _pageControl.currentPageIndicatorTintColor = UIColorBlue;
        _pageControl.hidesForSinglePage = YES;
        [self addSubview:_pageControl];
    }
    return _pageControl;
}

- (void)setList:(NSArray *)list{
    _list = list;
    self.pageControl.numberOfPages = self.list.count;
    [self.collectionView reloadData];
}

@end
