//
//  AssistFeildViewController.m
//  YQCommonCell
//
//  Created by easylink on 2018/3/5.
//  Copyright © 2018年 YuQi. All rights reserved.
//

#import "AssistFeildViewController.h"
#import "YQCommon.h"

@interface AssistFeildViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray * groups;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation AssistFeildViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self setData];
    
    [self setView];
}

- (void)setData
{
    YQCommonItem *item0 = YQObjectInit(YQCommonItem).titleSet(@"默认(有text)").assistFieldTextSet(self.title).assistFieldPlaceholderTextSet(@"Placeholder");
    
    YQCommonItem *item1 = YQObjectInit(YQCommonItem).titleSet(@"默认(无text)").assistFieldPlaceholderTextSet(@"Placeholder");
    
    YQCommonItem *item2 = YQObjectInit(YQCommonItem).titleSet(@"assistField字体").assistFieldFontSet([UIFont boldSystemFontOfSize:20]).assistFieldTextSet(self.title);
    
    YQCommonItem *item3 = YQObjectInit(YQCommonItem).titleSet(@"assistField颜色").assistFieldColorSet([UIColor greenColor]).assistFieldTextSet(self.title);
    
    YQCommonItem *item4 = YQObjectInit(YQCommonItem).titleSet(@"Placeholder颜色").assistFieldPlaceholderTextSet(@"Placeholder").assistFieldPlaceholderColorSet([UIColor redColor]);
    
    YQCommonItem *item5 = YQObjectInit(YQCommonItem).titleSet(@"assistField X").assistFieldTextSet(self.title).assistFieldPlaceholderTextSet(@"Placeholder").assistFieldXSet(120);
    
    __weak typeof(self) weakSelf = self;
    YQCommonItem *item6 = YQObjectInit(YQCommonItem).titleSet(@"assistField回调展示").assistFieldTextSet(self.title).assistFieldPlaceholderTextSet(@"Placeholder").assistFieldKeyboardTypeSet(UIKeyboardTypeEmailAddress);
    item6.fieldEditFinishBlock = ^BOOL(NSString *text) {
        NSLog(@"%@", text);
        [weakSelf.view endEditing:YES];
        return YES;
    };
    item6.fieldTextChangeBlock = ^(NSString *text) {
        NSLog(@"%@", text);
    };
    
    YQCommonGroup *group = YQObjectInit(YQCommonGroup).itemsSet(@[item0, item1, item2, item3, item4, item5, item6]);
    
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
