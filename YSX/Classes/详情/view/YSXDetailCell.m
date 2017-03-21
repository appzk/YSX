//
//  YSXDetailCell.m
//  YSX
//
//  Created by Lib on 2017/3/20.
//  Copyright © 2017年 adirects. All rights reserved.
//

#import "YSXDetailCell.h"
#import "YSXBookshelfModel.h"

@interface YSXDetailCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bookIcon;
@property (weak, nonatomic) IBOutlet UILabel *bookName;
@property (weak, nonatomic) IBOutlet UILabel *bookAuthor;
@property (weak, nonatomic) IBOutlet UILabel *bookType;
@property (weak, nonatomic) IBOutlet UILabel *bookCount;
@property (weak, nonatomic) IBOutlet UILabel *lastUpdate;

@property (weak, nonatomic) IBOutlet UIButton *update;
@property (weak, nonatomic) IBOutlet UIButton *startRead;

@property (weak, nonatomic) IBOutlet UILabel *readCount_p;
@property (weak, nonatomic) IBOutlet UILabel *retentionRate_p;
@property (weak, nonatomic) IBOutlet UILabel *updateCount_p;

@property (weak, nonatomic) IBOutlet UILabel *readCount;
@property (weak, nonatomic) IBOutlet UILabel *retentionRate;
@property (weak, nonatomic) IBOutlet UILabel *updateCount;

@property (weak, nonatomic) IBOutlet UILabel *detail;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom;

@end

@implementation YSXDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    self.bookName.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.bookAuthor.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.bookType.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.bookCount.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.lastUpdate.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.detail.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.readCount.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.retentionRate.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.updateCount.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    
    self.readCount_p.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.retentionRate_p.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.updateCount_p.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    
//    [self setupButton];
    
    [self cancleSelectedStyle];
}

- (void)setModel:(YSXDetailModel *)model {
    _model = model;
    
    [self setupButton];
    
    NSString *imgURL = [NSString stringWithFormat:@"http://statics.zhuishushenqi.com%@", model.cover];
    [self.bookIcon sd_setImageWithURL:[NSURL URLWithString:imgURL]];
    self.bookName.text = model.title;
    self.bookAuthor.text = model.author;
    self.bookType.text = model.minorCate;
    ;
    NSString *count = [NSString stringWithFormat:@"%zi万字", [model.wordCount integerValue] / 10000];
    self.bookCount.text = count;
    
    NSString *date = [model.updated replaceOfString:@[@"T", @"Z"] withString:@[@" ", @""]];
    
    date = [date dateTimeDifferenceWithFromDate:[date dateWithDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"] toDate:[NSDate date]];
    self.lastUpdate.text = [NSString stringWithFormat:@"%@", date];
    
    self.readCount.text = [NSString stringWithFormat:@"%@人", model.latelyFollower];
    self.retentionRate.text = [NSString stringWithFormat:@"%@%%", model.retentionRatio];
    if ([model.serializeWordCount integerValue] < 0) {
        self.updateCount.text = @"暂无法统计";
    }else {
        self.updateCount.text = [NSString stringWithFormat:@"%@字", model.serializeWordCount];
    }
    
    self.detail.text = model.longIntro;
    
    self.height = self.bottom.constant + self.detail.maxY;
    [self setNeedsLayout];
}

#pragma mark -  添加/删除书
- (IBAction)addBook:(UIButton *)sender {
    YSXBookshelfModel *bookShelf = [[YSXBookshelfModel alloc] init];
    sender.selected = !sender.selected;
    if (sender.selected) {
        [bookShelf addWithModel:self.model];
//        sender.backgroundColor = RGBA_COLOR(0, 0, 0, .15);
    }else {
        [bookShelf removeWithModel:self.model];
    }
    bookShelf = nil;
}

#pragma mark -  开始阅读
- (IBAction)startRead:(id)sender {
    
}

- (void)setupButton {
    // 设置按钮
    YSXBookshelfModel *bookshelfModel = [[YSXBookshelfModel alloc] init];
    BOOL flag = [bookshelfModel isBookID:self.model.bookID];
    if (!self.model) return;
    if (flag) {
        self.update.selected = YES;
    }else {
        self.update.selected = NO;
    }
    bookshelfModel = nil;
}

@end
