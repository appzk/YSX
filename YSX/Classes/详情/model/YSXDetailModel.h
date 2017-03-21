//
//  YSXDetailModel.h
//  YSX
//
//  Created by Lib on 2017/3/8.
//  Copyright © 2017年 adirects. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSXDetailModel : NSObject<NSCoding>
@property (nonatomic, copy) NSString *bookID;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *minorCate;  // 类型
@property (nonatomic, copy) NSString *cat;
@property (nonatomic, copy) NSString *cover;    //  图片
@property (nonatomic, copy) NSString *latelyFollower;   // 人数
@property (nonatomic, copy) NSString *retentionRatio;   // 留存率
@property (nonatomic, copy) NSString *serializeWordCount;   // 更新字数
@property (nonatomic, copy) NSString *longIntro;    // 介绍
@property (nonatomic, copy) NSString *title;    // 书名
@property (nonatomic, copy) NSString *updated;  // 更新时间
@property (nonatomic, copy) NSString *wordCount;    // 字数
@property (nonatomic, copy) NSString *lastChapter;  // 最新章节
@end
