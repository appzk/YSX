//
//  YSXBookshelfModel.m
//  YSX
//
//  Created by Lib on 2017/3/9.
//  Copyright © 2017年 adirects. All rights reserved.
//

#import "YSXBookshelfModel.h"

static NSString *kBookInfo = @"kBookInfo";

@interface YSXBookshelfModel ()
@property (nonatomic, strong) NSMutableArray *arr;
@end

@implementation YSXBookshelfModel {
    NSString *path;
}

#pragma mark - init
- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

#pragma mark - setup
- (void)setup {
    self.arr = [NSMutableArray array];
    path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    path = [path stringByAppendingPathComponent:@"bookshelf.data"];
}


- (void)addWithModel:(YSXDetailModel *)model {
    // 判断是否有归档文件
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        // 解档
        self.arr = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        [self.arr addObject:model];
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
    // 归档
    BOOL flag = [NSKeyedArchiver archiveRootObject:self.arr toFile:path];
    if (flag) {
        // 发送添加书籍通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"add" object:nil];
    }
}

- (void)removeWithModel:(YSXDetailModel *)model {
    // 判断是否有归档文件
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        // 解档
        self.arr = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        for (YSXDetailModel *m in self.arr) {
            if ([m.bookID isEqualToString:model.bookID]) {
                [self.arr removeObject:model];
            }
        }
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
    BOOL flag = [NSKeyedArchiver archiveRootObject:self.arr toFile:path];
    if (flag) {
        // 发送添加书籍通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"remove" object:nil];
    }
}

- (NSArray *)models {
    // 解档
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

- (BOOL)isBookID:(NSString *)bookID {
    // 解档
    self.arr = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    BOOL isExist = NO;
    for (NSUInteger idx = 0; idx < self.arr.count; idx ++) {
        YSXDetailModel *model = self.arr[idx];
        if ([model.bookID isEqualToString:bookID]) {
            isExist = YES;
        }else {
            isExist = NO;
        }
    }
    return isExist;
}

@end
