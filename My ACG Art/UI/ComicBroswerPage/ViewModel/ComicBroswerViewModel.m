//
//  ComicBroswerViewModel.m
//  My ACG Art
//
//  Created by vvvvy on 16/9/14.
//  Copyright © 2016年 李 安君. All rights reserved.
//

#import "ComicBroswerViewModel.h"
#import "ComicPicEntity.h"

@implementation ComicBroswerViewModel

- (RACCommand *)fetchComicPagesCommand {
    if (!_fetchComicPagesCommand) {
        @weakify(self)
        _fetchComicPagesCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                //获取本地数据,若存在直接返回
                if (self.detailEntity.comicPicsEntity != nil) {
                    [subscriber sendNext:self.detailEntity.comicPicsEntity.comicPicArray];
                    [subscriber sendCompleted];
                    return nil;
                }
                
                NSString *url = AJStr(comics/%ld/ep/%ld,(long)self.detailEntity.id,(long)self.ep);
                [NetManager pikaMainAPIWithURL:url success:^(NSArray* arr) {
                    NSArray* entities = [ComicPicEntity objectArrayWithKeyValuesArray:arr];
                    if (self.detailEntity.comicPicsEntity == nil) {
                        ComicPicsEntity* picsEntity = [[ComicPicsEntity alloc] init];
                        [[RLMRealm defaultRealm] transactionWithBlock:^{
                            picsEntity.ep = self.ep;
                            [picsEntity.comicPicArray addObjects:entities];
                            self.detailEntity.comicPicsEntity = picsEntity;
                        }];
                    }
                    
                    [subscriber sendNext:self.detailEntity.comicPicsEntity.comicPicArray];
                    [subscriber sendCompleted];
                } failure:^(NSError * _Nullable error) {
                    [subscriber sendError:error];
                }];
                return nil;
            }];
        }];
    }
    return _fetchComicPagesCommand;
}

@end
