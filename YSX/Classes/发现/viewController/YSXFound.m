//
//  YSXFoundCell.m
//  YSX
//
//  Created by Lib on 2017/3/7.
//  Copyright © 2017年 adirects. All rights reserved.
//

#import "YSXFound.h"
#import "YSXClassifyController.h"
#import "YSXRankingController.h"

static NSString *cell_id = @"cell_id";

@interface YSXFound ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *imgArr;
@end

@implementation YSXFound

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

#pragma mark -  setter
- (void)setVc:(UIViewController *)vc {
    _vc = vc;
    [self.tableView reloadData];
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

#pragma mark -  setup
- (void)setup {
    [self.contentView addSubview:self.tableView];
    
    self.titleArr = @[@"分类", @"排行榜"];
    self.imgArr = @[@"found_classify", @"found_ranking"];
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
}

#pragma mark -  <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    cell.textLabel.text = self.titleArr[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.imgArr[indexPath.row]];
    [cell cancleWithSelectionBackground];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    cell.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    cell.detailTextLabel.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    return cell;
}

#pragma mark -  <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc;
    switch (indexPath.row) {
        case 0: {
            YSXClassifyController *classifyVC = [[YSXClassifyController alloc] init];
            vc = classifyVC;
        }
            break;
        default: {
            YSXRankingController *rankingVC = [[YSXRankingController alloc] init];
            vc = rankingVC;
        }
            break;
    }
    [self.vc.navigationController pushViewController:vc animated:YES];
}

@end
