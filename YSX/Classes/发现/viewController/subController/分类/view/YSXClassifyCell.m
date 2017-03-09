//
//  YSXClassifyCell.m
//  YSX
//
//  Created by Lib on 2017/3/7.
//  Copyright © 2017年 adirects. All rights reserved.
//

#import "YSXClassifyCell.h"

@implementation YSXClassifyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
        self.textLabel.dk_textColorPicker = DKColorPickerWithKey(TEXT);
        self.detailTextLabel.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    }
    return self;
}

- (void)setModel:(YSXFoundContentModel *)model {
    _model = model;
    self.textLabel.text = model.name;
    self.detailTextLabel.text = [NSString stringWithFormat:@"%@本", model.bookCount];
}

@end
