//
//  ComicBroswerViewModel.h
//  My ACG Art
//
//  Created by vvvvy on 16/9/14.
//  Copyright © 2016年 李 安君. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComicBroswerViewModel : NSObject

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger ep;

@property (nonatomic,strong) RACCommand* fetchComicPagesCommand;

@end
