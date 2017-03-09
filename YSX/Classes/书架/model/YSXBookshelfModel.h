//
//  YSXBookshelfModel.h
//  YSX
//
//  Created by Lib on 2017/3/9.
//  Copyright © 2017年 adirects. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YSXDetailModel.h"

@interface YSXBookshelfModel : NSObject

- (void)addWithModel:(YSXDetailModel *)model;;
- (void)removeWithModel:(YSXDetailModel *)model;

/**
 *  存储数据的key
 */
- (NSString *)bookInfoKey;

@end
