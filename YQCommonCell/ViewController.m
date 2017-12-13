//
//  ViewController.m
//  YQCommonCell
//
//  Created by easylink on 2017/12/6.
//  Copyright © 2017年 YuQi. All rights reserved.
//

#import "ViewController.h"
#import "YQCommonGroup.h"
#import "YQCommonItem.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
}

- (void)initData
{

    YQCommonItem *item1 = [YQCommonItem itemWithTitle:@"第一行" icon:@"0" arrow:YES hadBottomLine:YES];
    item1.cellHeight = 150;
    item1.selectAbility = NO;
    item1.bottomLineX = 100;
    item1.operation = ^{
        NSLog(@"第一行");
    };
    
    YQCommonItem *item2 = [YQCommonItem itemWithTitle:@"第二行第二行" icon:@"1" arrow:NO hadBottomLine:YES];
    item2.bottomLineX = 200;
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor clearColor];
    v.frame = CGRectMake(0, 0, 140, 40);
    v.layer.cornerRadius = 4;
    
    UILabel *l = [[UILabel alloc] init];
    l.frame = CGRectMake(0, 0, 100, 40);
    l.text = @"自定义视图";
    [v addSubview:l];
    
    UIImageView *iv = [[UIImageView alloc] init];
    iv.image = [UIImage imageNamed:@"3"];
    iv.frame = CGRectMake(100, 0, 40, 40);
    [v addSubview:iv];
    
    item2.assistCustomView = v;
    item2.assistCustomViewLayout = YQAssistCustomViewLayoutRightBottom;
    item2.operation = ^{
        
    };
    
    YQCommonItem *item3 = [YQCommonItem itemWithTitle:@"第三行第三行第三行" icon:@"2" arrow:YES hadBottomLine:YES];
    UISwitch *s = [[UISwitch alloc] init];
    s.frame = CGRectMake(0, 0, 100, 40);
    item3.assistCustomView = s;
    item3.assistCustomViewLayout = YQAssistCustomViewLayoutRight;
    item3.selectHighlight = NO;
    item3.operation = ^{
        
    };
    
    YQCommonItem *item4 = [YQCommonItem itemWithTitle:@"第四行" icon:@"3" arrow:YES hadBottomLine:YES];
    item4.assistImageURLStr = @"https://ss0.baidu.com/73F1bjeh1BF3odCf/it/u=2953611372,3247682668&fm=85&s=DCE02CC4015325CA441C3C3903001040";
    item4.destVcClass = [ViewController class];
    item4.hadBottomLine = NO;
    
    YQCommonItem *item5 = [YQCommonItem itemWithTitle:@"第五行" icon:@"2" arrow:NO hadBottomLine:YES];
    item5.bottomLineColor = [UIColor orangeColor];
    item5.bottomLineHeight = 10;
    item5.operation = ^{
        NSLog(@"--");
    };
    
    YQCommonItem *item6 = [YQCommonItem itemWithTitle:@"第六行" icon:@"2" arrow:NO hadBottomLine:YES];
    UIView *v2 = [[UIView alloc] init];
    v2.backgroundColor = [UIColor clearColor];
    v2.frame = CGRectMake(0, 0, 140, 40);
    v2.layer.cornerRadius = 4;
    
    UILabel *l2 = [[UILabel alloc] init];
    l2.frame = CGRectMake(0, 0, 100, 40);
    l2.text = @"自定义视图";
    [v2 addSubview:l2];
    
    UIImageView *iv2 = [[UIImageView alloc] init];
    iv2.image = [UIImage imageNamed:@"3"];
    iv2.frame = CGRectMake(100, 0, 40, 40);
    [v2 addSubview:iv2];
    
    item6.assistCustomView = v2;
    item6.assistCustomViewLayout = YQAssistCustomViewLayoutBottom;
    item6.cellBackgroudColor = [UIColor greenColor];
    item6.cellHeight = 130;
    item6.operation = ^{
        
    };
    
    
    YQCommonItem *item7 = [YQCommonItem itemWithTitle:@"第七行" icon:@"1" arrow:NO hadBottomLine:YES];
    UIView *v3 = [[UIView alloc] init];
    v3.backgroundColor = [UIColor blueColor];
    v3.frame = CGRectMake(0, 0, 30, 30);
    v3.layer.cornerRadius = 4;
    item7.assistCustomView = v3;
    item7.assistCustomViewLayout = YQAssistCustomViewLayoutLeft;
    item7.operation = ^{
        
    };
    
    
    YQCommonItem *item8 = [YQCommonItem itemWithTitle:@"第八行" icon:@"1" arrow:NO hadBottomLine:YES];
    UISlider *slider = [[UISlider alloc] init];
    slider.frame = CGRectMake(10, 10, 80, 30);
    item8.assistCustomView = slider;
    item8.assistCustomViewLayout = YQAssistCustomViewLayoutLeftBottom;
    item8.cellHeight = 80;
    item8.operation = ^{
        
    };
    
    
    YQCommonItem *item9 = [YQCommonItem itemWithTitle:@"第九行第九行" icon:@"1" arrow:NO hadBottomLine:YES];
    UISwitch *s2 = [[UISwitch alloc] init];
    s2.frame = CGRectMake(0, 0, 100, 40);
    item9.assistCustomView = s2;
    item9.assistCustomViewLayout = YQAssistCustomViewLayoutCenter;
    item9.operation = ^{
        
    };
    
    YQCommonGroup *group1 = [YQCommonGroup groupWithItems:@[item1, item2, item3]];
    UIView *redV = [[UIView alloc] init];
    redV.backgroundColor = [UIColor redColor];
    redV.frame = CGRectMake(0, 0, 300, 200);
    group1.headerView = redV;
    group1.footerTitle = @"group1.footerTitle";
    
    

    YQCommonGroup *group2 = [YQCommonGroup groupWithItems:@[item4, item5, item6]];
    UIView *blueV = [[UIView alloc] init];
    blueV.backgroundColor = [UIColor blueColor];
    blueV.frame = CGRectMake(0, 0, 300, 200);
    group2.headerView = blueV;
    
    group2.footerTitle = @"group2.footerTitle";
    group2.footerTitleHeight = 100;
    group2.footerTitleLayout = YQFooterTitleLayoutCenter;
    group2.footerTitleColor = [UIColor yellowColor];
    
    
    
    YQCommonGroup *group3 = [YQCommonGroup groupWithItems:@[item7, item8, item9]];
    group3.headerTitle = @"group3.headerTitle";
    group3.headerTitleLayout = YQHeaderTitleLayoutRight;
    group3.headerTitleFont = [UIFont systemFontOfSize:20];
    group3.footerTitle = @"group3.footerTitle";
    
    [self.commonGroups addObject:group1];
    [self.commonGroups addObject:group2];
    [self.commonGroups addObject:group3];
    
    [self.commonTableView reloadData];
}

@end
