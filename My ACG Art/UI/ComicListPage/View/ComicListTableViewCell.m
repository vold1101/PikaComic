//
//  ComicListTableViewCell.m
//  My ACG Art
//
//  Created by 李 安君 on 16/9/13.
//  Copyright © 2016年 李 安君. All rights reserved.
//

#import "ComicListTableViewCell.h"

@interface ComicListTableViewCell ()

@property (nonatomic,strong) UIImageView* coverImageView;
@property (nonatomic,strong) UILabel* nameLabel;
@property (nonatomic,strong) UILabel* authorLabel;
@property (nonatomic,strong) UILabel* rankLabel;

@end

@implementation ComicListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUp];
}

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}

- (void)setEntity:(ComicListEntity *)entity {
    _entity = entity;
    [self.coverImageView sd_setImageWithURL:AJURL(entity.cover_image)];
    self.nameLabel.text = [NSString stringWithFormat:@"%@(%ldP)",entity.name,(long)entity.total_page];
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
}

- (CGFloat)height {
    self.nameLabel.preferredMaxLayoutWidth = kScreenWidth - 30 - 90 - 5;
    [self.contentView layoutIfNeeded];
    CGSize size = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height+1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUp {
    self.contentView.bounds = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.coverImageView = [[UIImageView alloc] init];
    self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.coverImageView.clipsToBounds = YES;
    [self.contentView addSubview:self.coverImageView];
    
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@15);
        make.top.equalTo(@5);
        make.bottom.lessThanOrEqualTo(@-5);
        make.size.equalTo(@90);
    }];
    
    self.nameLabel = [UILabel new];
    self.nameLabel.numberOfLines = 0;
    [self.nameLabel setFont:AJFont(14) color:kBlackColor];
    [self.contentView addSubview:self.nameLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.coverImageView.mas_trailing).offset(5);
        make.top.equalTo(@5);
        make.trailing.lessThanOrEqualTo(@-15);
        make.bottom.lessThanOrEqualTo(@-5);
    }];
    
    
    self.authorLabel = [UILabel new];
    [self.authorLabel setFont:AJFont(12) color:kGrayColor];
    [self.contentView addSubview:self.authorLabel];
    
    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.coverImageView.mas_trailing).offset(5);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
        make.trailing.lessThanOrEqualTo(@-15);
    }];
    
    self.rankLabel = [UILabel new];
    [self.rankLabel setFont:AJFont(15) color:kOrangeColor];
    [self.contentView addSubview:self.rankLabel];
    
    [self.rankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.coverImageView.mas_trailing).offset(5);
        make.top.equalTo(self.authorLabel.mas_bottom).offset(5);
        make.trailing.lessThanOrEqualTo(@-15);
        make.bottom.lessThanOrEqualTo(@-5);
    }];
    
}
@end
