//
//  ComicDetailViewController.m
//  My ACG Art
//
//  Created by 李 安君 on 16/9/13.
//  Copyright © 2016年 李 安君. All rights reserved.
//

#import "ComicDetailViewController.h"
#import "ComicDetailViewModel.h"
#import "ComicDetailEntity.h"

@interface ComicDetailViewController ()

@property (nonatomic,strong) UIView* headView;
@property (nonatomic,strong) UIImageView* coverImageView;
@property (nonatomic,strong) UILabel* nameLabel;
@property (nonatomic,strong) UILabel* authorLabel;
@property (nonatomic,strong) UILabel* rankLabel;
@property (nonatomic,strong) UILabel* viewCountLabel;
@property (nonatomic,strong) UILabel* descLabel;

@property (nonatomic,strong) UILabel* updateLabel;
@property (nonatomic,strong) UILabel* userNameLabel;

@property (nonatomic,strong) UIButton* readBtn;
@property (nonatomic,strong) UIButton* commentsBtn;
@property (nonatomic,strong) UIButton* collectionBtn;

@property (nonatomic,strong) ComicDetailViewModel* viewModel;
@property (nonatomic,strong) ComicDetailEntity* entity;
@end

@implementation ComicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    self.title = [NSString stringWithFormat:@"%ld",(long)self.comicListEntity.id];
    [self loadViews];
    
    @weakify(self);
    [[self.viewModel.fetchComicDetailEntityCommand execute:[NSString stringWithFormat:@"comics/%ld",(long)self.comicListEntity.id]] subscribeNext:^(ComicDetailEntity* entity) {
        @strongify(self);
        self.entity = entity;
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ComicDetailViewModel*)viewModel {
    if (!_viewModel) {
        _viewModel = [[ComicDetailViewModel alloc] init];
    }
    return _viewModel;
}

- (void)setEntity:(ComicDetailEntity *)entity {
    _entity = entity;
    self.nameLabel.text = entity.name;
    [self.coverImageView sd_setImageWithURL:AJURL(entity.cover_image)];
    self.viewCountLabel.text = [NSString stringWithFormat:@"绅士指数:%ld",(long)entity.views_count];
    self.authorLabel.text = entity.author;
    NSMutableString* rankStr = [[NSMutableString alloc] initWithCapacity:5];
    for (NSInteger i = 1; i <= 5; ++i) {
        if (i <= entity.rank) {
            [rankStr appendString:@"★"];
        } else {
            [rankStr appendString:@"☆"];
        }
    }
    self.rankLabel.text = rankStr;
    [self.view layoutIfNeeded];
}

- (void)setComicListEntity:(ComicListEntity *)comicListEntity {
    _comicListEntity = comicListEntity;
    self.viewModel.comicListEntity = comicListEntity;
}

- (void)loadViews {
    [self loadHeadView];
    [self loadBtnView];
}

- (void)loadHeadView {
    self.headView = [UIView new];
    self.headView.backgroundColor = kWhiteColor;
    [self.view addSubview:self.headView];
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(@0);
    }];
    
    self.coverImageView = [UIImageView new];
    [self.headView addSubview:self.coverImageView];
    
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@15);
        make.top.equalTo(@5);
        make.bottom.lessThanOrEqualTo(@-5);
        make.size.equalTo(@90);
    }];
    
    self.nameLabel = [UILabel new];
    self.nameLabel.numberOfLines = 0;
    [self.nameLabel setFont:AJFont(15) color:kBlackColor];
    [self.headView addSubview:self.nameLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.coverImageView.mas_trailing).offset(5);
        make.top.equalTo(@5);
        make.trailing.lessThanOrEqualTo(@-15);
        make.bottom.lessThanOrEqualTo(@-5);
    }];
    
    self.authorLabel = [UILabel new];
    [self.authorLabel setFont:AJFont(15) color:kThemeColor];
    [self.headView addSubview:self.authorLabel];
    
    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.coverImageView.mas_trailing).offset(5);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
        make.trailing.lessThanOrEqualTo(@-15);
    }];
    
    self.viewCountLabel = [UILabel new];
    [self.viewCountLabel setFont:AJFont(12) color:kLightGrayColor];
    [self.headView addSubview:self.viewCountLabel];
    
    [self.viewCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.coverImageView.mas_trailing).offset(5);
        make.top.equalTo(self.authorLabel.mas_bottom).offset(5);
        make.trailing.lessThanOrEqualTo(@-15);
    }];
    
    self.rankLabel = [UILabel new];
    [self.rankLabel setFont:AJFont(15) color:kOrangeColor];
    [self.headView addSubview:self.rankLabel];
    
    [self.rankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.coverImageView.mas_trailing).offset(5);
        make.top.equalTo(self.viewCountLabel.mas_bottom).offset(5);
        make.trailing.lessThanOrEqualTo(@-15);
        make.bottom.equalTo(@-5);
    }];
}

- (void) loadBtnView {
    self.readBtn = [UIButton new];
    [self.readBtn setTitle:@"开始阅读" forState:UIControlStateNormal];
    [self.readBtn setFont:AJFont(14) color:kWhiteColor forState:UIControlStateNormal];
    [self.readBtn setBackgroundColor:kThemeColor];
    [self.view addSubview:self.readBtn];
    
    @weakify(self);
    [self.readBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.leading.equalTo(@15);
        make.top.equalTo(self.headView.mas_bottom).offset(5);
        make.width.equalTo(@66);
        make.height.equalTo(@44);
    }];
}
@end
