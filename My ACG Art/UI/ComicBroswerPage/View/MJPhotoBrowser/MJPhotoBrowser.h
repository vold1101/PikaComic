//
//  MJPhotoBrowser.h
//
//  Created by mj on 13-3-4.
//  Copyright (c) 2013年 itcast. All rights reserved.

#import "MJPhoto.h"

@class MJPhotoBrowser;

@protocol MJPhotoBrowserDelegate <NSObject>

@optional
- (void)browser:(MJPhotoBrowser *)browser didShowIndex:(NSInteger)index;
- (void)tapActionWithBrowser:(MJPhotoBrowser *)browser;

@end

@interface MJPhotoBrowser : NSObject <UIScrollViewDelegate>
// 所有的图片对象
@property (nonatomic, strong) NSArray *photos;
// 当前展示的图片索引
@property (nonatomic, assign) NSUInteger currentPhotoIndex;
// 保存按钮
@property (nonatomic, assign) NSUInteger showSaveBtn;

@property (nonatomic, weak) id<MJPhotoBrowserDelegate>delegate;

// 显示
- (void)showOnView:(UIView *)view;

//滚动操作
- (void)scrollToIndex:(NSInteger)index;

@end
