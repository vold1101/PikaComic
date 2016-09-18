//
//  UIView+Setting.m
//  My ACG Art
//
//  Created by 李 安君 on 16/9/14.
//  Copyright © 2016年 李 安君. All rights reserved.
//

#import "UIView+Setting.h"

@implementation UIButton (Setting)

- (void)setFont:(UIFont*)font color:(UIColor *)color forState:(UIControlState)state {
    self.titleLabel.font = font;
    [self setTitleColor:color forState:state];
}

@end
@implementation UIView (Setting)

@end
