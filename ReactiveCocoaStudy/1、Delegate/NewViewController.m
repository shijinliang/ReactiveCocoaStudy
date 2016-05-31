//
//  NewViewController.m
//  ReactiveCocoaStudy
//
//  Created by xiaoshi on 16/5/31.
//  Copyright © 2016年 https://github.com/shijinliang, http://blog.csdn.net/sjl_leaf. All rights reserved.
//

#import "NewViewController.h"

//#import <ReactiveCocoaStudy-Swift.h>
@interface NewViewController ()
@property (strong, nonatomic) IBOutlet UIView *tView;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[self.btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"next");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)click:(UIButton *)sender
{
    NSLog(@"click");
}

- (IBAction)notice:(id)sender {
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:@"123"];
    }
}


@end
