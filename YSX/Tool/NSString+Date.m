//
//  NSString+Date.m
//  YSX
//
//  Created by Lib on 2017/3/9.
//  Copyright © 2017年 adirects. All rights reserved.
//

#import "NSString+Date.h"

@implementation NSString (Date)
#pragma mark -  时间差
- (NSString *)dateTimeDifferenceWithFromDate:(NSDate *)formDate toDate:(NSDate *)toDate {
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    dateFomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
    
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 比较时间
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *time=[calendar components:unit fromDate:formDate toDate:toDate options:0];
    
    NSString *str;
    if (time.year >= 1) {
        str = [NSString stringWithFormat:@"%zi年前更新", time.year];
    }else if (time.month >= 1) {
        str = [NSString stringWithFormat:@"%zi月前更新", time.month];
    }else if (time.day >= 1) {
        str = [NSString stringWithFormat:@"%zi天前更新", time.day];
    }else if (time.hour >= 1) {
        str = [NSString stringWithFormat:@"%zi小时前更新", time
               .hour];
    }else if (time.minute >= 1) {
        str = [NSString stringWithFormat:@"%zi分钟前更新", time.minute];
    }else {
        str = [NSString stringWithFormat:@"%zi秒前更新", time.second];
    }
    return str;
}

#pragma mark -  字符串转NSDate
- (NSDate *)dateWithDateFormat:(NSString *)dateFormat {
    NSDateFormatter *date = [[NSDateFormatter alloc] init];
    date.dateFormat = dateFormat;
    return [date dateFromString:self];
}

#pragma mark -  替换字符
- (NSString *)replaceOfString:(NSArray *)targets withString:(NSArray *)replacements {
    NSString *str;
    for (NSUInteger idx = 0; idx < targets.count; idx ++) {
        if (idx == 0) {
            str = [self stringByReplacingOccurrencesOfString:targets[idx] withString:replacements[idx]];
        }else {
            str = [str stringByReplacingOccurrencesOfString:targets[idx] withString:replacements[idx]];
        }
    }
    return str;
}

@end
