//
//  ViewController.m
//  YSX
//
//  Created by Lib on 2017/3/3.
//  Copyright © 2017年 adirects. All rights reserved.
//

#import "YSXRootController.h"
#import "YSXBookshelf.h"
#import "YSXCommunity.h"
#import "YSXFound.h"
#import "YSXSearchController.h"

static NSString *booshelf_cell_id = @"booshelf_cell_id";
static NSString *community_cell_id = @"community_cell_id";
static NSString *found_cell_id = @"found_cell_id";

@interface YSXRootController ()<UICollectionViewDelegate, UICollectionViewDataSource, LBSegmentedControlDelegate, YBPopupMenuDelegate>
@property (nonatomic, strong) LBSegmentedControl *segmentedControl;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation YSXRootController

#pragma mark -  lazy
- (LBSegmentedControl *)segmentedControl {
    if (!_segmentedControl) {
        _segmentedControl = [[LBSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44) items:@[@"书架", @"社区", @"发现"]];
        _segmentedControl.delegate = self;
        _segmentedControl.backgroundColor = RGBA_COLOR(19, 124, 118, 1);
        _segmentedControl.selectedColor = RGBA_COLOR(190, 179, 140, 1);
    }
    return _segmentedControl;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - self.segmentedControl.maxY);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.segmentedControl.maxY, SCREEN_WIDTH, SCREEN_HEIGHT - self.segmentedControl.maxY) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        
        [_collectionView registerClass:[YSXBookshelf class] forCellWithReuseIdentifier:booshelf_cell_id];
        [_collectionView registerClass:[YSXCommunity class] forCellWithReuseIdentifier:community_cell_id];
        [_collectionView registerClass:[YSXFound class] forCellWithReuseIdentifier:found_cell_id];
    }
    return _collectionView;
}

#pragma mark -  lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.segmentedControl];
    [self setupNavightionViewController];
    [self.view addSubview:self.collectionView];
    // 注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeContentOffset) name:@"add_book" object:nil];
}

#pragma mark -  setup nav
- (void)setupNavightionViewController {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:@"nav_titleView"];
    UIBarButtonItem *searchItem = [UIBarButtonItem barButtonItemWithImage:@"nav_search" target:self action:@selector(searchAction:)];
    UIBarButtonItem *menuItem = [UIBarButtonItem barButtonItemWithImage:@"nav_menu" target:self action:@selector(menuAction:)];
    self.navigationItem.rightBarButtonItems = @[menuItem,searchItem];
}

#pragma mark -  barButtonItem action
- (void)searchAction:(UIBarButtonItem *)barButtonItem {
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:@[@"玄幻", @"仙侠", @"都市", @"历史", @"网游", @"同人", @"科技"] searchBarPlaceholder:@"输入要书名或作者" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        [searchViewController.navigationController pushViewController:[[YSXSearchController alloc] initWithSearchText:searchText] animated:YES];
    }];
    searchViewController.hotSearchHeader.text = @"热门";
    searchViewController.searchHistoryTitle = @"历史";
    searchViewController.emptySearchHistoryLabel.text = @"清空历史";
    [searchViewController.cancelButton setTitle:@"取消"];
    [searchViewController.cancelButton setTintColor:[UIColor whiteColor]];
    [self.navigationController pushViewController:searchViewController animated:YES];
}

- (void)menuAction:(UIBarButtonItem *)barButtonItem {
    YBPopupMenu *menu = [YBPopupMenu showRelyOnView:(UIView *)barButtonItem titles:@[@"夜间", @"设置"] icons:@[@"menu_night", @"menu_set"] menuWidth:200 delegate:self];
    menu.type = YBPopupMenuTypeDark;
}

#pragma mark -  notification center action
- (void)changeContentOffset {
    [self.collectionView setContentOffset:CGPointMake(SCREEN_WIDTH * 2, 0) animated:YES];
    [self.segmentedControl updatePromptViewWithCount:2];
}

#pragma mark -  <UIScrollViewDelegate>
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self.segmentedControl updatePromptViewWithCount:(scrollView.contentOffset.x / SCREEN_WIDTH)];
}

#pragma mark -  <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        YSXBookshelf *cell = [collectionView dequeueReusableCellWithReuseIdentifier:booshelf_cell_id forIndexPath:indexPath];
        cell.collectionView = collectionView;
        return cell;
    }else if (indexPath.row == 1) {
        YSXCommunity *cell = [collectionView dequeueReusableCellWithReuseIdentifier:community_cell_id forIndexPath:indexPath];
        cell.vc = self;
        return cell;
    }else {
        YSXFound *cell = [collectionView dequeueReusableCellWithReuseIdentifier:found_cell_id forIndexPath:indexPath];
        cell.vc = self;
        return cell;
    }
}

#pragma mark -  <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark -  <LBSegmentedControlDelegate>
- (void)segmentedControlWithSegment:(LBSegmentedControl *)segment didSelectedItem:(NSInteger)count {
    [self.collectionView setContentOffset:CGPointMake(SCREEN_WIDTH * count, 0) animated:YES];
}

#pragma mark -  <YBPopupMenuDelegate>
- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu {
    NSLog(@"%d->点击了第%zd个item", __LINE__, index);
    if (index == 0) {
        // 判断当前是否为夜间模式
        if ([self.dk_manager.themeVersion isEqualToString:DKThemeVersionNight]) {
            // 切换为白天模式
            [self.dk_manager dawnComing];
        } else {
            // 切换为夜间模式
            [self.dk_manager nightFalling];
        }
    }else {
        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        path = [path stringByAppendingPathComponent:@"bookshelf.data"];
        BOOL flag = [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        if (flag) {
            NSLog(@"删除成功");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"remove" object:nil];
        }else {
            NSLog(@"删除失败");
        }
    }
}

@end
