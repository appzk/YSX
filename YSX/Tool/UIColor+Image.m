//
//  UIColor+Image.m
//  YSX
//
//  Created by Lib on 2017/3/6.
//  Copyright © 2017年 adirects. All rights reserved.
//

#import "UIColor+Image.h"

@implementation UIColor (Image)

+ (UIImage *)color:(UIColor *)color {
    CGRect rect=CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage*theImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
