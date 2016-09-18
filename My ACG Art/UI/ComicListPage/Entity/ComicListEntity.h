//
//  ComicListEntity.h
//  My ACG Art
//
//  Created by 李 安君 on 16/9/13.
//  Copyright © 2016年 李 安君. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComicListEntity : RLMObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, copy) NSString *author;

@property (nonatomic, assign) NSInteger cats;

@property (nonatomic, copy) NSString *finished;

@property (nonatomic, assign) NSInteger total_page;

@property (nonatomic, copy) NSString *cover_image;

@property (nonatomic, assign) NSInteger rank;

@property (nonatomic, copy) NSString *updated_at;

@property (nonatomic, copy) NSString *name;

@end

RLM_ARRAY_TYPE(ComicListEntity)
