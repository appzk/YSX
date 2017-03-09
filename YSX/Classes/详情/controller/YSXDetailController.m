//
//  YSXDetailController.m
//  YSX
//
//  Created by Lib on 2017/3/7.
//  Copyright © 2017年 adirects. All rights reserved.
//

#import "YSXDetailController.h"
#import "YSXDetailView.h"

@interface YSXDetailController ()
@property (nonatomic, copy) NSString *bookID;
@property (nonatomic, strong) YSXDetailView *detailView;
@property (nonatomic, strong) YSXDetailModel *model;
@end

@implementation YSXDetailController

#pragma mark -  init
- (instancetype)initWithBookID:(NSString *)bookID {
    if (self = [super init]) {
        self.bookID = bookID;
    }
    return self;
}

#pragma mark -  lazy
- (YSXDetailView *)detailView {
    if (!_detailView) {
        _detailView = [[NSBundle mainBundle] loadNibNamed:@"YSXDetailView" owner:nil options:nil].firstObject;
        _detailView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self.view addSubview:_detailView];
    }
    return _detailView;
}

#pragma mark -  life cycle 
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    self.detailView.hidden = YES;
    [self requestData];
}

#pragma mark -  set up
- (void)setup {
    self.view.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
}

#pragma mark -  request data
- (void)requestData {
    NSString *url = [NSString stringWithFormat:@"http://api.zhuishushenqi.com/book/%@", self.bookID];
    [[AFHTTPSessionManager manager] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.model = [YSXDetailModel yy_modelWithJSON:responseObject];
        [self showData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark -  显示数据
- (void)showData {
    self.detailView.hidden = NO;
    self.detailView.model = self.model;
}

@end
