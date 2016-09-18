//
//  MainTabBarController.m
//  My ACG Art
//
//  Created by 李 安君 on 16/9/8.
//  Copyright © 2016年 李 安君. All rights reserved.
//

#import "MainTabBarController.h"
#import "HomeViewController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initChildVC];
}


#pragma mark -
- (void)initChildVC {
    NSMutableArray * vcArray = [[NSMutableArray alloc] initWithCapacity:1];
    HomeViewController* vc1 = [[HomeViewController alloc] init];
    vc1.tabBarItem.title = @"首页";
    [vcArray addObject:vc1];
    
    [self setViewControllers:vcArray];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
