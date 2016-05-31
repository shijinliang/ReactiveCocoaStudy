//
//  LogonViewController.m
//  ReactiveCocoaStudy
//
//  Created by xiaoshi on 16/5/31.
//  Copyright © 2016年 https://github.com/shijinliang, http://blog.csdn.net/sjl_leaf. All rights reserved.
//

#import "LogonViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface LogonViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameText;

@property (weak, nonatomic) IBOutlet UITextField *passwordText;

@property (weak, nonatomic) IBOutlet UITextField *phoneText;

@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;

@property (weak, nonatomic) IBOutlet UIButton *logonButton;

/**
 *  用于下面测试RACObserve(self, self.label)使用
 */
@property (nonatomic, strong) UILabel *label;

@end

@implementation LogonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setSignal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setSignal
{
    [[RACSignal combineLatest:@[self.nameText.rac_textSignal, self.passwordText.rac_textSignal, self.phoneText.rac_textSignal] reduce:^id(NSString *name, NSString *password, NSString *phone) {
        self.phoneNumLabel.text = [NSString stringWithFormat:@"%d",phone.length];
        return @(name.length > 0 && password.length >= 6 && phone.length==13);
    }] subscribeNext:^(NSNumber *x) {
        BOOL isShow = [x boolValue]; 
        if (isShow) {
            self.logonButton.backgroundColor = [UIColor redColor];
            self.logonButton.enabled = YES;
        } else {
            self.logonButton.backgroundColor = [UIColor lightGrayColor];
            self.logonButton.enabled = NO;
        }
    }];
    
    //rac_textSignal 不是每个控件都有的，当我们监听label或者其他的控件的时候，可以使用：RACObserve(TARGET, KEYPATH)
    //这种形式，TARGET是监听目标，KEYPATH是要观察的属性值，可以这样写 RACObserve(self, self.label)，也可以RACObserve(self.label, text) 如下RACObserve(nameLabel, text)
    //监听一个label有没有值可以这样写
    //nameLabel 是一个label,下面的例子：self.nameText和nameLabel 有没有值
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"name";
    [[RACSignal combineLatest:@[self.nameText.rac_textSignal, RACObserve(nameLabel, text)] reduce:^id(NSString *name, NSString *label) {
        return @(name.length > 0 && label.length >= 6);
    }] subscribeNext:^(NSNumber *x) {
        
    }];
}


- (IBAction)logonClick:(id)sender {
    NSLog(@"开始注册");
}

@end
