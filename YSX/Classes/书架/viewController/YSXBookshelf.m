//
//  YSXBookshelfCell.m
//  YSX
//
//  Created by Lib on 2017/3/7.
//  Copyright © 2017年 adirects. All rights reserved.
//

#import "YSXBookshelf.h"
#import "YSXBookshelfCell.h"
#import "YSXBookshelfModel.h"
#import "YSXReadPageController.h"

static NSString *cell_id = @"cell_id";
static NSString *last_cell_id = @"last_cell_id";

@interface YSXBookshelf ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *bookArr;
@property (nonatomic, strong) YSXBookshelfModel *model;
@end

@implementation YSXBookshelf

#pragma mark -  lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height - 64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"YSXBookshelfCell" bundle:nil] forCellReuseIdentifier:cell_id];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:last_cell_id];
    }
    return _tableView;
}

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
    [self.contentView addSubview:self.tableView];
    
    self.height = self.tableView.maxY;
    [self setNeedsLayout];
    
    self.bookArr = [NSMutableArray array];
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    self.model = [[YSXBookshelfModel alloc] init];
    
    // 注册通知接收添加/删除书籍通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBook) name:@"add" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBook) name:@"remove" object:nil];
}

- (void)updateBook {
    [self.tableView reloadData];
    NSLog(@"刷新");
}

#pragma mark -  <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.model models].count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row > [self.model models].count) {
//        UITableViewCell *cell = [[UITableViewCell alloc] init];
//        cell.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
//        [cell cancleSelectedStyle];
//        return cell;
//    }
    if (indexPath.row == [self.model models].count) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:last_cell_id];
        cell.textLabel.text = @"添加你喜欢的书籍";
        cell.textLabel.dk_textColorPicker = DKColorPickerWithKey(TEXT);
        cell.detailTextLabel.dk_textColorPicker = DKColorPickerWithKey(TEXT);
        cell.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
        cell.imageView.image = [UIImage imageNamed:@"add"];
        [cell cancleSelectedStyle];
        return cell;
    }else {
        YSXBookshelfCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
        cell.model = [self.model models][indexPath.row];
        return cell;
    }
}

#pragma mark -  <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [self.model models].count) {
        // 发送添加书籍的通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"add_book" object:nil];
    }
    [self.viewController presentViewController:[[YSXReadPageController alloc] init] animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [self.model models].count) {
        return 75;
    }else {
        return 125;
    }
}

@end
