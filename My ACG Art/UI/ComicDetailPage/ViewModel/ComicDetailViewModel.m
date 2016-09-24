//
//  ComicDetailViewModel.m
//  My ACG Art
//
//  Created by 李 安君 on 16/9/13.
//  Copyright © 2016年 李 安君. All rights reserved.
//

#import "ComicDetailViewModel.h"
#import "ComicListEntity.h"
#import "ComicDetailEntity.h"

@implementation ComicDetailViewModel

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
    _fetchComicDetailEntityCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            RLMResults* res = [ComicDetailEntity objectsWhere:@"id == %ld",self.comicListEntity.id];
            __block ComicDetailEntity* localEntity;
            if (res.count) {
                localEntity = res.firstObject;
                self.didLoadEntity = YES;
                [subscriber sendNext:res.firstObject];
            }
            
            [self requestForNewsEntityWithUrl:input success:^(NSDictionary *dic) {
                [[RLMRealm defaultRealm] transactionWithBlock:^{
                    if (localEntity) {
                        [localEntity updateFromNet:dic];
                    } else {
                        localEntity = [ComicDetailEntity entityFromNet:dic];
                    }
                    [[RLMRealm defaultRealm] addOrUpdateObject:localEntity];
                }];
                self.didLoadEntity = YES;
                
                [subscriber sendNext:localEntity];
                [subscriber sendCompleted];
            } failure:^(NSError *error) {
                [subscriber sendError:error];
            }];
            return nil;
        }];
    }];
}

- (void)requestForNewsEntityWithUrl:(NSString *)url success:(void (^)(NSDictionary *dic))success failure:(void (^)(NSError *error))failure{
    [NetManager pikaMainAPIWithURL:url success:^(id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

@end
