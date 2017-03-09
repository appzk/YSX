//
//  YSXShowModel.h
//  YSX
//
//  Created by Lib on 2017/3/8.
//  Copyright © 2017年 adirects. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSXShowModel : NSObject
@property (nonatomic, copy) NSString *bookID;      // 书号
@property (nonatomic, copy) NSString *title;    // 书名
@property (nonatomic, copy) NSString *author;   // 作者
@property (nonatomic, copy) NSString *cover;    // 图片
@property (nonatomic, copy) NSString *latelyFollower;   // 阅读人数
@property (nonatomic, copy) NSString *majorCate;    // 类型
@property (nonatomic, copy) NSString *retentionRatio;   // 留存率
@property (nonatomic, copy) NSString *shortIntro;   // 介绍
@end
