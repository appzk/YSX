//
//  YSXCommunityCell.m
//  YSX
//
//  Created by Lib on 2017/3/7.
//  Copyright © 2017年 adirects. All rights reserved.
//

#import "YSXCommunity.h"
#import "YSXReviewController.h"
#import "YSXOriginalController.h"
#import "YSXHelpController.h"
#import "YSXRambleController.h"
#import "YSXGirlController.h"

static NSString *cell_id = @"cell_id";

@interface YSXCommunity ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *imgArr;
@end

@implementation YSXCommunity
#pragma mark -  lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.bounces = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cell_id];
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

#pragma mark -  setter
- (void)setVc:(UIViewController *)vc {
    _vc = vc;
    [self.tableView reloadData];
}

#pragma mark - setup
- (void)setup {
    self.titleArr = @[@"书评区", @"原创区", @"书荒互助区", @"综合讨论区", @"女生区"];
    self.imgArr = @[@"review_icon", @"original_icon", @"help_icon", @"ramble_icon", @"girl_icon"];
    [self.contentView addSubview:self.tableView];
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
}

#pragma mark -  <UITableViewDataSource>
-  (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    cell.textLabel.text = self.titleArr[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.imgArr[indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    cell.detailTextLabel.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    cell.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    [cell cancleWithSelectionBackground];
    return cell;
}

#pragma mark -  <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc;
    switch (indexPath.row) {
        case 0: {
            vc = [[YSXReviewController alloc] init];
        }
            break;
        case 1: {
            vc = [[YSXOriginalController alloc] init];
        }
            break;
        case 2: {
            vc = [[YSXHelpController alloc] init];
        }
            break;
        case 3: {
            vc = [[YSXRambleController alloc] init];
        }
            break;
        case 4: {
            vc = [[YSXGirlController alloc] init];
        }
            break;
    }
    [self.vc.navigationController pushViewController:vc animated:YES];
}

@end
