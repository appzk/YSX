//
//  YSXSearchController.m
//  YSX
//
//  Created by Lib on 2017/3/8.
//  Copyright © 2017年 adirects. All rights reserved.
//

#import "YSXSearchController.h"
#import "YSXSearchCell.h"
#import "YSXDetailController.h"

static NSString *kCellID = @"kCellID";
static NSString *url = @"http://api.zhuishushenqi.com/book/fuzzy-search";

@interface YSXSearchController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSString *searchText;
@property (nonatomic, strong) NSMutableArray *contentArr;
@end

@implementation YSXSearchController {
    NSUInteger page;
    NSUInteger bookCount;
}

#pragma mark -  lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"YSXSearchCell" bundle:nil] forCellReuseIdentifier:kCellID];
        _tableView.rowHeight = 100;
    }
    return _tableView;
}

#pragma mark -  init
- (instancetype)initWithSearchText:(NSString *)text {
    if (self = [super init]) {
        self.searchText = text;
    }
    return self;
}

#pragma mark -  life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

#pragma mark -  setup
- (void)setup {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);

    self.contentArr = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    
    bookCount = 100;
    
    // 下拉刷新
    MJRefreshGifHeader *gifHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [self downRefresh];
    }];
    gifHeader.lastUpdatedTimeLabel.hidden = YES;
    gifHeader.stateLabel.hidden = YES;
    //添加gif图片
    [gifHeader setImages:GIF_ARRAY forState:MJRefreshStateRefreshing];
    self.tableView.mj_header = gifHeader;
    [self.tableView.mj_header beginRefreshing];
    
    // 上拉加载
    MJRefreshBackStateFooter *footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(upLoad)];
    [footer setTitle:@"加载中..." forState:MJRefreshStatePulling];
    [footer setTitle:@"加载中..." forState:MJRefreshStateIdle];
    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    self.tableView.mj_footer = footer;
    
    [self downRefresh];
}

#pragma mark -  下拉刷新
- (void)downRefresh {
    page = 0;
    NSDictionary *patmeters = @{
                                @"query":self.searchText,
                                @"start":@(page),
                                @"limit":@(bookCount)
                                };
    [[AFHTTPSessionManager manager] GET:url parameters:patmeters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.contentArr removeAllObjects];
        [self addModelWithResponseObject:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%d->%s:%@", __LINE__, __func__, error);
    }];
}

#pragma mark -  上拉加载
- (void)upLoad {
    page += bookCount;
    NSDictionary *patmeters = @{
                                @"query":self.searchText,
                                @"start":@(page),
                                @"limit":@(bookCount)
                                };
    [[AFHTTPSessionManager manager] GET:url parameters:patmeters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.tableView.mj_footer endRefreshing];
        [self addModelWithResponseObject:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%d->%s:%@", __LINE__, __func__, error);
    }];
}

#pragma mark -  添加模型
- (void)addModelWithResponseObject:(id)responseObject {
    for (NSDictionary *dict in responseObject[@"books"]) {
        YSXSearchModel *model = [YSXSearchModel yy_modelWithJSON:dict];
        [self.contentArr addObject:model];
    }
    [self.tableView reloadData];
}

#pragma mark -  <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contentArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSXSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    cell.model = self.contentArr[indexPath.row];
    return cell;
}

#pragma mark -  <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YSXSearchModel *model = self.contentArr[indexPath.row];
    [self.navigationController pushViewController:[[YSXDetailController alloc] initWithBookID:model.bookID] animated:YES];
}

@end
