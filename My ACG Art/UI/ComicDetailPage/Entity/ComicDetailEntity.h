//
//  ComicDetailEntity.h
//  My ACG Art
//
//  Created by 李 安君 on 16/9/13.
//  Copyright © 2016年 李 安君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ComicPicEntity.h"

@interface ComicDetailEntity : RLMObject

+ (instancetype)entityFromNet:(NSDictionary *)dic;
- (instancetype)initFromNet:(NSDictionary *)dic;
- (void)updateFromNet:(NSDictionary *)dic;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, assign) NSInteger comment_count;

@property (nonatomic, copy) NSString *img_directory;

@property (nonatomic, copy) NSString *author;

@property (nonatomic, assign) NSInteger views_count;

@property (nonatomic, copy) NSString *cover_image;

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, assign) NSInteger rank;

@property (nonatomic, assign) NSInteger total_page;

@property (nonatomic, copy) NSString *updated_at;

@property (nonatomic, copy) NSString *display_name;

@property (nonatomic, copy) NSString *finished;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger ep_count;

@property ComicPicsEntity* comicPicsEntity;

@end
