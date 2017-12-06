//
//  ViewController.m
//  YQCommonCell
//
//  Created by easylink on 2017/12/6.
//  Copyright © 2017年 YuQi. All rights reserved.
//

#import "ViewController.h"
#import "YQCommonCell.h"
#import "YQCommonGroup.h"
#import "YQCommonItem.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *groups;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark - tableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    YQCommonGroup *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YQCommonCell *cell = [YQCommonCell cellWithTableView:tableView];
    YQCommonGroup *group = self.groups[indexPath.section];
    cell.item = group.items[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YQCommonGroup *group = self.groups[indexPath.section];
    YQCommonItem *item = group.items[indexPath.row];
    
    if (item.destVcClass) {
        [self presentViewController:[[item.destVcClass alloc] init] animated:YES completion:nil];
    }
    
    if (item.operation) {
        item.operation();
    }
}


- (NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
        
        YQCommonGroup *group = [[YQCommonGroup alloc] init];
        
        YQCommonItem *item1 = [YQCommonItem itemWithTitle:@"第一行" icon:@"0" arrow:YES screenSeparator:YES];
        item1.badgeValue = @"2";
        item1.assistLabelText = @"第一行第一行";
        item1.operation = ^{
            
        };
        
        YQCommonItem *item2 = [YQCommonItem itemWithTitle:@"第二行第二行" icon:@"1" arrow:YES screenSeparator:YES];
        item2.assistLabelText = @"第二行第二行第二行第二行第二行第二行第二行第二行第二行第二行第二行第二行";
        item2.operation = ^{
            
        };
        
        YQCommonItem *item3 = [YQCommonItem itemWithTitle:@"第三行第三行第三行" icon:@"2" arrow:YES screenSeparator:YES];
        item3.iconWidth = 30;
        item3.assistFieldPlaceholderText = @"第三行第三行";
        item3.operation = ^{
            
        };
        
        YQCommonItem *item4 = [YQCommonItem itemWithTitle:@"第四行" icon:@"3" arrow:YES screenSeparator:YES];
        item4.assistImageURLStr = @"https://ss0.baidu.com/73F1bjeh1BF3odCf/it/u=2953611372,3247682668&fm=85&s=DCE02CC4015325CA441C3C3903001040";
        item4.destVcClass = [ViewController class];
        
        YQCommonItem *item5 = [YQCommonItem itemWithTitle:@"第五行" icon:@"2" arrow:NO screenSeparator:YES];
        item5.iconWidth = 100;
        item5.assistLabelText = @"第五行第五行";
        item5.operation = ^{
            NSLog(@"--");
        };
        
        YQCommonItem *item6 = [YQCommonItem itemWithTitle:@"第六行" icon:@"2" arrow:NO screenSeparator:YES];
        item6.assistImageFileStr = @"2";
        item6.assistImageWidth = 60;
        item6.assistImageCornerRadius = 30;
        item6.operation = ^{
            
        };
        
        group.items = @[item1, item2, item3, item4, item5, item6, item1, item2, item3, item4, item5, item6];
        
        [_groups addObject:group];
        [_groups addObject:group];
    }
    return _groups;
}


@end
