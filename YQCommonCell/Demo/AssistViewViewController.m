//
//  AssistViewViewController.m
//  YQCommonCell
//
//  Created by easylink on 2018/3/5.
//  Copyright © 2018年 YuQi. All rights reserved.
//

#import "AssistViewViewController.h"
#import "YQCommon.h"

@interface AssistViewViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray * groups;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation AssistViewViewController

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
        UIView *view0 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        view0.backgroundColor = [UIColor greenColor];
        YQCommonItem *item0 = YQObjectInit(YQCommonItem).titleSet(@"未超出最大范围(默认布局)").assistCustomViewSet(view0);
        
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        view1.backgroundColor = [UIColor greenColor];
        YQCommonItem *item1 = YQObjectInit(YQCommonItem).titleSet(@"未超出最大范围(居中布局)").assistCustomViewSet(view1).assistCustomViewLayoutSet(YQAssistCustomViewLayoutCenter);
        
        UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        view2.backgroundColor = [UIColor greenColor];
        YQCommonItem *item2 = YQObjectInit(YQCommonItem).titleSet(@"未超出最大范围(居左布局)").assistCustomViewSet(view2).assistCustomViewLayoutSet(YQAssistCustomViewLayoutLeft);
        
        UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        view3.backgroundColor = [UIColor greenColor];
        YQCommonItem *item3 = YQObjectInit(YQCommonItem).titleSet(@"未超出最大范围(默认布局)有箭头").assistCustomViewSet(view3).arrowSet(YES);
        
        // 设置header
        UIView *headerView = ({
            UILabel *headerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 220)];
            headerView.numberOfLines = 0;
            headerView.textColor = [UIColor lightGrayColor];
            headerView.font = [UIFont systemFontOfSize:14];
            headerView.text = @"当设置自定义视图时，存在两种情况\n1.未超出最大范围：此时默认会靠右居中布局，可设置layout属性修改\n2.超出最大范围：默认也是靠右居中布局，但是超出部分默认会被裁剪\n\n布局的逻辑是：通过cell自带的titleLable或提醒红点的最右侧和cell的contentView的最右侧的距离作为最大的宽度。由于最右侧的箭没放在contentView上，因此有无箭头都不影响布局\n\n下面group为未超出最大范围部分";
            headerView;
        });
        YQCommonGroup *group = YQObjectInit(YQCommonGroup).itemsSet(@[item0, item1, item2, item3]).headerViewSet(headerView);
        
        [self.groups addObject:group];
    }
   
    {
        UIView *view0 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        view0.backgroundColor = [UIColor greenColor];
        YQCommonItem *item0 = YQObjectInit(YQCommonItem).titleSet(@"超出最大范围(默认)").assistCustomViewSet(view0);
        
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        view1.backgroundColor = [UIColor greenColor];
        YQCommonItem *item1 = YQObjectInit(YQCommonItem).titleSet(@"超出(局左不裁剪)").assistCustomViewSet(view1).assistCustomViewLayoutSet(YQAssistCustomViewLayoutLeft).assistCustomViewClipsToBoundsSet(NO);
        
        // 设置header
        UIView *headerView = ({
            UILabel *headerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
            headerView.numberOfLines = 0;
            headerView.textColor = [UIColor lightGrayColor];
            headerView.font = [UIFont systemFontOfSize:14];
            headerView.text = @"下面group为超出最大范围部分";
            headerView;
        });
        YQCommonGroup *group = YQObjectInit(YQCommonGroup).itemsSet(@[item0, item1]).headerViewSet(headerView);
        
        [self.groups addObject:group];
    }
    
    {
        UIView *customView = ({
            UIButton *customView = [[UIButton alloc] initWithFrame:CGRectMake(20, 0, self.view.bounds.size.width - 40, 50)];
            [customView setTitle:@"自定义视图" forState:UIControlStateNormal];
            customView.backgroundColor = [UIColor greenColor];
            customView.layer.cornerRadius = 5;
            customView;
        });
        YQCommonItem *item = YQObjectInit(YQCommonItem).assistCustomViewSet(customView).cellBackgroudColorSet([UIColor groupTableViewBackgroundColor]).cellHeightSet(50).selectHighlightSet(NO).assistCustomViewLayoutSet(YQAssistCustomViewLayoutCenter).assistCustomViewClipsToBoundsSet(NO);
        
        // 设置header
        UIView *headerView = ({
            UILabel *headerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
            headerView.numberOfLines = 0;
            headerView.textColor = [UIColor lightGrayColor];
            headerView.font = [UIFont systemFontOfSize:14];
            headerView.text = @"有了自定义视图，就能绘制所有视图了";
            headerView;
        });
        YQCommonGroup *group = YQObjectInit(YQCommonGroup).itemsSet(@[item]).headerViewSet(headerView);
        
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
