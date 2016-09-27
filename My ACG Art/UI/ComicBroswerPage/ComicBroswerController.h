//
//  ComicBroswerController.h
//  My ACG Art
//
//  Created by 李 安君 on 16/9/14.
//  Copyright © 2016年 李 安君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComicDetailEntity.h"
#import "PikaViewController.h"

@interface ComicBroswerController : PikaViewController

@property (nonatomic,strong) ComicDetailEntity* detailEntity;
@property (nonatomic,assign) NSInteger ep;

@end
