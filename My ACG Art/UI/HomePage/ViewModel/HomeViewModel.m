//
//  HomeViewModel.m
//  My ACG Art
//
//  Created by 李 安君 on 16/9/13.
//  Copyright © 2016年 李 安君. All rights reserved.
//

#import "HomeViewModel.h"
#import "CategoryEntity.h"

@implementation HomeViewModel

- (instancetype)init
{
    if (self = [super init]) {
        [self setupRACCommand];
    }
    return self;
}

- (void)setupRACCommand
{
    @weakify(self);
    _fetchCategoryEntityCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            RLMResults* res = [CategoryEntity allObjects];
            if (res.count) {
                [subscriber sendNext:res];
            }
            [self requestForNewsEntityWithUrl:input success:^(NSArray *array) {
                NSArray *arrayM = [CategoryEntity objectArrayWithKeyValuesArray:array];
                RLMRealm* realm = [RLMRealm defaultRealm];
                [realm transactionWithBlock:^{
                    [realm addOrUpdateObjectsFromArray:arrayM];
                }];
                RLMResults* res = [CategoryEntity allObjects];
                [subscriber sendNext:res];
                [subscriber sendCompleted];
            } failure:^(NSError *error) {
                [subscriber sendError:error];
            }];
            return nil;
        }];
    }];
}

- (void)requestForNewsEntityWithUrl:(NSString *)url success:(void (^)(NSArray *array))success failure:(void (^)(NSError *error))failure{
    [NetManager pikaMainAPIWithURL:url success:^(id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

@end
