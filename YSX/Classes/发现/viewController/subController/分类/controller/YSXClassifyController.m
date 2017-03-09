//
//  YSXClassifyController.m
//  YSX
//
//  Created by Lib on 2017/3/6.
//  Copyright © 2017年 adirects. All rights reserved.
//

#import "YSXClassifyController.h"
#import "YSXFoundTypeModel.h"
#import "YSXFoundContentModel.h"
#import "YSXClassifyCell.h"
#import "YSXShowController.h"

static NSString *cell_id = @"cell_id";

@interface YSXClassifyController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSMutableArray *arr;
@end

@implementation YSXClassifyController

#pragma mark -  lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[YSXClassifyCell class] forCellReuseIdentifier:cell_id];

    }
    return _tableView;
}

#pragma mark -  life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arr = [NSMutableArray array];
    [self setup];
    [self requestData];
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
}

#pragma mark -  set up
- (void)setup {
    self.title = @"分类";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
}

#pragma mark -  request data
- (void)requestData {
    self.manager = [AFHTTPSessionManager manager];
    [_manager GET:@"http://api.zhuishushenqi.com/cats/lv2/statistics" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        YSXFoundTypeModel *typeModel = [YSXFoundTypeModel yy_modelWithJSON:responseObject];
        [self.arr addObject:typeModel];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@", error);
    }];
}

#pragma mark -  <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    YSXFoundTypeModel *model = self.arr.lastObject;
    if (section == 0) {
        return model.male.count;
    }else if (section == 1) {
        return model.female.count;
    }else {
        return model.press.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSXClassifyCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    YSXFoundTypeModel *model = self.arr.lastObject;
    if (indexPath.section == 0) {
        YSXFoundContentModel *contentModel = model.male[indexPath.row];
        cell.model = contentModel;
    }else if (indexPath.section == 1) {
        YSXFoundContentModel *contentModel = model.female[indexPath.row];
        cell.model = contentModel;
    }else {
        YSXFoundContentModel *contentModel = model.press[indexPath.row];
        cell.model = contentModel;
    }
    [cell cancleWithSelectionBackground];
    return cell;
}

#pragma mark -  <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YSXFoundTypeModel *model = self.arr.lastObject;
    YSXFoundContentModel *contentModel;
    if (indexPath.section == 0) {
        contentModel = model.male[indexPath.row];
    }else if (indexPath.section == 1) {
        contentModel = model.female[indexPath.row];
    }else {
        contentModel = model.press[indexPath.row];
    }
    NSString *name = [contentModel.name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.navigationController pushViewController:[[YSXShowController alloc] initWithName:name] animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"男生专区";
    }else if(section == 1) {
        return @"女生专区";
    }else {
        return @"经典名著";
    }
}

/*
 NSString *url;
 if (indexPath.section == 0) {
 if (indexPath.row == 0) {
 url = @"http://api.zhuishushenqi.com/book/by-categories?gender=male&type=hot&major=玄幻&minor=&start=0&limit=50";
 }else if (indexPath.row == 1) {
 url = @"";
 }else if (indexPath.row == 2) {
 url = @"";
 }else if (indexPath.row == 3) {
 url = @"";
 }else if (indexPath.row == 4) {
 url = @"";
 }else if (indexPath.row == 5) {
 url = @"";
 }else if (indexPath.row == 6) {
 url = @"";
 }else if (indexPath.row == 7) {
 url = @"";
 }else if (indexPath.row == 8) {
 url = @"";
 }else if (indexPath.row == 9) {
 url = @"";
 }else if (indexPath.row == 10) {
 url = @"";
 }else if (indexPath.row == 11) {
 url = @"";
 }else if (indexPath.row == 12) {
 url = @"";
 }else if (indexPath.row == 13) {
 url = @"";
 }
 }else if (indexPath.section == 1) {
 if (indexPath.row == 0) {
 url = @"";
 }else if (indexPath.row == 1) {
 url = @"";
 }else if (indexPath.row == 2) {
 url = @"";
 }else if (indexPath.row == 3) {
 url = @"";
 }else if (indexPath.row == 4) {
 url = @"";
 }else if (indexPath.row == 5) {
 url = @"";
 }else if (indexPath.row == 6) {
 url = @"";
 }else if (indexPath.row == 7) {
 url = @"";
 }else if (indexPath.row == 8) {
 url = @"";
 }else if (indexPath.row == 9) {
 url = @"";
 }else if (indexPath.row == 10) {
 url = @"";
 }else if (indexPath.row == 11) {
 url = @"";
 }
 }else {
 if (indexPath.row == 0) {
 url = @"";
 }else if (indexPath.row == 1) {
 url = @"";
 }else if (indexPath.row == 2) {
 url = @"";
 }else if (indexPath.row == 3) {
 url = @"";
 }else if (indexPath.row == 4) {
 url = @"";
 }else if (indexPath.row == 5) {
 url = @"";
 }else if (indexPath.row == 6) {
 url = @"";
 }else if (indexPath.row == 7) {
 url = @"";
 }else if (indexPath.row == 8) {
 url = @"";
 }else if (indexPath.row == 9) {
 url = @"";
 }
 }
 */

@end
