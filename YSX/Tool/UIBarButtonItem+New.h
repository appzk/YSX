//
//  UIBarButtonItem+New.h
//  YSX
//
//  Created by Lib on 2017/3/6.
//  Copyright © 2017年 adirects. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (New)

+ (instancetype)barButtonItemWithText:(NSString *)text;
+ (instancetype)barButtonItemWithImage:(NSString *)image;
+ (instancetype)barButtonItemWithImage:(NSString *)image heightImage:(NSString *)heightImage;
+ (instancetype)barButtonItemWithImage:(NSString *)image target:(id)target action:(SEL)action;
+ (instancetype)barButtonItemWithImage:(NSString *)image heightImage:(NSString *)heightImage target:(id)target action:(SEL)action;

@end
