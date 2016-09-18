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
    NSString *url = AJStr(comics/%ld/ep/%ld,(long)self.id,(long)self.ep);
    @weakify(self)
    [[self.viewModel.fetchComicPagesCommand execute:url] subscribeNext:^(NSArray<ComicPicEntity *>* arr) {
        @strongify(self)
        NSMutableArray* photoArr = [[NSMutableArray alloc] initWithCapacity:arr.count];
        for (ComicPicEntity* entity in arr) {
            MJPhoto* photo = [[MJPhoto alloc] init];
            photo.url = AJURL(entity.url);
            [photoArr addObject:photo];
        }
        self.dataSource = photoArr;
        [self showBrowser];
    } error:^(NSError *error) {
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
- (void)showBrowser {
    ComicPhotoBrowser *browser = self.browser;
    
    // Customise selection images to change colours if required
    //    browser.customImageSelectedIconName = @"ImageSelected.png";
    //    browser.customImageSelectedSmallIconName = @"ImageSelectedSmall.png";
    
    // Optionally set the current visible photo before displaying
    [browser setCurrentPhotoIndex:1];
    [self.view addSubview:browser.view];
    [self addChildViewController:browser];
    
    [UIView animateWithDuration:0.5 animations:^{
        browser.view.alpha = 1;
    }];
}

- (void)removeBrowser {
    [self.browser.view removeFromSuperview];
    [self.browser removeFromParentViewController];
}

- (ComicPhotoBrowser *)browser {

    return nil;
}

- (ComicBroswerViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ComicBroswerViewModel alloc] init];
    }
    return _viewModel;
}
@end
