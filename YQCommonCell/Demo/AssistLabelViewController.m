//
//  AssistLabelViewController.m
//  YQCommonCell
//
//  Created by easylink on 2018/3/5.
//  Copyright © 2018年 YuQi. All rights reserved.
//

#import "AssistLabelViewController.h"
#import "YQCommon.h"

@interface AssistLabelViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray * groups;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation AssistLabelViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self setData];
    
    [self setView];
}

- (void)setData
{
    YQCommonItem *item0 = YQObjectInit(YQCommonItem).titleSet(@"默认").assistLabelTextSet(self.title);
    
    YQCommonItem *item1 = YQObjectInit(YQCommonItem).titleSet(@"assistLabel字体").assistLabelTextSet(self.title).assistLabelFontSet([UIFont boldSystemFontOfSize:20]);
    
    YQCommonItem *item2 = YQObjectInit(YQCommonItem).titleSet(@"assistLabel颜色").assistLabelTextSet(self.title).assistLabelColorSet([UIColor greenColor]);
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self.title];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 11)];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(11, self.title.length - 11)];
    YQCommonItem *item3 = YQObjectInit(YQCommonItem).titleSet(@"attributedTitleSet").assistLabelAttributedTextSet(attributedStr);
    
    YQCommonItem *item4 = YQObjectInit(YQCommonItem).titleSet(@"assistLabelX").assistLabelTextSet(self.title).assistLabelXSet(130);
    
    YQCommonGroup *group = YQObjectInit(YQCommonGroup).itemsSet(@[item0, item1, item2, item3, item4]);
    
    [self.groups addObject:group];
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
