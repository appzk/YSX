//
//  YSXReadController.m
//  YSX
//
//  Created by Lib on 2017/3/21.
//  Copyright © 2017年 adirects. All rights reserved.
//

#import "YSXReadController.h"

@interface YSXReadController ()
@property (nonatomic, copy) NSString *bookTitle;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) NSDictionary *attributes;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *textLab;
@end

@implementation YSXReadController

- (instancetype)initWithTitle:(NSString *)title text:(NSString *)text attributes:(NSDictionary<NSString *,id> *)attributes {
    if (self = [super init]) {
        self.bookTitle = title;
        self.text = text;
        self.attributes = attributes;
    }
    return self;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        _titleLab.attributedText = [[NSAttributedString alloc] initWithString:self.bookTitle attributes:@{
                                                                                                          NSFontAttributeName: [UIFont boldSystemFontOfSize:17],
                                                                                                          NSForegroundColorAttributeName:[UIColor blackColor]
                                                                                                          }];
    }
    return _titleLab;
}

- (UILabel *)textLab {
    if (!_textLab) {
        _textLab = [[UILabel alloc] initWithFrame:CGRectMake(0, self.titleLab.maxY, SCREEN_WIDTH, SCREEN_HEIGHT - self.titleLab.maxY)];
        _textLab.attributedText = [[NSAttributedString alloc] initWithString:self.text attributes:self.attributes];
    }
    return _textLab;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.titleLab];
    [self.view addSubview:self.textLab];
}

@end
