//
//  YQCommonCell.h
//  YQCommonCell
//
//  Created by 俞琦 on 2017/8/28.
//  Copyright © 2017年 俞琦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQCommonItem.h"

@interface YQCommonCell : UITableViewCell
@property (nonatomic, strong) YQCommonItem *item;

/**
 初始化一个cell

 @param tableView tableView
 @return cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
