//
//  ComicListViewController.m
//  My ACG Art
//
//  Created by 李 安君 on 16/9/13.
//  Copyright © 2016年 李 安君. All rights reserved.
//

#import "ComicListViewController.h"
#import "ComicDetailViewController.h"
#import "ComicListViewModel.h"
#import "ComicListTableViewCell.h"

@interface ComicListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,strong) ComicListViewModel* viewModel;
@property (nonatomic,strong) RLMResults* dataSource;

@property (nonatomic,strong) ComicListTableViewCell* heightCell;

@end

@implementation ComicListViewController

static NSString* comicListCellIdentifier = @"comicListCellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.entity.name;
    [self.view addSubview:self.tableView];
    [self layout];
    
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self loadData];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self loadMoreData];
    }];
    [[self.viewModel.fetchLocalComicListCommand execute:nil] subscribeNext:^(RLMResults* res) {
        @strongify(self);
        self.dataSource = res;
        [self.tableView reloadData];
    } error:^(NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
    [self.tableView.mj_header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.heightCell == nil) {
        self.heightCell = [tableView dequeueReusableCellWithIdentifier:comicListCellIdentifier];
    }
    self.heightCell.entity = self.dataSource[indexPath.row];
    return self.heightCell.height;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ComicListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:comicListCellIdentifier];
    cell.entity = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ComicDetailViewController* vc = [[ComicDetailViewController alloc] init];
    ComicListEntity* entity = self.dataSource[indexPath.row];
    vc.comicListEntity = entity;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -
- (void)loadData {
    @weakify(self);
    [[self.viewModel.fetchComicListEntityCommand execute:@(YES)] subscribeNext:^(RLMResults* arr) {
        @strongify(self);
        self.dataSource = arr;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } error:^(NSError *error) {
        NSLog(@"%@",error);
        [self.tableView.mj_header endRefreshing];
    }];
}
- (void)loadMoreData {
    @weakify(self);
    [[self.viewModel.fetchComicListEntityCommand execute:@(NO)] subscribeNext:^(RLMResults* arr) {
        @strongify(self);
        self.dataSource = arr;
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } error:^(NSError *error) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }];
}

- (ComicListViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ComicListViewModel alloc] init];
    }
    return _viewModel;
}

- (void)setEntity:(CategoryEntity *)entity {
    _entity = entity;
    self.viewModel.categoryEntity = entity;
}
#pragma mark - view
- (UITableView*)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        self.tableView.rowHeight = UITableViewAutomaticDimension;
        [_tableView registerClass:[ComicListTableViewCell class] forCellReuseIdentifier:comicListCellIdentifier];
    }
    return _tableView;
}

#pragma mark - layout
- (void)layout {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}
@end
