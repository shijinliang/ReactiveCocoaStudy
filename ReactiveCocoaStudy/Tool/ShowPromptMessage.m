//
//  ShowPromptMessage.m
//  ReactiveCocoaStudy
//
//  Created by xiaoshi on 16/5/31.
//  Copyright © 2016年 https://github.com/shijinliang, http://blog.csdn.net/sjl_leaf. All rights reserved.
//

#import "ShowPromptMessage.h"

@implementation ShowPromptMessage

+ (ShowPromptMessage*)sharedManager
{
    static ShowPromptMessage*showMessage = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        showMessage = [[super allocWithZone:NULL] init];
    });
    return showMessage;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedManager];
}

- (void)showPromptMessage:(NSString *)message
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    UIWindow * window = [UIApplication sharedApplication].windows.lastObject;
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor blackColor];
    showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = 0.7f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];
    
    UILabel *label = [[UILabel alloc]init];
    CGSize LabelSize = [message sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    //计算标签文本宽高
    CGSize labelSize = [message boundingRectWithSize:CGSizeMake(size.width - 40, 50) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:label.font forKey:NSFontAttributeName] context:nil].size;
    //如果宽度没有达到屏宽，则使用上面计算的LabelSize的宽，
    NSInteger labelWidth = size.width - 40;
    if (labelWidth > LabelSize.width) {
        labelWidth = LabelSize.width;
    }
    label.frame = CGRectMake(0, 18, labelWidth + 40, labelSize.height);
    [showview addSubview:label];
    
    showview.frame = CGRectMake((size.width - labelSize.width )/2 - 20, (size.height - labelSize.height)/2 - 18, labelSize.width + 40, labelSize.height+36);
    
    [UIView animateWithDuration:0.25 delay:1.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
}

@end
