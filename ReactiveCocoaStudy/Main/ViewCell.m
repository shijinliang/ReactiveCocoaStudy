//
//  ViewCell.m
//  ReactiveCocoaStudy
//
//  Created by xiaoshi on 16/5/31.
//  Copyright © 2016年 https://github.com/shijinliang, http://blog.csdn.net/sjl_leaf. All rights reserved.
//

#import "ViewCell.h"

@interface ViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation ViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    ViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ViewCell" owner:self options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setItem:(ViewItem *)item
{
    _item = item;
    self.titleLabel.text = item.title;
    self.contentLabel.text = item.content;
}

@end
