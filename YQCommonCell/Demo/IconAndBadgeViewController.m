//
//  IconAndBadgeViewController.m
//  YQCommonCell
//
//  Created by easylink on 2018/3/5.
//  Copyright © 2018年 YuQi. All rights reserved.
//

#import "IconAndBadgeViewController.h"
#import "YQCommon.h"

@interface IconAndBadgeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray * groups;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation IconAndBadgeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self setData];
    
    [self setView];
}

- (void)setData
{
    {
        YQCommonItem *item0 = YQObjectInit(YQCommonItem).titleSet(@"默认Icon").assistLabelTextSet(self.title).iconSet(@"1");
        
        YQCommonItem *item1 = YQObjectInit(YQCommonItem).titleSet(@"Icon宽度 设置").assistLabelTextSet(self.title).iconSet(@"1").iconWidthSet(44);
        
        YQCommonGroup *group = YQObjectInit(YQCommonGroup).itemsSet(@[item0, item1]);
        
        [self.groups addObject:group];
    }
    {
        YQCommonItem *item0 = YQObjectInit(YQCommonItem).titleSet(@"提醒视图 默认").badgeValueSet(@"33");
        
        YQCommonItem *item1 = YQObjectInit(YQCommonItem).titleSet(@"提醒视图 局右").badgeValueSet(@"33").badgeLayoutSet(YQBadgeViewLayoutRight);

        YQCommonItem *item2 = YQObjectInit(YQCommonItem).titleSet(@"提醒视图 局右 有箭头").badgeValueSet(@"33").badgeLayoutSet(YQBadgeViewLayoutRight).arrowSet(YES);
        
        YQCommonItem *item3 = YQObjectInit(YQCommonItem).titleSet(@"提醒视图 局右 有辅助视图").badgeValueSet(@"33").badgeLayoutSet(YQBadgeViewLayoutRight).assistLabelTextSet(@"assistLable");
        
        YQCommonGroup *group = YQObjectInit(YQCommonGroup).itemsSet(@[item0, item1, item2, item3]);
        
        [self.groups addObject:group];
    }
}

- (void)setView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, YQTableViewY, self.view.bounds.size.width, self.view.bounds.size.height - YQTableViewY - YQIndicatorHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    YQNewAdjustsScrollViewInsets(self.tableView);
}

- (NSMutableArray *)groups
{
    if (!_groups) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

YQTabelViewDelegateAndDataSource(self.groups)
@end
