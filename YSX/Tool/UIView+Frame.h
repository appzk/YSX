//
//  UIView+Frame.h
//  Categories
//
//  Created by 刘永杰 on 15/12/14.
//  Copyright © 2015年 刘永杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic, readonly) CGFloat maxX;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic, readonly) CGFloat maxY;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat centerX;
@property (assign, nonatomic) CGFloat centerY;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGPoint origin;

/**
 .   获取当前视图所在的控制器
 */
@property (nonatomic, strong, readonly) UIViewController *viewController;

@end
