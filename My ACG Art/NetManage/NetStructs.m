//
//  NetStructs.m
//  My ACG Art
//
//  Created by 李 安君 on 16/9/13.
//  Copyright © 2016年 李 安君. All rights reserved.
//

#import "NetStructs.h"

@implementation PageStruct

+(instancetype)structWithCategory:(NSInteger)category page:(NSInteger)page {
    PageStruct* pageStruct = [PageStruct new];
    pageStruct.category = category;
    pageStruct.page = page;
    return pageStruct;
}
@end
