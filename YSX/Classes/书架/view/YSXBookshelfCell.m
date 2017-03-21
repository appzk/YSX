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
    
    [self cancleSelectedStyle];
}

- (void)setModel:(YSXDetailModel *)model {
    _model = model;
    
    NSString *imgURL = [model.cover substringFromIndex:7];
    [self.bookImg sd_setImageWithURL:[NSURL URLWithString:imgURL]];
    self.bookName.text = model.title;
    NSString *update = [model.updated replaceOfString:@[@"T",@"Z"] withString:@[@" ",@""]];
    update = [update dateTimeDifferenceWithFromDate:[update dateWithDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"] toDate:[NSDate date]];
    self.update.text = update;
    self.lastChapter.text = model.lastChapter;
}

@end
