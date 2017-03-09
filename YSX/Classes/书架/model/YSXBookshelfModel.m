//
//  YSXBookshelfModel.m
//  YSX
//
//  Created by Lib on 2017/3/9.
//  Copyright © 2017年 adirects. All rights reserved.
//

#import "YSXBookshelfModel.h"

@interface YSXBookshelfModel ()
@property (nonatomic, strong) NSMutableArray *arr;
@end

@implementation YSXBookshelfModel {
    NSUserDefaults *user;
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
    user = [NSUserDefaults standardUserDefaults];
}


- (void)addWithModel:(YSXDetailModel *)model {
    [self.arr addObject:model];
    [user setObject:self.arr forKey:@"book_info"];
}

- (void)removeWithModel:(YSXDetailModel *)model {
    [self.arr removeObject:model];
    [user synchronize];
}

- (NSString *)bookInfo {
    return @"book_info";
}

@end
