//
//  ComicListViewModel.h
//  My ACG Art
//
//  Created by 李 安君 on 16/9/13.
//  Copyright © 2016年 李 安君. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CategoryEntity;
@interface ComicListViewModel : NSObject

@property (nonatomic,strong) CategoryEntity* categoryEntity;

/**
 *  获取漫画列表本地数据模型
 */
@property(nonatomic,strong) RACCommand *fetchLocalComicListCommand;

/**
 *  获取漫画列表概要模型
 */
@property(nonatomic,strong) RACCommand *fetchComicListEntityCommand;

@end
