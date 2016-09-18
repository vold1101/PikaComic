//
//  NetManager.m
//  My ACG Art
//
//  Created by 李 安君 on 16/9/8.
//  Copyright © 2016年 李 安君. All rights reserved.
//

#import "NetManager.h"

@implementation NetManager
+(instancetype) shareManager {
    NetManager* manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"http://picaman.picacomic.com/api"]];
    return manager;
}

+(void)pikaMainAPIWithURL:(nullable NSString *)urlString
                  success:(nullable void (^)(id _Nullable responseObject))success
                  failure:(nullable void (^)(NSError * _Nullable error))failure {
    [[self shareManager] GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

+(void)pikaPageAPIWithPageStruct:(nullable PageStruct *)pageStruct
                         success:(nullable void (^)(id _Nullable responseObject))success
                         failure:(nullable void (^)(NSError * _Nullable error))failure {
    
    NSString *urlString = [NSString stringWithFormat:@"categories/%ld/page/%ld/comics",(long)pageStruct.category,(long)pageStruct.page];
    [[self shareManager] GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
}
@end
