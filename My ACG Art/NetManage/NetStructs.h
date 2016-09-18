//
//  NetStructs.h
//  My ACG Art
//
//  Created by 李 安君 on 16/9/13.
//  Copyright © 2016年 李 安君. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PageStruct : NSObject

@property (nonatomic,assign) NSInteger category;
@property (nonatomic,assign) NSInteger page;
//工厂方法
+(instancetype)structWithCategory:(NSInteger)category page:(NSInteger)page;

@end
