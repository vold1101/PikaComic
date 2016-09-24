//
//  ComicBroswerViewModel.h
//  My ACG Art
//
//  Created by vvvvy on 16/9/14.
//  Copyright © 2016年 李 安君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ComicDetailEntity.h"

@interface ComicBroswerViewModel : NSObject

@property (nonatomic, strong) ComicDetailEntity* detailEntity;
@property (nonatomic, assign) NSInteger ep;

@property (nonatomic,strong) RACCommand* fetchComicPagesCommand;

@end
