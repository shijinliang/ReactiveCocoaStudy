//
//  ViewItem.h
//  ReactiveCocoaStudy
//
//  Created by xiaoshi on 16/5/31.
//  Copyright © 2016年 https://github.com/shijinliang, http://blog.csdn.net/sjl_leaf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewItem : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;

+ (instancetype)initWithTitle:(NSString *)title content:(NSString *)content;
@end
