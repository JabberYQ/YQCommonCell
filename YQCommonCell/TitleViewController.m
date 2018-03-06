//
//  TitleViewController.m
//  YQCommonCell
//
//  Created by easylink on 2018/3/5.
//  Copyright © 2018年 YuQi. All rights reserved.
//

#import "TitleViewController.h"
#import "YQCommon.h"

@interface TitleViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray * groups;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TitleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self setData];
    
    [self setView];
}

- (void)setData
{
    YQCommonItem *item0 = YQObjectInit(YQCommonItem).titleSet(self.title).assistLabelTextSet(@"默认");
    
    YQCommonItem *item1 = YQObjectInit(YQCommonItem).titleSet(self.title).titleLableFontSet([UIFont boldSystemFontOfSize:20]).assistLabelTextSet(@"[UIFont boldSystemFontOfSize:20]");
    
    YQCommonItem *item2 = YQObjectInit(YQCommonItem).titleSet(self.title).titleLableColorSet([UIColor greenColor]).assistLabelTextSet(@"[UIColor greenColor]");
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self.title];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 5)];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, self.title.length - 5)];
    YQCommonItem *item3 = YQObjectInit(YQCommonItem).attributedTitleSet(attributedStr).assistLabelTextSet(@"attributedTitleSet");
    
    YQCommonGroup *group = YQObjectInit(YQCommonGroup).itemsSet(@[item0, item1, item2, item3]);
    
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
