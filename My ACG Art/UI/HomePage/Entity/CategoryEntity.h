//
//  CategoryEntity.h
//  My ACG Art
//
//  Created by 李 安君 on 16/9/13.
//  Copyright © 2016年 李 安君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ComicListEntity.h"

@interface CategoryEntity : RLMObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger all_comics;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *cover_image;

@property RLMArray<ComicListEntity *><ComicListEntity> *comicList;

@end
