//
//  NetManager.h
//  My ACG Art
//
//  Created by 李 安君 on 16/9/8.
//  Copyright © 2016年 李 安君. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "NetStructs.h"

@interface NetManager : AFHTTPSessionManager

+(nullable instancetype) shareManager;

+(void)pikaMainAPIWithURL:(nullable NSString *)urlString
                 success:(nullable void (^)(id _Nullable responseObject))success
                     failure:(nullable void (^)(NSError * _Nullable error))failure;

+(void)pikaPageAPIWithPageStruct:(nullable PageStruct *)pageStruct
                     success:(nullable void (^)(id _Nullable responseObject))success
                         failure:(nullable void (^)(NSError * _Nullable error))failure;
@end
