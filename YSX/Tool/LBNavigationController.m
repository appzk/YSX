//
//  LBNavigationController.m
//  百思不得姐
//
//  Created by ma c on 16/3/16.
//  Copyright © 2016年 bjsxt. All rights reserved.
//

#import "LBNavigationController.h"

@interface LBNavigationController ()

@end

@implementation LBNavigationController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UINavigationBar appearance] setBackgroundImage:[UIColor color:RGBA_COLOR(19, 124, 118, 1)] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[UIColor color:RGBA_COLOR(19, 124, 118, 1)]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
}

#pragma mark -
#pragma mark 重写push方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {  //如果push进来的不是第一个控制器
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"nav_back_click"] forState:UIControlStateHighlighted];
        
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        
        btn.size = CGSizeMake(70, 30);
        
        //向左偏移
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        
        [btn addTarget:self action:@selector(backViewController) forControlEvents:UIControlEventTouchUpInside];
        
        //自定义左边按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)backViewController
{
    //返回控制器
    [self popViewControllerAnimated:YES];
}

@end
