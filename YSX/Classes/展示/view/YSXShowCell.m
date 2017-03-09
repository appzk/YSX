//
//  YSXShowCell.m
//  YSX
//
//  Created by Lib on 2017/3/7.
//  Copyright © 2017年 adirects. All rights reserved.
//

#import "YSXShowCell.h"

@interface YSXShowCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bookImg;
@property (weak, nonatomic) IBOutlet UILabel *bookName;
@property (weak, nonatomic) IBOutlet UILabel *bookAuthor;
@property (weak, nonatomic) IBOutlet UILabel *bookType;
@property (weak, nonatomic) IBOutlet UILabel *bookDetail;
@property (weak, nonatomic) IBOutlet UILabel *readCount;
@property (weak, nonatomic) IBOutlet UILabel *retentionRate;
@end

@implementation YSXShowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    self.bookName.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.bookAuthor.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.bookType.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.bookDetail.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.readCount.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.retentionRate.dk_textColorPicker = DKColorPickerWithKey(TEXT);
}

- (void)setModel:(YSXShowModel *)model {
    _model = model;
    NSString *imgURL = [model.cover substringFromIndex:7];
    [self.bookImg sd_setImageWithURL:[NSURL URLWithString:imgURL]];
    self.bookName.text = model.title;
    self.bookAuthor.text = model.author;
    self.bookType.text = model.majorCate;
    self.bookDetail.text = model.shortIntro;
    self.readCount.text = [NSString stringWithFormat:@"%@人在追", model.latelyFollower];
    self.retentionRate.text = [NSString stringWithFormat:@"%@%%留存率", model.retentionRatio];
}

@end
