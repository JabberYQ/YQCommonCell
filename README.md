
# 前言&效果
由于写了太多次的设置界面、个人中心界面等，已经写到麻木。渐渐意识到，或许可以把这些类似的TableViewCell封装成一种，通过简单的方法去创建以及使用，这样就可以大大减少劳动力啦。
然后我花了一下午的时间开始试着封装，下面是最终实现的效果：

![效果动图.gif](http://upload-images.jianshu.io/upload_images/2312304-c4055f83d4fdf9ab.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

# 内部结构
下面为内部文件：

![内部文件.png](http://upload-images.jianshu.io/upload_images/2312304-fa838b1bb68e27f5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

至于内部的结构如何，我放部分代码你就会立马了解。
```
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
```
上述代码中，groups为ViewController的属性：
``@property (nonatomic, strong) NSMutableArray *groups;``
groups数组中存放一个个YQCommonGroup对象。
YQCommonGroup头文件如下：

![Group头文件.png](http://upload-images.jianshu.io/upload_images/2312304-49611191b00d7dc8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

YQCommonGroup对象有items属性，items内部放

以下面的图为例：

![关系图.png](http://upload-images.jianshu.io/upload_images/2312304-910bbccb83c89501.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

上图ViewController有groups属性，里面存在两个Groups对象，也就是说，对应的tableview有两个Section。
Groups对象1有一个items属性，items由item1和item2组成，也就是说，对应第一个Section有两行。而每一行的数据以及内部组件排布，都由item来决定。
emmm，婆婆妈妈终于把结构关系说清楚了。

# 创建groups
如果闲麻烦，可以通过懒加载的方式去创建groups。下面为我这个demo的数据源数据：
```
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
```
可以看到，我为了凸显功能繁多，设置的乱七八糟了。。。
如果对于这些item属性有疑惑，请继续往下看。
# item能做的功能
## 一、公开属性：
下面为item的公开属性
```
/************************************ cell 数据源 *************************************/
/** 图标 */
@property (nonatomic, copy) NSString *icon;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 是否有箭头 默认为NO */
@property (nonatomic, assign, getter=isArrow) BOOL arrow;
/** 是否有全屏的分割线 默认为NO */
@property (nonatomic, assign, getter=isScreenSeparator) BOOL screenSeparator;
/** 辅助图片本地Str */
@property (nonatomic, copy) NSString *assistImageFileStr;
/** 辅助图片网络Str */
@property (nonatomic, copy) NSString *assistImageURLStr;
/** 辅助信息 */
@property (nonatomic, copy) NSString *assistLabelText;
/* assistFieldText 与 assistFieldPlaceholderText 的区别在于前者为field.text属性 后者为field.placeholder属性 */
/** 辅助textField */
@property (nonatomic, copy) NSString *assistFieldText;
/** 辅助textField 的 placeholder */
@property (nonatomic, copy) NSString *assistFieldPlaceholderText;
/** 右边显示的数字标记 */
@property (nonatomic, copy) NSString *badgeValue;
/** block 只能用 copy */
@property (nonatomic, copy) void (^operation)(void);
/** 点击这行cell需要跳转到哪个控制器 */
@property (nonatomic, assign) Class destVcClass;

/************************************ cell 内部控件配置 *************************************/

/** 图标大小 默认系统大小 */
@property (nonatomic, assign) CGFloat iconWidth;
/** 辅助图像大小 默认30 */
@property (nonatomic, assign) CGFloat assistImageWidth;
/** 辅助图像圆角化 默认不处理 */
@property (nonatomic, assign) CGFloat assistImageCornerRadius;
/** 标题字体大小 默认16 */
@property (nonatomic, strong) UIFont *titleLableFont;
/** 标题颜色 默认黑色 */
@property (nonatomic, strong) UIColor *titleLableColor;
/** 辅助字体大小 默认15 */
@property (nonatomic, strong) UIFont *assistLabelFont;
/** 辅助颜色 默认grayColor */
@property (nonatomic, strong) UIColor *assistLabelColor;
```
## 二、能做的：
### 基础功能：
1.设置图标 ``NSString *icon; ``
2.设置标题``NSString *title; ``
3.设置是否有箭头 默认为NO ``BOOL arrow ``
4.设置cell底部是否有全屏的分割线 默认为NO``BOOL screenSeparator ``
5.设置提醒红点 ``NSString *badgeValue; ``

### 添加辅助控件功能：
1.添加一个UILabel并设置文字 ``NSString *assistLabelText; ``
2.添加一个Field并设置文字 ``NSString *assistFieldText; ``
3.添加一个Field并设置提示字 ``NSString *assistFieldPlaceholderText; ``
4.添加一个imageView，图片来自本地 `` NSString *assistImageFileStr;``
5.添加一个imageView，图片来自网络 `` NSString *assistImageURLStr;``

### 设置部分控件样式
1.图标大小 默认系统大小 `` CGFloat iconWidth;``
2.辅助图像大小 默认30宽 ``CGFloat assistImageWidth; ``
3.辅助图像圆角化 默认不处理 ``assistImageCornerRadius ``
4.标题字体大小 默认加粗16`` UIFont *titleLableFont;``
5.标题颜色 默认黑色``UIColor *titleLableColor; ``
6.辅助字体大小 默认15``UIFont *assistLabelFont;``
7.辅助颜色 默认grayColor``UIColor *assistLabelColor;``

### 响应属性
1.点击cell会调用 ``void (^operation)(void); ``
2.为了方便，如果只是简单跳转，可以设置目的控制器类而不需要设置operation ``Class destVcClass;``

## 三、初始化类方法
下面为提供的简单初始化类方法：
```
/**
 初始化一个item

 @param title 标题
 @param icon 图标
 @return item
 */
+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;


/**
 初始化一个item

 @param title 标题
 @param icon 图标
 @param arrow 是否存在跳转箭头
 @return item
 */
+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon arrow:(BOOL)arrow;


/**
 初始化一个item
 
 @param title 标题
 @param icon 图标
 @param arrow 是否存在跳转箭头
 @param screenSeparator 是否有全屏分割线
 @return item
 */
+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon arrow:(BOOL)arrow screenSeparator:(BOOL)screenSeparator;
```
## 四、具体举例：
### A

![屏幕快照 2017-12-06 下午5.34.45.png](http://upload-images.jianshu.io/upload_images/2312304-098c53e2e24d6063.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
```
YQCommonItem *item1 = [YQCommonItem itemWithTitle:@"第一行" icon:@"0" arrow:YES screenSeparator:YES];
item1.badgeValue = @"2"; item1.assistLabelText = @"第一行第一行";
item1.operation = ^{
            
};
```
### B

![屏幕快照 2017-12-06 下午5.38.08.png](http://upload-images.jianshu.io/upload_images/2312304-47929e6a7ba12974.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
```
YQCommonItem *item4 = [YQCommonItem itemWithTitle:@"第四行" icon:@"3" arrow:YES screenSeparator:YES];
item4.assistImageURLStr = @"https://ss0.baidu.com/73F1bjeh1BF3odCf/it/u=2953611372,3247682668&fm=85&s=DCE02CC4015325CA441C3C3903001040";
item4.destVcClass = [ViewController class];
```
### C

![屏幕快照 2017-12-06 下午5.38.29.png](http://upload-images.jianshu.io/upload_images/2312304-fbde1a3ea247bfc4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
```
YQCommonItem *item5 = [YQCommonItem itemWithTitle:@"第五行" icon:@"2" arrow:NO screenSeparator:YES];
item5.iconWidth = 100;
item5.assistLabelText = @"第五行第五行";
item5.operation = ^{
     NSLog(@"--");
};
```
# 更新 添加了部分新属性（17.12.07）
### 更新内容一：可添加自定义视图
```
/** 辅助自定义视图 */
@property (nonatomic, strong) UIView *assistCustomView;
```
该属性指向的视图默认放的位置为cell的最右侧位置。
可通过以下属性重新设置位置：
```
/** 辅助自定义视图的位置 默认靠右  */
@property (nonatomic, assign) YQAssistCustomViewLayout assistCustomViewLayout;
```
该属性为枚举，可设置的类型一共有九种，包括上中，上右，上左，中中等。
使用：
```
        YQCommonItem *item2 = [YQCommonItem itemWithTitle:@"第二行第二行" icon:@"1" arrow:NO screenSeparator:YES];
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
        item2.assistCustomViewLayout = YQAssistCustomViewLayoutTop;
        item2.operation = ^{
            
        };
```
效果：

![更新效果1.png](http://upload-images.jianshu.io/upload_images/2312304-8d5a90da4855f7ce.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

或者把`` item2.assistCustomViewLayout = YQAssistCustomViewLayoutRightBottom;``
效果：

![屏幕快照 2017-12-07 下午3.15.50.png](http://upload-images.jianshu.io/upload_images/2312304-2b81a7e09d9a81e7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 更新内容二：可设置cell能否被点击
```
/** cell能否被点击 默认YES */
@property (nonatomic, assign, getter=isSelectAbility) BOOL selectAbility;
```
### 更新内容三：可设置cell点击是否高亮
```
/** cell被点击是否高亮 默认YES */
@property (nonatomic, assign, getter=isSelectHighlight) BOOL selectHighlight;
```
# 更新 添加了父类控制器等（17.12.12）
### 更新内容一：添加了父类控制器
添加了父类控制器：``YQCommonViewController``。
![YQCommonViewController声明.png](http://upload-images.jianshu.io/upload_images/2312304-68e7b3cdd0032b0b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

当需要创建表单视图时，创建一个继承``YQCommonViewController``的控制器，设置``commonGroups ``属性，刷新`` commonTableView``即可。

### 更新内容二：可自定义表单的头视图和尾视图
添加了``YQCommonGroup``的部分属性：
```
typedef NS_ENUM(NSInteger, YQHeaderTitleLayout)
{
    YQHeaderTitleLayoutLeft = 0,
    YQHeaderTitleLayoutCenter = 1,
    YQHeaderTitleLayoutRight = 2,
};

typedef NS_ENUM(NSInteger, YQFooterTitleLayout)
{
    YQFooterTitleLayoutLeft = 0,
    YQFooterTitleLayoutCenter = 1,
    YQFooterTitleLayoutRight = 2,
};


@interface YQCommonGroup : NSObject
/** 每个Section内部内容 */
@property (nonatomic, strong) NSArray *items;

/** Section Header高 默认40 如果设置了Header标题或者HeaderView自定义，该属性无效，以试图的高为准*/
@property (nonatomic, assign) CGFloat headerHeight;
/** Section Header标题 */
@property (nonatomic, copy) NSString *headerTitle;
/** Section Header标题颜色 默认灰色*/
@property (nonatomic, strong) UIColor *headerTitleColor;
/** Section Header标题大小 默认16*/
@property (nonatomic, strong) UIFont *headerTitleFont;
/** Section Header标题高度 默认50*/
@property (nonatomic, assign) CGFloat headerTitleHeight;
/** Section Header标题位置 默认居左*/
@property (nonatomic, assign) YQHeaderTitleLayout headerTitleLayout;
/** Section HeaderView自定义 */
@property (nonatomic, strong) UIView *headerView;

/** Section Footer高 默认0.01 如果设置了Footer标题或者FooterView自定义，该属性无效，以试图的高为准*/
@property (nonatomic, assign) CGFloat footerHeight;
/** Section Footer标题 */
@property (nonatomic, copy) NSString *footerTitle;
/** Section Footer标题颜色 默认灰色*/
@property (nonatomic, strong) UIColor *footerTitleColor;
/** Section Footer标题大小 默认16*/
@property (nonatomic, strong) UIFont *footerTitleFont;
/** Section Footer标题高度 默认50*/
@property (nonatomic, assign) CGFloat footerTitleHeight;
/** Section Footer标题位置 默认居左*/
@property (nonatomic, assign) YQFooterTitleLayout footerTitleLayout;
/** Section FooterView */
@property (nonatomic, strong) UIView *footerView;
```
使用：
![使用1.png](http://upload-images.jianshu.io/upload_images/2312304-0bdd0d5014cb2827.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![效果1.png](http://upload-images.jianshu.io/upload_images/2312304-d1609958606c3dd8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![使用2.png](http://upload-images.jianshu.io/upload_images/2312304-1623997e95e3ffad.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![效果2.png](http://upload-images.jianshu.io/upload_images/2312304-b194078bd4edfbfb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![使用3.png](http://upload-images.jianshu.io/upload_images/2312304-34beabfab97356f6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![效果3.png](http://upload-images.jianshu.io/upload_images/2312304-1922eba162a6ec39.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

# 更新 自定义分割线（17.12.13）
由于存在分割线的可调整性不够的问题，我添加了部分属性来自定义分割线。
### 添加
```
// YQCommonItem
/** 分割线颜色 默认[UIColor colorWithWhite:0.85 alpha:0.6] */
@property (nonatomic, strong) UIColor *bottomLineColor;
/** 分割线高度  默认1*/
@property (nonatomic, assign) CGFloat bottomLineHeight;
/** 分割线X 默认和cell的textlabel平齐*/
@property (nonatomic, assign) CGFloat bottomLineX;
```
```
// YQCommonGroup
/** Section最后一行row隐藏分割线 默认开启*/
@property (nonatomic, assign) BOOL hiddenLastRowBottomLine;
```
### 修改一
```
/** 是否有分割线 默认为YES */
@property (nonatomic, assign, getter=isHadBottomLine) BOOL hadBottomLine;
```
```
/**
 初始化一个item
 
 @param title 标题
 @param icon 图标
 @param arrow 是否存在跳转箭头
 @param hadBottomLine 是否有分割线
 @return item
 */
+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon arrow:(BOOL)arrow hadBottomLine:(BOOL)hadBottomLine;
```
之前版本的分割线为写死的，要么全屏，要么无分割线。
这次版本可以自定义风格线的位置，颜色。同时，考虑到section的最后一行可能不需要分割线，因此默认将最后一行的分割线隐藏。

### 修改二
在``YQCommonViewController ``中重写了tableview的frame，会随着navbar的存在与否改变。
```
    CGFloat StatusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat NavBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat tableViewY;
    if (self.navigationController && self.navigationController.navigationBar.hidden == NO) {
        tableViewY = StatusBarHeight + NavBarHeight;
    } else {
        tableViewY = StatusBarHeight;
    }
    
    self.commonTableView.frame = CGRectMake(0, tableViewY, self.view.bounds.size.width, self.view.bounds.size.height - tableViewY);
    if (@available(iOS 11.0, *)) {
        self.commonTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
```

### 效果：
![效果动图.gif](http://upload-images.jianshu.io/upload_images/2312304-11dfd44388e43834.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

# 博客地址
[自造轮子：表单视图，为所欲为](https://jabberyq.github.io/2017/12/06/%E8%87%AA%E9%80%A0%E8%BD%AE%E5%AD%90%EF%BC%9A%E8%A1%A8%E5%8D%95%E8%A7%86%E5%9B%BE%EF%BC%8C%E4%B8%BA%E6%89%80%E6%AC%B2%E4%B8%BA/)

