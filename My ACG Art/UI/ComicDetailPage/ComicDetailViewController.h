//
//  ComicDetailViewController.h
//  My ACG Art
//
//  Created by 李 安君 on 16/9/13.
//  Copyright © 2016年 李 安君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComicListEntity.h"
#import "PikaViewController.h"

@interface ComicDetailViewController : PikaViewController

@property (nonatomic,strong) ComicListEntity* comicListEntity;
@end
