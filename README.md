# YQCommonCell
轻松设置cell的样式
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
# 简书地址
http://www.jianshu.com/p/e946ee333ccd

