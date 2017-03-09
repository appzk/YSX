//
//  YSXDetailScrollView.m
//  YSX
//
//  Created by Lib on 2017/3/8.
//  Copyright © 2017年 adirects. All rights reserved.
//

#import "YSXDetailView.h"

@interface YSXDetailView ()

@property (weak, nonatomic) IBOutlet UIImageView *bookImg;  // 图片
@property (weak, nonatomic) IBOutlet UILabel *bookName; // 书名
@property (weak, nonatomic) IBOutlet UILabel *bookAuthor;   // 作者
@property (weak, nonatomic) IBOutlet UILabel *bookType; // 类型
@property (weak, nonatomic) IBOutlet UILabel *bookCount;    // 字数
@property (weak, nonatomic) IBOutlet UILabel *lastData; // 最后更新时间

@property (weak, nonatomic) IBOutlet UILabel *readCount;    // 人数
@property (weak, nonatomic) IBOutlet UILabel *retentionRate;    // 留存率
@property (weak, nonatomic) IBOutlet UILabel *updataCount;  // 更新字数

@property (weak, nonatomic) IBOutlet UILabel *bookDetail;   // 介绍

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *readCount_prompt;
@property (weak, nonatomic) IBOutlet UILabel *retentionRate_prompt;
@property (weak, nonatomic) IBOutlet UILabel *updateCount_prompt;

@property (weak, nonatomic) IBOutlet UIButton *addBook;
@property (weak, nonatomic) IBOutlet UIButton *startRead;


@end

@implementation YSXDetailView

#pragma mark - init
- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

#pragma mark - setup
- (void)setup {

}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    self.bookName.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.bookAuthor.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.bookType.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.bookDetail.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.readCount.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.retentionRate.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.lastData.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.updataCount.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.bookCount.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    
    self.bgView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    self.readCount_prompt.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.retentionRate_prompt.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.updateCount_prompt.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.addBook.dk_tintColorPicker = DKColorPickerWithKey(TINT);
    self.startRead.dk_tintColorPicker = DKColorPickerWithKey(TINT);
    
}

#pragma mark -  setter
- (void)setModel:(YSXDetailModel *)model {
    _model = model;
    
    NSString *imgURL = [model.cover substringFromIndex:7];
    [self.bookImg sd_setImageWithURL:[NSURL URLWithString:imgURL]];
    self.bookName.text = model.title;
    self.bookType.text = model.minorCate;
    
    NSInteger count = [model.wordCount integerValue] / 10000;
    if (count < 0) {
        self.bookCount.text = [NSString stringWithFormat:@"%zi万字", count];
    }else {
        self.bookCount.text = model.wordCount;
    }
    
    self.readCount.text = [NSString stringWithFormat:@"%@人", model.latelyFollower];
    self.retentionRate.text = [NSString stringWithFormat:@"%@%%", model.retentionRatio];
    if ([model.serializeWordCount integerValue] < 0) {
        self.updataCount.text = @"暂无法统计";
    }else {
        self.updataCount.text = model.serializeWordCount;
    }
    
    self.bookDetail.text = model.longIntro;
    self.bookAuthor.text = model.author;
    
    NSString *update = [model.updated replaceOfString:@[@"T",@"Z"] withString:@[@" ",@""]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
    update = [NSString dateTimeDifferenceWithFromDate:[formatter dateFromString:update] toDate:[NSDate date]];
    self.lastData.text = update;

}

#pragma mark -  btn click
- (IBAction)addToBookshelf:(UIButton *)sender {
   
}

- (IBAction)startRead:(id)sender {
    
}


@end
