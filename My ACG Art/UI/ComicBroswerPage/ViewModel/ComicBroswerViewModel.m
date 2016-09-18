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
        _fetchComicPagesCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSString* url) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [NetManager pikaMainAPIWithURL:url success:^(NSArray* arr) {
                    NSArray* entities = [ComicPicEntity objectArrayWithKeyValuesArray:arr];
                    [subscriber sendNext:entities];
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
