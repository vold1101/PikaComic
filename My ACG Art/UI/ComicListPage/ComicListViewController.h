//
//  ComicListViewController.h
//  My ACG Art
//
//  Created by 李 安君 on 16/9/13.
//  Copyright © 2016年 李 安君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryEntity.h"
#import "PikaViewController.h"

@interface ComicListViewController : PikaViewController

@property (nonatomic,strong) CategoryEntity* entity;

@end
