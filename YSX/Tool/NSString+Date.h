//
//  NSString+Date.h
//  YSX
//
//  Created by Lib on 2017/3/9.
//  Copyright © 2017年 adirects. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Date)
/**
 *  时间差
 *
 *  @parma  formDate   开始时间
 *  @parma  toDate       结束时间
 *  return   时间差
 */
- (NSString *)dateTimeDifferenceWithFromDate:(NSDate *)formDate toDate:(NSDate *)toDate;

/**
 *  字符串转NSDate
 *
 *  @parma  string               字符串
 *  @parma  dateFormat       格式
 *  return   NSDate
 */
- (NSDate *)dateWithDateFormat:(NSString *)dateFormat;

/**
 *  字符串替换
 *
 *  @parma  targets  被替换的字符
 *  @parma  replacements 替换成的字符
 *  return  替换好的字符串
 */
- (NSString *)replaceOfString:(NSArray *)targets withString:(NSArray *)replacements;
@end
