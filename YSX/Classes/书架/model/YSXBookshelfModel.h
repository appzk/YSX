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

/**
 .   添加书籍模型
 */
- (void)addWithModel:(YSXDetailModel *)model;
/**
 .   移除书籍模型
 */
- (void)removeWithModel:(YSXDetailModel *)model;
/**
 .   书架的所有书籍模型
 */
- (NSArray *)models;
/**
 .   判断书架中是否存在某书籍
 */
- (BOOL)isBookID:(NSString *)bookID;
@end
