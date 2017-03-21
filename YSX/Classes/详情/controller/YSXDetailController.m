//
//  YSXDetailController.m
//  YSX
//
//  Created by Lib on 2017/3/7.
//  Copyright © 2017年 adirects. All rights reserved.
//

#import "YSXDetailController.h"
#import "YSXDetailCell.h"
#import "YSXDetailReviewCell.h"

static NSString *kDetailCellID = @"kDetailCellID";
static NSString *kDetailReviewCellID = @"kDetailReviewCellID";

@interface YSXDetailController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, copy) NSString *bookID;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *contentArr;
@end

@implementation YSXDetailController
#pragma mark -  init
- (instancetype)initWithBookID:(NSString *)bookID {
    if (self = [super init]) {
        self.bookID = bookID;
    }
    return self;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerNib:[UINib nibWithNibName:@"YSXDetailCell" bundle:nil] forCellReuseIdentifier:kDetailCellID];
        [_tableView registerNib:[UINib nibWithNibName:@"YSXDetailReviewCell" bundle:nil] forCellReuseIdentifier:kDetailReviewCellID];
        _tableView.estimatedRowHeight = 150;
    }
    return _tableView;
}

#pragma mark -  life cycle 
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self requestData];
}

#pragma mark -  set up
- (void)setup {
    self.contentArr = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    self.view.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
}

#pragma mark -  request data
- (void)requestData {
    NSString *url = [NSString stringWithFormat:@"http://api.zhuishushenqi.com/book/%@", self.bookID];
    [[AFHTTPSessionManager manager] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        YSXDetailModel *model = [YSXDetailModel yy_modelWithJSON:responseObject];
        [self.contentArr addObject:model];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark -  <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contentArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        YSXDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:kDetailCellID];
        cell.model = self.contentArr[indexPath.row];
        return cell;
    }else {
        YSXDetailReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDetailReviewCellID];
        cell.model = self.contentArr[indexPath.row];
        return cell;
    }
}



@end
