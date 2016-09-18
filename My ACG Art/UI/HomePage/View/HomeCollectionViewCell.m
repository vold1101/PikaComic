//
//  HomeCollectionViewCell.m
//  My ACG Art
//
//  Created by 李 安君 on 16/9/13.
//  Copyright © 2016年 李 安君. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@interface HomeCollectionViewCell ()

@property (nonatomic,strong) UIImageView* imageView;
@property (nonatomic,strong) UILabel* label;
@end

@implementation HomeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)setEntity:(CategoryEntity *)entity {
    _entity = entity;
    [self.imageView sd_setImageWithURL:AJURL(entity.cover_image)];
    self.label.text = entity.name;
}

- (void)setUp {
    self.imageView = [[UIImageView alloc] init];
    [self addSubview:self.imageView];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    self.label = [UILabel new];
    [self.label setFont:AJFont(14) color:[UIColor whiteColor]];
    self.label.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    [self addSubview:self.label];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.leading.trailing.equalTo(@0);
        make.height.equalTo(@18);
    }];
}
@end
