//
//  UITableViewCell+Background.m
//  YSX
//
//  Created by Lib on 2017/3/6.
//  Copyright © 2017年 adirects. All rights reserved.
//

#import "UITableViewCell+Background.h"

@implementation UITableViewCell (Background)

- (void)cancleWithSelectionBackground {
    self.backgroundView = [UIView new];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
