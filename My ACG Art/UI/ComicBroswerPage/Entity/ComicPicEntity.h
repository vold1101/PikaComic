//
//  ComicPicEntity.h
//  My ACG Art
//
//  Created by 李 安君 on 16/9/14.
//  Copyright © 2016年 李 安君. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComicPicEntity : RLMObject

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, assign) NSInteger height;

@end

RLM_ARRAY_TYPE(ComicPicEntity);

@interface ComicPicsEntity : RLMObject

@property NSInteger ep;
@property NSInteger readOffset;
@property RLMArray<ComicPicEntity *><ComicPicEntity> *comicPicArray;

@end
