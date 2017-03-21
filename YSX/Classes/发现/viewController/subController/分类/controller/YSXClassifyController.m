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
}

#pragma mark -  set up
- (void)setup {
    self.title = @"分类";
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
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

@end
