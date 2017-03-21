//
//  Paging.m
//  分页
//
//  Created by Lib on 2017/3/15.
//  Copyright © 2017年 adirects. All rights reserved.
//

#import "LBPagination.h"
#import "Macro.h"

#define kAttributes @"kAttributes"

@interface LBPagination ()
@property (nonatomic, copy) NSString *textStr;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, strong) NSMutableDictionary *att;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *textArr;
@property (nonatomic, strong) NSMutableParagraphStyle *paragraphStyle;
@property (nonatomic, strong) UIFont *curFont;
@end

@implementation LBPagination

#pragma mark -  getter
- (NSDictionary *)attributes {
    return self.att;
}

- (NSInteger)pageCount {
    return self.page;
}

- (NSArray *)pageTexts {
    return self.textArr;
}

#pragma mark -  init
- (instancetype)initWithText:(NSString *)text size:(CGSize)size {
    if (self = [super init]) {
        self.textStr = text;
        self.size = size;
        [self setup];
    }
    return self;
}

#pragma mark -  set up
- (void)setup {
    self.paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    self.att = [NSMutableDictionary dictionary];
    
    // 解档
    NSString *multiHomePath = [NSHomeDirectory() stringByAppendingPathComponent:@"multi.archiver"];
    NSMutableData *data = [NSMutableData dataWithContentsOfFile:multiHomePath];
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    if ([unArchiver decodeObjectForKey:kAttributes]) {
        _att = [unArchiver decodeObjectForKey:kAttributes];
        NSLog(@"存在  curFont:%@", _att[NSFontAttributeName]);
    }else {
        self.curFont = [UIFont fontWithName:@"Heiti TC" size:15];
        _paragraphStyle.lineSpacing = 5; //行距
        [_att setObject:_paragraphStyle forKey:NSParagraphStyleAttributeName];
        [_att setObject:_curFont forKey:NSFontAttributeName];
        NSLog(@"不存在 curFont:%@", _att);
    }
    
    self.textArr = [NSMutableArray array];
    [self paging];
}

#pragma mark -  paging
- (void)paging {
    NSTextStorage *storage = [[NSTextStorage alloc] initWithString:self.textStr attributes:self.att];
    NSLayoutManager *manager = [[NSLayoutManager alloc] init];
    [storage addLayoutManager:manager];
    NSTextContainer *container = [[NSTextContainer alloc] initWithSize:CGSizeMake(self.size.width, CGFLOAT_MAX)];
    [manager addTextContainer:container];
    CGRect totalRect = [manager boundingRectForGlyphRange:NSMakeRange(0, _textStr.length) inTextContainer:container];
    // 向上取整
    CGFloat totalH = ceilf(totalRect.size.height);
    
    [manager removeTextContainerAtIndex:0];
    container = nil;
    container = [[NSTextContainer alloc] initWithSize:_size];
    [manager addTextContainer:container];
    CGRect pageRect = [manager boundingRectForGlyphRange:NSMakeRange(0, _textStr.length) inTextContainer:container];
    // 向下取整
    CGFloat pageH = floorf(pageRect.size.height);
    // 页数
    self.page = totalH / pageH + 1;
    [manager removeTextContainerAtIndex:0];
    container = nil;
    
    int i=0;
    [self.textArr removeAllObjects];
    while (i<_page) {
        NSTextContainer *container = [[NSTextContainer alloc] initWithSize:_size];
        
        [manager addTextContainer:container];
        
        i++;
        //这里还有一个方法用于保存分页结果
        NSRange range = [manager glyphRangeForTextContainer:container];
        
        [self.textArr addObject:[_textStr substringWithRange:range]];
        container = nil;
    }
    storage = nil;
    manager = nil;
}

#pragma mark -  update  
- (void)updateWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing {
    if (font) {
        _curFont = font;
    }
    if (_curFont.pointSize < 10 || _curFont.pointSize > 30) return;
    if (lineSpacing <0 || lineSpacing > 30) return;
    if (!font) {
        if (!lineSpacing) return;
        _paragraphStyle.lineSpacing = lineSpacing;
        [_att setObject:_paragraphStyle forKey:NSParagraphStyleAttributeName];
    }else {
        if (!lineSpacing) return;
        [_att setObject:font forKey:NSFontAttributeName];
        _paragraphStyle.lineSpacing = lineSpacing;
        [_att setObject:_paragraphStyle forKey:NSParagraphStyleAttributeName];
    }
    [self paging];
    [self save];
}

#pragma mark -  save
- (void)save {
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self.att forKey:kAttributes];
    [archiver finishEncoding];
    NSString *multiHomePath = [NSHomeDirectory() stringByAppendingPathComponent:@"multi.archiver"];
    [data writeToFile:multiHomePath atomically:YES];
}

@end
