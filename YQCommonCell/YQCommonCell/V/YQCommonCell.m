//
//  YQCommonCell.m
//  YQCommonCell
//
//  Created by 俞琦 on 2017/8/28.
//  Copyright © 2017年 俞琦. All rights reserved.
//

#import "YQCommonCell.h"
#import "YQBadgeView.h"
#import "AppDelegate.h"

// 存在优先级问题
/*
 当item的辅助属性：同时设置的时候，显示的优先级为
 Custom >> Label >> Field
 */
typedef NS_ENUM(NSInteger, YQCommonCellAssistType)
{
    YQCommonCellAssistTypeNone = 0,
    YQCommonCellAssistTypeCustom = 1,
    YQCommonCellAssistTypeLabel = 2,
    YQCommonCellAssistTypeField = 3,
};

@interface YQCommonCell() <UITextFieldDelegate>
@property (nonatomic, strong) UILabel *assistLabel; ///< 辅助信息lable
@property (nonatomic, strong) UITextField *assistTextField; ///< 辅助UITextField
@property (nonatomic, strong) UIView *assistCustomView; ///< 辅助自定义视图
@property (nonatomic, strong) YQBadgeView *badgeView; ///< 提醒按钮
@property (nonatomic, strong) UIView *bottomLine; ///<分割线

@property (nonatomic, assign) YQCommonCellAssistType assistType;
@end

@implementation YQCommonCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"CommonCell";
    YQCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YQCommonCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.assistCustomView];
        [self.contentView addSubview:self.assistLabel];
        [self.contentView addSubview:self.assistTextFile];
        [self.contentView addSubview:self.badgeView];
        [self.contentView addSubview:self.bottomLine];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 除了底部线条 所有的界面都与contentView相关
    CGFloat cellWidth = self.contentView.bounds.size.width;
    CGFloat cellHeight = self.contentView.bounds.size.height;
    CGFloat textLabelRight = CGRectGetMaxX(self.textLabel.frame);
    CGFloat badgeMargin = 10.f;
    CGFloat badgeWidth = 20.f;
    CGFloat assistViewRightToCell = self.item.arrow ? 5.f : 15.f;
    CGFloat assistViewMaxLeft = 0.f;
    
    // 设置分割线
    if (!self.bottomLine.hidden) {
        CGFloat bottomLineX = self.item.bottomLineX < 0 ? self.textLabel.frame.origin.x : self.item.bottomLineX;
        self.bottomLine.frame = CGRectMake(bottomLineX, cellHeight - self.item.bottomLineHeight, self.bounds.size.width - bottomLineX, self.item.bottomLineHeight);
    }
    
    // 设置小红点
    if (!self.badgeView.hidden) {
        if (self.item.badgeLayout == YQBadgeViewLayoutLeft) { // 局左
            self.badgeView.frame = CGRectMake(textLabelRight + badgeMargin, (cellHeight - badgeWidth)/2, badgeWidth, badgeWidth);
            assistViewMaxLeft = CGRectGetMaxX(self.badgeView.frame);
        } else { // 局右
            self.badgeView.frame = CGRectMake(cellWidth - assistViewRightToCell - badgeWidth, (cellHeight - badgeWidth)/2, badgeWidth, badgeWidth);
            assistViewMaxLeft = textLabelRight;
            assistViewRightToCell = assistViewRightToCell + badgeWidth + badgeMargin;
        }
    } else {
        self.badgeView.frame = CGRectZero;
        assistViewMaxLeft = textLabelRight;
    }
    
    CGFloat maxAssistWidth = cellWidth - assistViewMaxLeft - assistViewRightToCell; // 最大的宽
    
    /******************************* 辅助不部分 (需考虑优先级)******************************/
    switch (self.assistType) {
        case YQCommonCellAssistTypeNone:
        {
            self.assistCustomView.frame = CGRectZero;
            self.assistLabel.frame = CGRectZero;
            self.assistTextField.frame = CGRectZero;
            break;
        }
        case YQCommonCellAssistTypeCustom:
        {
            self.assistCustomView.frame = CGRectMake(cellWidth - assistViewRightToCell - maxAssistWidth, 0, maxAssistWidth, self.bounds.size.height);
            [self layoutCustomViewSubview];
            self.assistLabel.frame = CGRectZero;
            self.assistTextField.frame = CGRectZero;
            break;
        }
        case YQCommonCellAssistTypeLabel:
        {
            self.assistCustomView.frame = CGRectZero;
            CGSize size = [self.assistLabel.text boundingRectWithSize:CGSizeMake(maxAssistWidth, CGFLOAT_MAX)
                                                              options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                                           attributes:@{NSFontAttributeName:self.assistLabel.font}
                                                              context:nil].size;
            if (self.item.assistLabelX <= 0) {
                self.assistLabel.frame = CGRectMake(cellWidth - assistViewRightToCell - size.width, 0, size.width, cellHeight);
            } else {
                self.assistLabel.frame = CGRectMake(self.item.assistLabelX, 0, size.width, cellHeight);
            }
            self.assistTextField.frame = CGRectZero;
            break;
        }
        case YQCommonCellAssistTypeField:
        {
            self.assistCustomView.frame = CGRectZero;
            self.assistLabel.frame = CGRectZero;
            if (self.item.assistFieldX <= 0) {
                self.assistTextFile.frame = CGRectMake(cellWidth - assistViewRightToCell - maxAssistWidth, 0, maxAssistWidth, self.bounds.size.height);
            } else {
                CGFloat assistTextFileW = cellWidth - assistViewRightToCell - self.item.assistFieldX;
                self.assistTextFile.frame = CGRectMake(self.item.assistFieldX, 0, assistTextFileW, self.bounds.size.height);
            }
            
            break;
        }
        default:
            break;
    }
    
}

- (void)layoutCustomViewSubview
{
    UIView *subView = self.item.assistCustomView;
    UIView *assistCustomView = self.assistCustomView;
    
    // cell上的
    CGFloat assistCustomViewW = assistCustomView.bounds.size.width;
    CGFloat assistCustomViewH = assistCustomView.bounds.size.height;
    
    // 传入的
    CGFloat subViewW = subView.bounds.size.width;
    CGFloat subViewH = subView.bounds.size.height;
    
    BOOL isExceedMaxSize;
    if (assistCustomViewW < subViewW || assistCustomViewH < subViewH) { // 设置的自定义视图超过了最大的尺寸
        subView.frame = CGRectMake(0, 0, subViewW, subViewH);
        isExceedMaxSize = YES;
    } else {
        isExceedMaxSize = NO;
    }
    
    switch (self.item.assistCustomViewLayout) {
        case YQAssistCustomViewLayoutRight:
        {
            CGFloat subViewX = assistCustomViewW - subViewW;
            CGFloat subViewY = (assistCustomViewH - subViewH)/2;
            subView.frame = CGRectMake(subViewX, subViewY, subViewW, subViewH);
            break;
        }
        case YQAssistCustomViewLayoutRightBottom:
        {
            CGFloat subViewX = assistCustomViewW - subViewW;
            CGFloat subViewY = assistCustomViewH - subViewH;
            subView.frame = CGRectMake(subViewX, subViewY, subViewW, subViewH);
            break;
        }
        case YQAssistCustomViewLayoutBottom:
        {
            CGFloat subViewX = (assistCustomViewW - subViewW)/2;
            CGFloat subViewY = assistCustomViewH - subViewH;
            subView.frame = CGRectMake(subViewX, subViewY, subViewW, subViewH);
            break;
        }
        case YQAssistCustomViewLayoutLeftBottom:
        {
            CGFloat subViewX = 0;
            CGFloat subViewY = assistCustomViewH - subViewH;
            subView.frame = CGRectMake(subViewX, subViewY, subViewW, subViewH);
            break;
        }
        case YQAssistCustomViewLayoutLeft:
        {
            CGFloat subViewX = 0;
            CGFloat subViewY = (assistCustomViewH - subViewH)/2;
            subView.frame = CGRectMake(subViewX, subViewY, subViewW, subViewH);
            break;
        }
        case YQAssistCustomViewLayoutLeftTop:
        {
            CGFloat subViewX = 0;
            CGFloat subViewY = 0;
            subView.frame = CGRectMake(subViewX, subViewY, subViewW, subViewH);
            break;
        }
        case YQAssistCustomViewLayoutTop:
        {
            CGFloat subViewX = (assistCustomViewW - subViewW)/2;
            CGFloat subViewY = 0;
            subView.frame = CGRectMake(subViewX, subViewY, subViewW, subViewH);
            break;
        }
        case YQAssistCustomViewLayoutRightTop:
        {
            CGFloat subViewX = assistCustomViewW - subViewW;
            CGFloat subViewY = 0;
            subView.frame = CGRectMake(subViewX, subViewY, subViewW, subViewH);
            break;
        }
        case YQAssistCustomViewLayoutCenter:
        {
            CGFloat subViewX = (assistCustomViewW - subViewW)/2;
            CGFloat subViewY = (assistCustomViewH - subViewH)/2;
            subView.frame = CGRectMake(subViewX, subViewY, subViewW, subViewH);
            break;
        }
        default:
            break;
    }
    
    assistCustomView.clipsToBounds = self.item.assistCustomViewClipsToBounds;
}

#pragma mark - settingInfo
- (void)setCellResponse
{
    self.userInteractionEnabled = self.item.selectAbility;
    if (self.item.selectHighlight == NO) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    } else {
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
}

- (void)setCellStyle
{
    self.contentView.backgroundColor = self.item.cellBackgroudColor;
    self.backgroundColor = self.item.cellBackgroudColor;
    if (!self.item.attributedTitle) { // 设置标题
        self.textLabel.font = self.item.titleLableFont;
        self.textLabel.textColor = self.item.titleLableColor;
    }
    self.bottomLine.backgroundColor = self.item.bottomLineColor;
    
    if (!self.item.assistLabelAttributedText) {
        if (self.item.assistLabelX <= 0) {
            self.assistLabel.textAlignment = NSTextAlignmentRight;
        } else {
            self.assistLabel.textAlignment = NSTextAlignmentLeft;
        }
        self.assistLabel.font = self.item.assistLabelFont;
        self.assistLabel.textColor = self.item.assistLabelColor;
    }
    
    self.assistTextField.font = self.item.assistFieldFont;
    self.assistTextField.textColor = self.item.assistFieldColor;
    self.assistTextField.keyboardType = self.item.assistFieldKeyboardType;
    if (self.item.assistFieldX <= 0) {
        self.assistTextField.textAlignment = NSTextAlignmentRight;
    } else {
        self.assistTextField.textAlignment = NSTextAlignmentLeft;
    }
    
    if (self.item.iconWidth > 0) {
        UIImage *iconImage = self.imageView.image;
        CGSize iconSize = CGSizeMake(self.item.iconWidth, self.item.iconWidth);
        UIGraphicsBeginImageContextWithOptions(iconSize, NO, 0.0);
        CGRect imageRect = CGRectMake(0.0, 0.0, iconSize.width, iconSize.height);
        [iconImage drawInRect:imageRect];
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
}

- (void)setCellData
{
    // 图片
    self.imageView.image = [UIImage imageNamed:self.item.icon];
    self.textLabel.text = nil;
    self.textLabel.attributedText = nil;
    
    // textLabel
    if (self.item.attributedTitle) {
        self.textLabel.attributedText = self.item.attributedTitle;
    } else {
        self.textLabel.text = self.item.title;
    }
    
    if (self.item.hadBottomLine) {
        self.bottomLine.hidden = NO;
    } else {
        self.bottomLine.hidden = YES;
    }
    
    // 设置红点提醒
    if (self.item.badgeValue && self.item.badgeValue.integerValue > 0) {
        self.badgeView.hidden = NO;
        self.badgeView.badgeValue = self.item.badgeValue;
    } else {
        self.badgeView.hidden = YES;
    }
    
    // 设置跳转箭头
    if (self.item.arrow) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    
    /******************************* 辅助不部分 (需考虑优先级)******************************/
    // 辅助自定义视图
    if (self.item.assistCustomView) {
        self.assistCustomView.hidden = NO;
        [self.assistCustomView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.assistCustomView addSubview:self.item.assistCustomView];
        self.assistType = YQCommonCellAssistTypeCustom;
        return;
    } else {
        self.assistCustomView.hidden = YES;
    }
    
    // 辅助label
    if ((self.item.assistLabelText && self.item.assistLabelText.length > 0) || (self.item.assistLabelAttributedText)) {
        self.assistLabel.hidden = NO;
        if (self.item.assistLabelAttributedText) {
            self.assistLabel.attributedText = self.item.assistLabelAttributedText;
        } else {
            self.assistLabel.text = self.item.assistLabelText;
        }
        self.assistType = YQCommonCellAssistTypeLabel;
        return;
    } else {
        self.assistLabel.hidden = YES;
    }
    
    // 辅助输入框
    if ((self.item.assistFieldText && self.item.assistFieldText.length > 0) || (self.item.assistFieldPlaceholderText && self.item.assistFieldPlaceholderText.length > 0)) {
        self.assistTextField.hidden = NO;
        self.assistTextField.text = self.item.assistFieldText;
        // 判断是否设置了placeholder 的颜色
        if (self.item.assistFieldPlaceholderColor) {
            NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.item.assistFieldPlaceholderText attributes:@{NSForegroundColorAttributeName:self.item.assistFieldPlaceholderColor}];
            self.assistTextField.attributedPlaceholder = attrString;
        } else {
            self.assistTextField.placeholder = self.item.assistFieldPlaceholderText;
        }
        self.assistType = YQCommonCellAssistTypeField;
        return;
    } else {
        self.assistTextField.hidden = YES;
    }
    
    self.assistType = YQCommonCellAssistTypeNone;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.item.fieldEditFinishBlock) {
        return self.item.fieldEditFinishBlock(textField.text);
    } else {
        return YES;
    }
}


- (void)assistTextFieldTextChange:(UITextField *)textField
{
    if (self.item.fieldTextChangeBlock) {
        self.item.fieldTextChangeBlock(textField.text);
    }
}
#pragma mark - setter
- (void)setItem:(YQCommonItem *)item
{
    _item = item;
    
    [self setCellData];
    
    [self setCellStyle];
    
    [self setCellResponse];
}

#pragma mark - getter
- (UILabel *)assistLabel
{
    if (_assistLabel == nil) {
        _assistLabel = [[UILabel alloc] init];
        _assistLabel.hidden = YES;
    }
    return _assistLabel;
}


- (UITextField *)assistTextFile
{
    if (_assistTextField == nil) {
        _assistTextField = [[UITextField alloc] init];
        _assistTextField.hidden = YES;
        _assistTextField.borderStyle = UITextBorderStyleNone;
        _assistTextField.returnKeyType = UIReturnKeyDone;
        _assistTextField.delegate = self;
        [_assistTextField addTarget:self action:@selector(assistTextFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _assistTextField;
}

- (UIView *)assistCustomView
{
    if (_assistCustomView == nil) {
        _assistCustomView = [[UIView alloc] init];
        _assistCustomView.hidden = YES;
    }
    return _assistCustomView;
}

- (YQBadgeView *)badgeView
{
    if (_badgeView == nil) {
        _badgeView = [[YQBadgeView alloc] init];
    }
    return _badgeView;
}

- (UIView *)bottomLine
{
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] init];
    }
    return _bottomLine;
}
@end
