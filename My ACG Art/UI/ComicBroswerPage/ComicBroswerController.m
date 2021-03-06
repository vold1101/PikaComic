//
//  ComicBroswerController.m
//  My ACG Art
//
//  Created by 李 安君 on 16/9/14.
//  Copyright © 2016年 李 安君. All rights reserved.
//

//请求地址 /comics/9498/ep/1
#import "ComicBroswerController.h"
#import "ComicPicEntity.h"
#import "ComicBroswerViewModel.h"
#import "MJPhotoBrowser.h"

@interface ComicBroswerController ()<MJPhotoBrowserDelegate>

@property (nonatomic,strong) ComicBroswerViewModel* viewModel;
@property (nonatomic,strong) NSMutableArray* dataSource;
@property (nonatomic,strong) MJPhotoBrowser *browser;

@end

@implementation ComicBroswerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBlackColor;
    @weakify(self)
    [SVProgressHUD show];
    [[self.viewModel.fetchComicPagesCommand execute:nil] subscribeNext:^(RLMArray* arr) {
        @strongify(self)
        [SVProgressHUD dismiss];
        NSMutableArray* photoArr = [[NSMutableArray alloc] initWithCapacity:arr.count];
        for (ComicPicEntity* entity in arr) {
            MJPhoto* photo = [[MJPhoto alloc] init];
            photo.url = AJURL(entity.url);
            [photoArr addObject:photo];
        }
        self.dataSource = photoArr;
        [self showBrowser];
    } error:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"连接超时"];
        NSLog(@"%@",error);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //    [self removeBrowser];
    //    [self setDefaultNavbarStyle];
}

#pragma mark -
- (void)browser:(MJPhotoBrowser *)browser didShowIndex:(NSInteger)index {
    @weakify(self)
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        @strongify(self)
        self.detailEntity.comicPicsEntity.readOffset = index;
    }];
}

- (void)tapActionWithBrowser:(MJPhotoBrowser *)browser {
    
}

#pragma mark -
- (void)showBrowser {
    self.browser.photos = self.dataSource;
    self.browser.currentPhotoIndex = self.detailEntity.comicPicsEntity.readOffset;
    [self.browser showOnView:self.view];
}

- (void)removeBrowser {
}

- (MJPhotoBrowser *)browser {
    if (!_browser) {
        _browser = [[MJPhotoBrowser alloc] init];
        _browser.delegate = self;
    }
    return _browser;
}

- (ComicBroswerViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ComicBroswerViewModel alloc] init];
        _viewModel.detailEntity = self.detailEntity;
        _viewModel.ep = self.ep;
    }
    return _viewModel;
}
@end
