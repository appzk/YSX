//
//  YSXDetailReviewCell.m
//  YSX
//
//  Created by Lib on 2017/3/20.
//  Copyright © 2017年 adirects. All rights reserved.
//

#import "YSXDetailReviewCell.h"

@interface YSXDetailReviewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom;

@end

@implementation YSXDetailReviewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setModel:(YSXDetailModel *)model {
    _model = model;
    
    self.height = self.bottom.constant + self.content.maxY;
    [self setNeedsLayout];
}

@end
