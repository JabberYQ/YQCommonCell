# 前言

由于写了太多次的设置界面、个人中心界面等，已经写到麻木。渐渐意识到，或许可以把这些类似的TableViewCell封装成一种，通过简单的方法去创建以及使用，这样就可以大大减少劳动力啦。

在这篇文章之前，我已经写了一篇介绍`` YQCommonCell``的文章，但是因为更新的次数过多内容杂乱，我决定重新写一篇。

# 项目中的使用效果

很荣幸，在公司的项目中，已经使用了这个框架。的确，在开发表单视图上节约了大量时间。下面是两个项目中的效果图：

![项目效果1.PNG](http://upload-images.jianshu.io/upload_images/2312304-13cf390f1d5da146.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![项目效果2.PNG](http://upload-images.jianshu.io/upload_images/2312304-abc32c6ddb244f75.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


# 内部结构

![内部结构.png](http://upload-images.jianshu.io/upload_images/2312304-fa8a809415969628.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


其实这个项目的思路很容易理解，我将``UITableView``的数据源抽离成模型，``cell``对应``YQCommonItem``，``section``对应``YQCommonGroup``。在``YQCommonCell``类有``@property (nonatomic, strong) YQCommonItem *item;``属性。在``-(void)setItem:(YQCommonItem *)item``方法中进行属性设置，在``- (void)layoutSubviews``中布局界面。

# 能做的

这个框架几乎能解决所有的表单视图绘制。

## YQCommonItem的属性

### cell自身相关属性介绍

```objective-c
// cell 对应属性
YQPropStatementAndFuncStatement(assign,  YQCommonItem, BOOL,                         selectAbility) ///< cell能否被点击 default YES.
YQPropStatementAndFuncStatement(assign,  YQCommonItem, BOOL,                         selectHighlight) ///< cell被点击是否高亮 default YES.
YQPropStatementAndFuncStatement(assign,  YQCommonItem, BOOL,                         arrow) ///< 是否有箭头 default NO.
YQPropStatementAndFuncStatement(assign,  YQCommonItem, CGFloat,                      cellHeight) ///< cell的高度 default 44.
YQPropStatementAndFuncStatement(assign,  YQCommonItem, Class,                        destVcClass) ///< 点击后的跳转控制器 default nil.
YQPropStatementAndFuncStatement(strong,  YQCommonItem, UIColor *,                    cellBackgroudColor) ///< cell背景颜色 default [UIColor whiteColor].
YQPropStatementAndFuncStatement(copy,    YQCommonItem, YQCommonCellSelectBlock,      operation) ///< 点击后的跳转控制器 default nil.
```



### icon 和提醒红点相关属性介绍

```objective-c
// icon 对应属性
YQPropStatementAndFuncStatement(copy,    YQCommonItem, NSString *,                   icon) ///< 图标 default nil.
YQPropStatementAndFuncStatement(assign,  YQCommonItem, CGFloat,                      iconWidth) ///< 图标大小 default.

// badge 对应属性
YQPropStatementAndFuncStatement(copy,    YQCommonItem, NSString *,                   badgeValue) ///< 红点提醒 default nil.
YQPropStatementAndFuncStatement(assign,  YQCommonItem, YQBadgeViewLayout,            badgeLayout) ///< 红点提醒布局 default YQBadgeViewLayoutLeft.
```



效果：

![icon&badge.png](http://upload-images.jianshu.io/upload_images/2312304-ccad412b7e742966.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


### title相关属性介绍

```objective-c
// title 对应属性
YQPropStatementAndFuncStatement(copy,    YQCommonItem, NSString *,                   title) ///< 标题 default nil.
YQPropStatementAndFuncStatement(strong,  YQCommonItem, UIFont *,                     titleLableFont) ///< 标题font default [UIFont systemFontOfSize:16].
YQPropStatementAndFuncStatement(strong,  YQCommonItem, UIColor *,                    titleLableColor) ///< 标题color default [UIFont BlackColor].
YQPropStatementAndFuncStatement(copy,    YQCommonItem, NSAttributedString *,         attributedTitle) ///< 标题 default nil.
```

效果：

![title.png](http://upload-images.jianshu.io/upload_images/2312304-154afc473a2341fc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


### assistLabel相关属性介绍

```objective-c
// 辅助视图assistLabel 对应属性   NSAttributedString > NSString
YQPropStatementAndFuncStatement(copy,    YQCommonItem, NSString *,                   assistLabelText) ///< 标题 default nil. lable.textAlignment = NSTextAlignmentRight;
YQPropStatementAndFuncStatement(strong,  YQCommonItem, UIFont *,                     assistLabelFont) ///< 标题font default [UIFont systemFontOfSize:15].
YQPropStatementAndFuncStatement(strong,  YQCommonItem, UIColor *,                    assistLabelColor) ///< 标题color default [UIFont BlackColor].
YQPropStatementAndFuncStatement(copy,    YQCommonItem, NSAttributedString *,         assistLabelAttributedText) ///< 标题 default nil.
YQPropStatementAndFuncStatement(assign,  YQCommonItem, CGFloat,                      assistLabelX) ///< assistLabel X default 0. if>0 lable.textAlignment = NSTextAlignmentLeft;
```

效果：

![assistLabel.png](http://upload-images.jianshu.io/upload_images/2312304-79412a7c744e8fec.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### assistField相关属性展示

```objective-c
// 辅助视图textField 对应属性
YQPropStatementAndFuncStatement(copy,    YQCommonItem, NSString *,                   assistFieldText) ///< textField.text default nil. Field.textAlignment = NSTextAlignmentRight;
YQPropStatementAndFuncStatement(assign,  YQCommonItem, UIKeyboardType,               assistFieldKeyboardType) ///< textField.keyboardType
YQPropStatementAndFuncStatement(strong,  YQCommonItem, UIFont *,                     assistFieldFont) ///< textField.font [UIFont systemFontOfSize:15].
YQPropStatementAndFuncStatement(strong,  YQCommonItem, UIColor *,                    assistFieldColor) ///< textField.textColor default [UIFont BlackColor].
YQPropStatementAndFuncStatement(copy,    YQCommonItem, NSString *,                   assistFieldPlaceholderText) ///< textField.placeholder default nil.
YQPropStatementAndFuncStatement(strong,  YQCommonItem, UIColor *,                    assistFieldPlaceholderColor) ///< textField.placeholderTextColor
YQPropStatementAndFuncStatement(assign,  YQCommonItem, CGFloat,                      assistFieldX) ///< assistField X default 0. if>0 Field.textAlignment = NSTextAlignmentLeft;
YQPropStatementAndFuncStatement(copy,    YQCommonItem, YQCommonFieldTextChangeBlock, fieldTextChangeBlock)
YQPropStatementAndFuncStatement(copy,    YQCommonItem, YQCommonFieldEditFinishBlock, fieldEditFinishBlock)
```

效果：

![assistField.png](http://upload-images.jianshu.io/upload_images/2312304-f044ce5a51a89f5a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


### assistView相关属性展示

```
// 辅助视图自定义customview 对应属性
YQPropStatementAndFuncStatement(strong,  YQCommonItem, UIView *,                     assistCustomView) ///< CustomView default nil.
YQPropStatementAndFuncStatement(assign,  YQCommonItem, YQAssistCustomViewLayout,     assistCustomViewLayout) ///< CustomView Layout default YQAssistCustomViewLayoutRight
YQPropStatementAndFuncStatement(assign,  YQCommonItem, BOOL,                         assistCustomViewClipsToBounds) ///< CustomView ClipsToBounds default YES.
```

assistView相关的属性较少，但是这个属性却解决了绝大多数的复杂界面的绘制。

效果：
![assistView.png](http://upload-images.jianshu.io/upload_images/2312304-015f010f3144b7ef.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


### 其他属性展示

```objective-c
// 分割线 对应属性
YQPropStatementAndFuncStatement(assign,  YQCommonItem, BOOL,                         hadBottomLine) ///< BottomLine default YES.
YQPropStatementAndFuncStatement(strong,  YQCommonItem, UIColor *,                    bottomLineColor) ///< BottomLineColor default [UIColor colorWithWhite:0.85 alpha:0.6]
YQPropStatementAndFuncStatement(assign,  YQCommonItem, CGFloat,                      bottomLineHeight) ///< BottomLine default 1.0f.
YQPropStatementAndFuncStatement(assign,  YQCommonItem, CGFloat,                      bottomLineX) ///< BottomLine default line.x = titlelabel.x
```

## YQCommonGroup的属性

```
YQPropStatementAndFuncStatement(strong,  YQCommonGroup, NSArray *,           items)
YQPropStatementAndFuncStatement(assign,  YQCommonGroup, BOOL,                hiddenLastRowBottomLine) ///< hidden last row bottomLine default YES.

YQPropStatementAndFuncStatement(assign,  YQCommonGroup, CGFloat,             headerHeight) ///< default 20.
YQPropStatementAndFuncStatement(copy,    YQCommonGroup, NSString *,          headerTitle) ///< default nil.
YQPropStatementAndFuncStatement(strong,  YQCommonGroup, UIColor *,           headerTitleColor) ///< default [UIColor grayColor].
YQPropStatementAndFuncStatement(strong,  YQCommonGroup, UIFont *,           headerTitleFont) ///< default [UIFont systemFontOfSize:16].
YQPropStatementAndFuncStatement(assign,  YQCommonGroup, CGFloat,             headerTitleHeight) ///< default 50.
YQPropStatementAndFuncStatement(assign,  YQCommonGroup, YQHeaderTitleLayout, headerTitleLayout) ///< default YQHeaderTitleLayoutLeft.
YQPropStatementAndFuncStatement(strong,  YQCommonGroup, UIView *,            headerView) ///< default nil.


YQPropStatementAndFuncStatement(assign,  YQCommonGroup, CGFloat,             footerHeight) ///< default 0.01.
YQPropStatementAndFuncStatement(copy,    YQCommonGroup, NSString *,          footerTitle) ///< default nil.
YQPropStatementAndFuncStatement(strong,  YQCommonGroup, UIColor *,           footerTitleColor) ///< default [UIColor grayColor].
YQPropStatementAndFuncStatement(strong,  YQCommonGroup, UIFont *,           footerTitleFont) ///< default [UIFont systemFontOfSize:16].
YQPropStatementAndFuncStatement(assign,  YQCommonGroup, CGFloat,             footerTitleHeight) ///< default 50.
YQPropStatementAndFuncStatement(assign,  YQCommonGroup, YQFooterTitleLayout, footerTitleLayout) ///< default YQFooterTitleLayoutLeft.
YQPropStatementAndFuncStatement(strong,  YQCommonGroup, UIView *,            footerView) ///< default nil.
```

正如上文所说，``YQCommonGroup``对应的是``tableview``的``Section``，因此它的属性都与``Section``相关。

其中需要注意的是``hiddenLastRowBottomLine``属性，默认开启，会隐藏每个``Section``最后一行``cell``的分割线。

效果：

![其他效果.gif](http://upload-images.jianshu.io/upload_images/2312304-1f4f9e2406638e86.gif?imageMogr2/auto-orient/strip)


# 如何使用

```
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
```

以demo中的``MainViewContoller``为例，``tableview``的数据源与代理方法我都用宏写入``YQCommonMacro``中。设置cell的属性全在``- (void)setData``方法中实现。

效果:

![Main.png](http://upload-images.jianshu.io/upload_images/2312304-e2818118535d054b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


至于其他效果的实现，可下载demo了解。

# 博客地址
[jabberyq 自造轮子：YQCommonCell 简化表单视图开发](https://jabberyq.github.io/2018/03/06/%E8%87%AA%E9%80%A0%E8%BD%AE%E5%AD%90%EF%BC%9AYQCommonCell%E3%80%81%E7%AE%80%E5%8C%96%E8%A1%A8%E5%8D%95%E8%A7%86%E5%9B%BE%E5%BC%80%E5%8F%91/)

# 下载
[GitHub:YQCommonCell](https://github.com/JabberYQ/YQCommonCell)
