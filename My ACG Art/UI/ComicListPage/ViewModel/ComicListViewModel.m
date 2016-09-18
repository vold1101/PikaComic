//
//  ComicListViewModel.m
//  My ACG Art
//
//  Created by 李 安君 on 16/9/13.
//  Copyright © 2016年 李 安君. All rights reserved.
//

#import "ComicListViewModel.h"
#import "CategoryEntity.h"
#import "ComicListEntity.h"

@interface ComicListViewModel ()

@property (nonatomic,assign) NSInteger pageOffset;

@end

@implementation ComicListViewModel

- (instancetype)init
{
    if (self = [super init]) {
        self.pageOffset = 1;
        [self setupRACCommand];
    }
    return self;
}

- (void)setupRACCommand
{
    @weakify(self);
    _fetchComicListEntityCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(NSNumber* isBegin) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            if ([isBegin boolValue]) {
                self.pageOffset = 1;
            }
            PageStruct* pageStruct = [PageStruct structWithCategory:self.categoryEntity.id page:self.pageOffset];
            [self requestForComicListWithPageStruct:pageStruct success:^(NSArray *array) {
                NSArray *arrayM = [ComicListEntity objectArrayWithKeyValuesArray:array];
                for (ComicListEntity* entity in arrayM) {
                    entity.page = self.pageOffset;
                }
                
                [[RLMRealm defaultRealm] transactionWithBlock:^{
                    if ([isBegin boolValue]) {
                        [[RLMRealm defaultRealm] deleteObjects:self.categoryEntity.comicList];
                        [self.categoryEntity.comicList removeAllObjects];
                    }
                    [[RLMRealm defaultRealm] addOrUpdateObjectsFromArray:arrayM];
                    [self.categoryEntity.comicList addObjects:arrayM];
                }];
                
                RLMResults* res = [self.categoryEntity.comicList objectsWhere:@"page <= %ld",(long)self.pageOffset];
                [subscriber sendNext:res];
                self.pageOffset++;
                [subscriber sendCompleted];
            } failure:^(NSError *error) {
                [subscriber sendError:error];
            }];
            return nil;
        }];
    }];
}

- (RACCommand *)fetchLocalComicListCommand {
    if (!_fetchLocalComicListCommand) {
        _fetchLocalComicListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                RLMResults* res = [self.categoryEntity.comicList objectsWhere:@"page <= 1"];
                [subscriber sendNext:res];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _fetchLocalComicListCommand;
}

- (void)requestForComicListWithPageStruct:(PageStruct*)pageStruct success:(void (^)(NSArray *array))success failure:(void (^)(NSError *error))failure{
    [NetManager pikaPageAPIWithPageStruct:pageStruct success:^(id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}
@end
