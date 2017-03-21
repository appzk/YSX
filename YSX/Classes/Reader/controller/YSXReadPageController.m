//
//  YSXReadPageController.m
//  YSX
//
//  Created by Lib on 2017/3/21.
//  Copyright © 2017年 adirects. All rights reserved.
//

#import "YSXReadPageController.h"
#import "YSXReadController.h"
#import "LBPagination.h"

@interface YSXReadPageController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>
@property (nonatomic, strong) UIPageViewController *pageVC;
@end

@implementation YSXReadPageController

- (UIPageViewController *)pageVC {
    if (!_pageVC) {
        _pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:@{}];
        _pageVC.delegate = self;
        _pageVC.dataSource = self;
    }
    return _pageVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
}

- (void)requestData {
    [[AFHTTPSessionManager manager] GET:@"" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)addSubviewControllers {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    return nil;
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    return nil;
}

@end
