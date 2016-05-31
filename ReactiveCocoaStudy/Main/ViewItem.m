//
//  ViewItem.m
//  ReactiveCocoaStudy
//
//  Created by xiaoshi on 16/5/31.
//  Copyright © 2016年 https://github.com/shijinliang, http://blog.csdn.net/sjl_leaf. All rights reserved.
//

#import "ViewItem.h"

@implementation ViewItem
+ (instancetype)initWithTitle:(NSString *)title content:(NSString *)content
{
    ViewItem *item = [[ViewItem alloc] init];
    item.title = title;
    item.content = content;
    return item;
}
@end
