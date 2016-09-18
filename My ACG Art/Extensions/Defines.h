//
//  Defines.h
//  My ACG Art
//
//  Created by 李 安君 on 16/9/7.
//  Copyright © 2016年 李 安君. All rights reserved.
//

#ifndef Defines_h
#define Defines_h
/** 拓展类头文件 **/
#import "UILabel+Setting.h"
#import "UIView+Setting.h"

/** 屏幕,长度相关宏定义 **/
#define kScreenBounds [UIScreen mainScreen].bounds
#define kScreenWidth kScreenBounds.size.width
#define kScreenHeight kScreenBounds.size.height
#define kOnePixel (1./[UIScreen mainScreen].scale)

/** 快捷对象 **/
#define AJImage(str) [UIImage imageNamed:@#str]
#define AJURL(str) [NSURL URLWithString:str]
#define AJFont(size) [UIFont systemFontOfSize:size]
#define AJStr(x,...) [NSString stringWithFormat:@#x, ## __VA_ARGS__]

/** 颜色定义 */
#define RGBAColor(r,g,b,a) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:a]
#define RGBColor(r,g,b) RGBAColor(r,g,b,1)

#define kBlackColor [UIColor blackColor]
#define kWhiteColor [UIColor whiteColor]
#define kGrayColor [UIColor grayColor]
#define kLightGrayColor [UIColor lightGrayColor]
#define kOrangeColor [UIColor orangeColor]
#define kThemeColor RGBColor(240,98,146)

#endif /* Defines_h */
