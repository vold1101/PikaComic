//
//  ComicDetailEntity.m
//  My ACG Art
//
//  Created by 李 安君 on 16/9/13.
//  Copyright © 2016年 李 安君. All rights reserved.
//

#import "ComicDetailEntity.h"

@implementation ComicDetailEntity

+ (instancetype)entityFromNet:(NSDictionary *)dic {
    ComicDetailEntity* entity = [[ComicDetailEntity alloc] initFromNet:dic];
    return entity;
}

- (instancetype) initFromNet:(NSDictionary *)dic {
    if (self = [super init]) {
        [self updateFromNet:dic];
    }
    return self;
}

- (void)updateFromNet:(NSDictionary *)dic {
    NSDictionary *comicDic = dic[@"comic"];
    NSArray *allKeys = [comicDic allKeys];
    for (NSString *key in allKeys) {
        if ([[[[self class] replacedKeyFromPropertyName] allKeys] containsObject:key]) {
            NSString* replaceKey = [[self class] replacedKeyFromPropertyName][key];
            [self setValue:comicDic[key] forKey:replaceKey];
        } else if (![key isEqualToString:[[self class] primaryKey]] || self.id == 0){
            [self setValue:comicDic[key] forKey:key];

        }
    }
    self.ep_count = [dic[@"ep_count"] integerValue];
}

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"description":@"desc"};
}

+ (NSString *)primaryKey {
    return @"id";
}
@end


