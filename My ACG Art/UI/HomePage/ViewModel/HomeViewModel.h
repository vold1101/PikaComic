//
//  HomeViewModel.h
//  My ACG Art
//
//  Created by 李 安君 on 16/9/13.
//  Copyright © 2016年 李 安君. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HomeViewModel : NSObject

/**
 *  获取类别概要模型
 */
@property(nonatomic,strong)RACCommand *fetchCategoryEntityCommand;

@end
