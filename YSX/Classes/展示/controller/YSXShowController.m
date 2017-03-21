//
//  YSXShowController.m
//  YSX
//
//  Created by Lib on 2017/3/7.
//  Copyright © 2017年 adirects. All rights reserved.
//

#import "YSXShowController.h"
#import "YSXShowCell.h"
#import "YSXDetailController.h"

static NSString *cell_id = @"cell_id";
static NSString *linkURL = @"http://api.zhuishushenqi.com/book/by-categories";

@interface YSXShowController ()
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableDictionary *parameters;
@property (nonatomic, strong) NSMutableArray *bookArr;
@end

@implementation YSXShowController {
    NSString *type;         // 热门：hot   新书：new  好评：reputation   完结：over
    NSUInteger page;
    NSUInteger bookCount;
}

#pragma mark -  init
- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        self.name = name;
    }
    return self;
}

#pragma mark -  life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

#pragma mark -  set up
- (void)setup {
    type = @"hot";
    
    self.bookArr = [NSMutableArray array];
    
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    [self.tableView registerNib:[UINib nibWithNibName:@"YSXShowCell" bundle:nil] forCellReuseIdentifier:cell_id];
    self.tableView.rowHeight = 150;
    
    bookCount = 50;
    
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

#pragma mark -  down refresh
- (void)downRefresh {
    page = 0;
    NSString *url = [NSString stringWithFormat:@"%@?gender=male&type=%@&major=%@&minor=&start=%zi&limit=%zi", linkURL, type, self.name, page, bookCount];
    [[AFHTTPSessionManager manager] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.bookArr removeAllObjects];
        [self addModelWithResponseObject:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%d->%s:%@", __LINE__, __func__, error);
    }];
}

#pragma mark -  up load
- (void)upLoad {
    page += bookCount;
    NSString *url = [NSString stringWithFormat:@"%@?gender=male&type=%@&major=%@&minor=&start=%zi&limit=%zi", linkURL, type, self.name, page, bookCount];
    [[AFHTTPSessionManager manager] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.tableView.mj_footer endRefreshing];
        [self addModelWithResponseObject:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%d->%s:%@", __LINE__, __func__, error);
    }];
}

#pragma mark -  添加模型
- (void)addModelWithResponseObject:(id)responseObject {
    NSArray *arr = responseObject[@"books"];
    for (NSDictionary *dict in arr) {
        YSXShowModel *model = [YSXShowModel yy_modelWithDictionary:dict];
        [self.bookArr addObject:model];
    }
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bookArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSXShowCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id forIndexPath:indexPath];
    cell.model = self.bookArr[indexPath.row];
    return cell;
}

#pragma mark -  <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YSXShowModel *model = self.bookArr[indexPath.row];
    YSXDetailController *detailVC = [[YSXDetailController alloc] initWithBookID:model.bookID];
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
