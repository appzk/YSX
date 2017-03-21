//
//  YSXSearchController.m
//  YSX
//
//  Created by Lib on 2017/3/8.
//  Copyright © 2017年 adirects. All rights reserved.
//

#import "YSXSearchController.h"

@interface YSXSearchController ()

@end

@implementation YSXSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}

@end
