//
//  YQCommonMacro.h
//  YQCommonCell
//
//  Created by easylink on 2018/3/2.
//  Copyright © 2018年 YuQi. All rights reserved.
//

#ifndef YQCommonMacro_h
#define YQCommonMacro_h

#define YQObjectInit(objectName) [[objectName alloc] init]

#define YQPropStatementAndFuncStatement(propertyModifyWord, className, propertyPointerType, propertyName)                \
@property(nonatomic,propertyModifyWord)propertyPointerType  propertyName;                                               \
- (className * (^) (propertyPointerType propertyName)) propertyName##Set;

#define YQPropSetFuncImplementation(className, propertyPointerType, propertyName)                                       \
- (className * (^) (propertyPointerType propertyName))propertyName##Set{                                                \
return ^(propertyPointerType propertyName) {                                                                            \
self.propertyName = propertyName;                                                                                       \
return self;                                                                                                            \
};                                                                                                                      \
}

#define YQiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define YQIndicatorHeight (YQiPhoneX ?34:0)
#define YQStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height
#define YQNavBarHeight self.navigationController.navigationBar.frame.size.height
#define YQTableViewY ((self.navigationController && self.navigationController.navigationBar.hidden == NO) ? YQStatusBarHeight+YQNavBarHeight : YQStatusBarHeight)
#define YQNewAdjustsScrollViewInsets(scrollView)\
if (@available(iOS 11.0, *)) {\
scrollView.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;\
}else {\
self.automaticallyAdjustsScrollViewInsets = NO;\
}\

#define YQTabelViewDelegateAndDataSource(commonGroups)\
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath\
{\
    YQCommonGroup *group = commonGroups[indexPath.section];\
    YQCommonItem *item = group.items[indexPath.row];\
    return item.cellHeight;\
}\
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView\
{\
    return commonGroups.count;\
}\
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section\
{\
    YQCommonGroup *group = commonGroups[section];\
    return group.items.count;\
}\
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath\
{\
    YQCommonCell *cell = [YQCommonCell cellWithTableView:tableView];\
    YQCommonGroup *group = commonGroups[indexPath.section];\
    cell.item = group.items[indexPath.row];\
    return cell;\
}\
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath\
{\
    [tableView deselectRowAtIndexPath:indexPath animated:YES];\
\
    YQCommonGroup *group = commonGroups[indexPath.section];\
    YQCommonItem *item = group.items[indexPath.row];\
\
    if (item.destVcClass) {\
        [self presentViewController:[[item.destVcClass alloc] init] animated:YES completion:nil];\
    }\
\
    if (item.operation) {\
        item.operation();\
    }\
}\
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section\
{\
    YQCommonGroup *group = commonGroups[section];\
    return group.headerView ? group.headerView.bounds.size.height : group.headerHeight;\
}\
\
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section\
{\
    YQCommonGroup *group = commonGroups[section];\
    return group.footerView ? group.footerView.bounds.size.height : group.footerHeight;\
}\
\
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section\
{\
    YQCommonGroup *group = commonGroups[section];\
    return group.headerView ? group.headerView : [[UIView alloc] init];\
}\
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section\
{\
    YQCommonGroup *group = commonGroups[section];\
    return group.footerView ? group.footerView : [[UIView alloc] init];\
}

#endif /* YQCommonMacro_h */
