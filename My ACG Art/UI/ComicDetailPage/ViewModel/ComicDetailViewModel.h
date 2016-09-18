//
//  ComicDetailViewModel.h
//  My ACG Art
//
//  Created by 李 安君 on 16/9/13.
//  Copyright © 2016年 李 安君. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ComicListEntity;
@interface ComicDetailViewModel : NSObject

@property (nonatomic,strong) ComicListEntity* comicListEntity;
/**
 *  获取详情概要模型
 */
@property(nonatomic,strong)RACCommand *fetchComicDetailEntityCommand;

@end
