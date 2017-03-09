//
//  UIBarButtonItem+New.m
//  YSX
//
//  Created by Lib on 2017/3/6.
//  Copyright © 2017年 adirects. All rights reserved.
//

#import "UIBarButtonItem+New.h"

@implementation UIBarButtonItem (New)

+ (instancetype)barButtonItemWithText:(NSString *)text {
    return [[[UIBarButtonItem alloc] init] setupWithText:text image:@"" heightImage:@"" target:nil action:nil];
}

+ (instancetype)barButtonItemWithImage:(NSString *)image {
    return [[[UIBarButtonItem alloc] init] setupWithText:@"" image:image heightImage:@"" target:nil action:nil];
}

+ (instancetype)barButtonItemWithImage:(NSString *)image heightImage:(NSString *)heightImage {
    return [[[UIBarButtonItem alloc] init] setupWithText:@"" image:image heightImage:heightImage target:nil action:nil];
}

+ (instancetype)barButtonItemWithImage:(NSString *)image target:(id)target action:(SEL)action {
    return [[[UIBarButtonItem alloc] init] setupWithText:@"" image:image heightImage:@"" target:target action:action];
}

+ (instancetype)barButtonItemWithImage:(NSString *)image heightImage:(NSString *)heightImage target:(id)target action:(SEL)action {
    return [[[UIBarButtonItem alloc] init] setupWithText:@"" image:image heightImage:heightImage target:target action:action];
}

- (instancetype)setupWithText:(NSString *)text image:(NSString *)image heightImage:(NSString *)heightImage target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *img = [UIImage imageNamed:image];
    UIImage *hImg = [UIImage imageNamed:heightImage];
    btn.frame = CGRectMake(0, 0, img.size.width + 20, img.size.height);
    
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setImage:img forState:UIControlStateNormal];
    [btn setImage:hImg forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //  禁止点击
    if (!target) {
        [btn setUserInteractionEnabled:NO];
    }
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
