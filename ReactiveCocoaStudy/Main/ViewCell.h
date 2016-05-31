//
//  ViewCell.h
//  ReactiveCocoaStudy
//
//  Created by xiaoshi on 16/5/31.
//  Copyright © 2016年 https://github.com/shijinliang, http://blog.csdn.net/sjl_leaf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewItem.h"

@interface ViewCell : UITableViewCell

@property (nonatomic, strong) ViewItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
