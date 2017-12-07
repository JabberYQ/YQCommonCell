//
//  YQBadgeView.m
//  YQCommonCell
//
//  Created by 俞琦 on 15/8/29.
//  Copyright (c) 2015年 俞琦. All rights reserved.
//

#import "YQBadgeView.h"

@implementation YQBadgeView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[self resizedImage:@"common_badge"] forState:UIControlStateNormal];
        //按钮的高度就是背景图片的高度
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.bounds.size.width, self.currentBackgroundImage.size.height);
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    if([badgeValue isKindOfClass:[NSString class]]){
      _badgeValue = [badgeValue copy];
    }else{
        _badgeValue = [((NSNumber *)badgeValue).stringValue copy ];
    }
    
    //设置文字
    [self setTitle:_badgeValue forState:UIControlStateNormal];
    UIFont *font = [UIFont systemFontOfSize:12];
    self.titleLabel.font = font;
    
    //根据文字计算自己的尺寸
    NSDictionary *attributes = @{NSFontAttributeName : font};
    CGSize titleSize = [_badgeValue sizeWithAttributes:attributes];
    CGFloat bgW = self.currentBackgroundImage.size.width;
    if (titleSize.width < bgW) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, bgW, self.bounds.size.height);
    } else {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, titleSize.width + 10, self.bounds.size.height);
    }
    
}

- (UIImage *)resizedImage:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}


@end
