//
//  MainViewController.m
//  YQCommonCell
//
//  Created by easylink on 2018/3/2.
//  Copyright © 2018年 YuQi. All rights reserved.
//

#import "MainViewController.h"
#import "YQCommon.h"
#import "TitleViewController.h"
#import "AssistLabelViewController.h"
#import "AssistFeildViewController.h"
#import "AssistViewViewController.h"
#import "OtherViewController.h"
#import "IconAndBadgeViewController.h"

@interface MainViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray * groups;

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Main";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self setData];
    
    [self setView];
}

- (void)setData
{
    __weak typeof(self) weakSelf = self;
    
    YQCommonItem *item0 = YQObjectInit(YQCommonItem).titleSet(@"title属性展示").arrowSet(YES).operationSet(^{
        TitleViewController *title = [[TitleViewController alloc] init];
        title.title = @"title属性展示";
        [weakSelf.navigationController pushViewController:title animated:YES];
    });
    
    YQCommonItem *item1 = YQObjectInit(YQCommonItem).titleSet(@"icon以及badge属性展示").arrowSet(YES).operationSet(^{
        IconAndBadgeViewController *icon = [[IconAndBadgeViewController alloc] init];
        icon.title = @"icon以及badge属性展示";
        [weakSelf.navigationController pushViewController:icon animated:YES];
    });

    YQCommonItem *item2 = YQObjectInit(YQCommonItem).titleSet(@"assistLabel属性展示").arrowSet(YES).operationSet(^{
        AssistLabelViewController *AssistLabel = [[AssistLabelViewController alloc] init];
        AssistLabel.title = @"assistLabel属性展示";
        [weakSelf.navigationController pushViewController:AssistLabel animated:YES];
    });

    YQCommonItem *item3 = YQObjectInit(YQCommonItem).titleSet(@"assistFeild属性展示").arrowSet(YES).operationSet(^{
        AssistFeildViewController *AssistFeild = [[AssistFeildViewController alloc] init];
        AssistFeild.title = @"assistFeild属性展示";
        [weakSelf.navigationController pushViewController:AssistFeild animated:YES];
    });
    
    YQCommonItem *item4 = YQObjectInit(YQCommonItem).titleSet(@"assistView属性展示").arrowSet(YES).operationSet(^{
        AssistViewViewController *assistView = [[AssistViewViewController alloc] init];
        assistView.title = @"assistView属性展示";
        [weakSelf.navigationController pushViewController:assistView animated:YES];
    });

    YQCommonItem *item5 = YQObjectInit(YQCommonItem).titleSet(@"其他").arrowSet(YES).operationSet(^{
        OtherViewController *other = [[OtherViewController alloc] init];
        other.title = @"其他";
        [weakSelf.navigationController pushViewController:other animated:YES];
    });
    
    
    YQCommonGroup *group = YQObjectInit(YQCommonGroup).itemsSet(@[item0, item1, item2, item3, item4, item5]);
    
    [self.groups addObject:group];
}

- (void)setView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    self.tableView.frame = CGRectMake(0, YQTableViewY, self.view.bounds.size.width, self.view.bounds.size.height - YQTableViewY - YQIndicatorHeight);
    YQNewAdjustsScrollViewInsets(self.tableView);
}

#pragma mark - lazy
- (NSMutableArray *)groups
{
    if (!_groups) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

#pragma mark - tableview Data
YQTabelViewDelegateAndDataSource(self.groups)
@end
