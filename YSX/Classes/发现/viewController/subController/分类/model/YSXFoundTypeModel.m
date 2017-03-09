//
//  YSXFoundTypeModel.m
//  YSX
//
//  Created by Lib on 2017/3/7.
//  Copyright © 2017年 adirects. All rights reserved.
//

#import "YSXFoundTypeModel.h"
#import "YSXFoundContentModel.h"

@implementation YSXFoundTypeModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
                @"female":[YSXFoundContentModel class],
                @"male":[YSXFoundContentModel class],
                @"press":[YSXFoundContentModel class]
             };
}

@end
