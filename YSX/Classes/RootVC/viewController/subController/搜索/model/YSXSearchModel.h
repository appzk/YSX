//
//  YSXSearchModel.h
//  YSX
//
//  Created by Lib on 2017/3/21.
//  Copyright © 2017年 adirects. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSXSearchModel : NSObject

@property (nonatomic, copy) NSString *bookID;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *cat;
@property (nonatomic, copy) NSString *cover;

@property (nonatomic, copy) NSString *latelyFollower;
@property (nonatomic, copy) NSString *retentionRatio;
@property (nonatomic, copy) NSString *shortIntro;

@property (nonatomic, copy) NSString *title;

@end
