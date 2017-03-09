//
//  YSXBookshelfCell.m
//  YSX
//
//  Created by Lib on 2017/3/9.
//  Copyright © 2017年 adirects. All rights reserved.
//

#import "YSXBookshelfCell.h"

@interface YSXBookshelfCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bookImg;
@property (weak, nonatomic) IBOutlet UILabel *bookName;
@property (weak, nonatomic) IBOutlet UILabel *update;
@property (weak, nonatomic) IBOutlet UILabel *lastChapter;

@end

@implementation YSXBookshelfCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setModel:(YSXDetailModel *)model {
    _model = model;
    
    NSString *imgURL = [model.cover substringFromIndex:7];
    [self.bookImg sd_setImageWithURL:[NSURL URLWithString:imgURL]];
    self.bookName.text = model.title;
    NSString *update = [model.updated replaceOfString:@[@"T",@"Z"] withString:@[@" ",@""]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
    update = [NSString dateTimeDifferenceWithFromDate:[formatter dateFromString:update] toDate:[NSDate date]];
    self.update.text = update;
    self.lastChapter.text = model.lastChapter;
}

@end
