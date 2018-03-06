//
//  OtherViewController.m
//  YQCommonCell
//
//  Created by easylink on 2018/3/5.
//  Copyright © 2018年 YuQi. All rights reserved.
//

#import "OtherViewController.h"
#import "YQCommon.h"

@interface OtherViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray * groups;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation OtherViewController

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
        YQCommonItem *item0 = YQObjectInit(YQCommonItem).titleSet(@"cell的高度:100").cellHeightSet(100);
        
        YQCommonItem *item1 = YQObjectInit(YQCommonItem).titleSet(@"cell的背景颜色:lightGrayColor").cellBackgroudColorSet([UIColor lightGrayColor]).arrowSet(YES);
        
        YQCommonItem *item2 = YQObjectInit(YQCommonItem).titleSet(@"cell不能响应点击").selectAbilitySet(NO);
        
        YQCommonItem *item3 = YQObjectInit(YQCommonItem).titleSet(@"cell点击不高亮").selectHighlightSet(NO);
        
        // 设置header
        UIView *headerView = ({
            UILabel *headerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
            headerView.numberOfLines = 0;
            headerView.textColor = [UIColor lightGrayColor];
            headerView.font = [UIFont systemFontOfSize:14];
            headerView.text = @"cell自身的相关属性";
            headerView;
        });
        YQCommonGroup *group = YQObjectInit(YQCommonGroup).itemsSet(@[item0, item1, item2, item3]).headerViewSet(headerView).footerHeightSet(40);
        
        [self.groups addObject:group];
    }
    
    {
        YQCommonItem *item0 = YQObjectInit(YQCommonItem).titleSet(@"默认分割线");
        
        YQCommonItem *item1 = YQObjectInit(YQCommonItem).titleSet(@"关闭分割线").hadBottomLineSet(NO);

        YQCommonItem *item2 = YQObjectInit(YQCommonItem).titleSet(@"分割线的x位置：100").bottomLineXSet(100);

        YQCommonItem *item3 = YQObjectInit(YQCommonItem).titleSet(@"分割线的高度：5").bottomLineHeightSet(5);
        
        // 设置header
        UIView *headerView = ({
            UILabel *headerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
            headerView.numberOfLines = 0;
            headerView.textColor = [UIColor lightGrayColor];
            headerView.font = [UIFont systemFontOfSize:14];
            headerView.text = @"cell分割线属性";
            headerView;
        });
        YQCommonGroup *group = YQObjectInit(YQCommonGroup).itemsSet(@[item0, item1, item2, item3]).headerViewSet(headerView).footerHeightSet(40).hiddenLastRowBottomLineSet(NO);
        
        [self.groups addObject:group];
    }
    
    {
        YQCommonItem *item0 = YQObjectInit(YQCommonItem).titleSet(@"设置了group的headerTitle和footerTitle");
        
        YQCommonGroup *group = YQObjectInit(YQCommonGroup).itemsSet(@[item0]).headerTitleSet(@"通过headerTitle属性设置").footerTitleSet(@"通过footerTitle属性设置");
        
        [self.groups addObject:group];
    }
    
    {
        YQCommonItem *item0 = YQObjectInit(YQCommonItem).titleSet(@"设置了group的headerview和footerview");

        // 设置header
        UIView *headerView = ({
            UILabel *headerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
            headerView.backgroundColor = [UIColor greenColor];
            headerView.numberOfLines = 0;
            headerView.textColor = [UIColor lightGrayColor];
            headerView.font = [UIFont systemFontOfSize:14];
            headerView.text = @"这是下面这个group的headerview";
            headerView;
        });
        // 设置header
        UIView *footerView = ({
            UILabel *footerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
            footerView.backgroundColor = [UIColor greenColor];
            footerView.numberOfLines = 0;
            footerView.textColor = [UIColor lightGrayColor];
            footerView.font = [UIFont systemFontOfSize:14];
            footerView.text = @"这是下面这个group的footerView";
            footerView;
        });
        YQCommonGroup *group = YQObjectInit(YQCommonGroup).itemsSet(@[item0]).headerViewSet(headerView).footerViewSet(footerView);
        
        [self.groups addObject:group];
    }
    
    {
        YQCommonItem *item0 = YQObjectInit(YQCommonItem).titleSet(@"第一行");
        YQCommonItem *item1 = YQObjectInit(YQCommonItem).titleSet(@"第二行");
        YQCommonItem *item2 = YQObjectInit(YQCommonItem).titleSet(@"第三行");
        
        // 设置header
        UIView *headerView = ({
            UILabel *headerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
            headerView.numberOfLines = 0;
            headerView.textColor = [UIColor lightGrayColor];
            headerView.font = [UIFont systemFontOfSize:14];
            headerView.text = @"注意，YQCommonGroup有一个不容易引起注意的属性：hiddenLastRowBottomLine\n该属性作用为隐藏最后一行cell的分割线，默认开启";
            headerView;
        });
        
        YQCommonGroup *group = YQObjectInit(YQCommonGroup).itemsSet(@[item0, item1, item2]).headerViewSet(headerView);
        [self.groups addObject:group];
    }
    
    {
        YQCommonItem *item0 = YQObjectInit(YQCommonItem).titleSet(@"第一行");
        YQCommonItem *item1 = YQObjectInit(YQCommonItem).titleSet(@"第二行");
        YQCommonItem *item2 = YQObjectInit(YQCommonItem).titleSet(@"第三行");
        
        // 设置header
        UIView *headerView = ({
            UILabel *headerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
            headerView.numberOfLines = 0;
            headerView.textColor = [UIColor lightGrayColor];
            headerView.font = [UIFont systemFontOfSize:14];
            headerView.text = @"当你把这个hiddenLastRowBottomLine关闭后，就会出现这样效果";
            headerView;
        });
        
        YQCommonGroup *group = YQObjectInit(YQCommonGroup).itemsSet(@[item0, item1, item2]).headerViewSet(headerView).hiddenLastRowBottomLineSet(NO);
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
