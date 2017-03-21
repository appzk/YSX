//
//  YSXDetailModel.m
//  YSX
//
//  Created by Lib on 2017/3/8.
//  Copyright © 2017年 adirects. All rights reserved.
//

#import "YSXDetailModel.h"

static NSString *kBookID = @"kBookID";
static NSString *kAuthor = @"kAuthor";
static NSString *kMinorCate = @"kMinorCate";
static NSString *kCover = @"kCover";
static NSString *kLatelyFollower = @"kLatelyFollower";
static NSString *kRetentionRatio = @"kRetentionRatio";
static NSString *kSerializeWordCount = @"kSerializeWordCount";
static NSString *kLongIntro = @"kLongIntro";
static NSString *kTitle = @"kTitle";
static NSString *kUpdated = @"kUpdated";
static NSString *kWordCount = @"kWordCount";
static NSString *kLastChapter = @"kLastChapter";

@implementation YSXDetailModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"bookID":@"_id"};
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.bookID = [aDecoder decodeObjectForKey:kBookID];
        self.author = [aDecoder decodeObjectForKey:kAuthor];
        self.minorCate = [aDecoder decodeObjectForKey:kMinorCate];
        self.cover = [aDecoder decodeObjectForKey:kCover];
        self.latelyFollower = [aDecoder decodeObjectForKey:kLatelyFollower];
        self.retentionRatio = [aDecoder decodeObjectForKey:kRetentionRatio];
        self.serializeWordCount = [aDecoder decodeObjectForKey:kSerializeWordCount];
        self.longIntro = [aDecoder decodeObjectForKey:kLongIntro];
        self.title = [aDecoder decodeObjectForKey:kTitle];
        self.updated = [aDecoder decodeObjectForKey:kUpdated];
        self.wordCount = [aDecoder decodeObjectForKey:kWordCount];
        self.lastChapter = [aDecoder decodeObjectForKey:kLastChapter];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.bookID forKey:kBookID];
    [aCoder encodeObject:self.author forKey:kAuthor];
    [aCoder encodeObject:self.minorCate forKey:kMinorCate];
    [aCoder encodeObject:self.cover forKey:kCover];
    [aCoder encodeObject:self.latelyFollower forKey:kLatelyFollower];
    [aCoder encodeObject:self.retentionRatio forKey:kRetentionRatio];
    [aCoder encodeObject:self.serializeWordCount forKey:kSerializeWordCount];
    [aCoder encodeObject:self.longIntro forKey:kLongIntro];
    [aCoder encodeObject:self.title forKey:kTitle];
    [aCoder encodeObject:self.updated forKey:kUpdated];
    [aCoder encodeObject:self.wordCount forKey:kWordCount];
    [aCoder encodeObject:self.lastChapter forKey:kLastChapter];
}

@end
