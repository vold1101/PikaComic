//
//  HomeViewController.m
//  My ACG Art
//
//  Created by 李 安君 on 16/9/8.
//  Copyright © 2016年 李 安君. All rights reserved.
//

#import "HomeViewController.h"
#import "ComicListViewController.h"
#import "HomeCollectionViewCell.h"
#import "HomeViewModel.h"

@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView* collectionView;
@property (nonatomic,strong) RLMResults *dataSource;
@property (nonatomic,strong) HomeViewModel* viewModel;
@end

@implementation HomeViewController

static NSString* homeCellIdentifier = @"homeCellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    self.title = @"哔咔漫画";
    [self layout];
    
    @weakify(self)
    [[self.viewModel.fetchCategoryEntityCommand execute:@"categories"] subscribeNext:^(RLMResults* arr) {
        @strongify(self)
        self.dataSource = arr;
        [self.collectionView reloadData];
    }];
}

#pragma mark - delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:homeCellIdentifier forIndexPath:indexPath];
    
    cell.entity = self.dataSource[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CategoryEntity* entity = self.dataSource[indexPath.row];
    ComicListViewController* vc = [[ComicListViewController alloc] init];
    vc.entity = entity;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat size = (kScreenWidth/3)-10;
        layout.itemSize = CGSizeMake(size, size);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:kScreenBounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:homeCellIdentifier];
    }
    return _collectionView;
}

#pragma mark - layout
- (void)layout {
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}

- (HomeViewModel*)viewModel {
    if (!_viewModel) {
        _viewModel = [[HomeViewModel alloc] init];
    }
    return _viewModel;
}

@end
