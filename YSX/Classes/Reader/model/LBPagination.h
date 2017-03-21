//
//  Paging.h
//  分页
//
//  Created by Lib on 2017/3/15.
//  Copyright © 2017年 adirects. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBPagination : NSObject

/** 文字属性    注: 显示文字的控件的文字属性必须与分页的布局属性一样 */
@property (nonatomic, strong, readonly) NSDictionary *attributes;
/** 页数  */
@property (nonatomic, assign, readonly) NSInteger pageCount;
/** 每页的文字   */
@property (nonatomic, strong, readonly) NSArray *pageTexts;

/**
 *  init
 *
 *  @parma  text    要分页的文字
 *  @parma  size     固定的位置
 */
- (instancetype)initWithText:(NSString *)text size:(CGSize)size;

/**
 *  更新字体
 *
 *  @parma  font            字体          默认: 黑体-15  注: 为nil时, 为默认字体  字号最大30pt、最小10pt
 *  @parma  lineSpacing   行间距      默认:  5           注:  为nil时,为默认间距   间距最大10
 */
- (void)updateWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing;

@end
