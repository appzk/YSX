//
//  YSXSearchCell.m
//  YSX
//
//  Created by Lib on 2017/3/21.
//  Copyright © 2017年 adirects. All rights reserved.
//

#import "YSXSearchCell.h"

@interface YSXSearchCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bookIcon;
@property (weak, nonatomic) IBOutlet UILabel *bookName;
@property (weak, nonatomic) IBOutlet UILabel *bookAuthor;
@property (weak, nonatomic) IBOutlet UILabel *bookType;
@property (weak, nonatomic) IBOutlet UILabel *bookDetail;
@property (weak, nonatomic) IBOutlet UILabel *readCount;
@property (weak, nonatomic) IBOutlet UILabel *retentionRate;

@end

@implementation YSXSearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    self.bookName.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.bookAuthor.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.bookType.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.bookDetail.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.readCount.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.retentionRate.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    
    [self cancleSelectedStyle];
}

- (void)setModel:(YSXSearchModel *)model {
    
    _model = model;
    
    NSString *url = [NSString stringWithFormat:@"http://statics.zhuishushenqi.com%@", model.cover];
    [self.bookIcon sd_setImageWithURL:[NSURL URLWithString:url]];
    
    self.bookName.text = model.title;
    self.bookAuthor.text = model.author;
    self.bookType.text = model.cat;
    self.bookDetail.text = model.shortIntro;
    
    self.readCount.text = [NSString stringWithFormat:@"%@人在追", model.latelyFollower];
    self.retentionRate.text = [NSString stringWithFormat:@"%@%%读者留存", model.retentionRatio];
    
    self.height = self.readCount.maxY;
    [self setNeedsLayout];
}

@end
