//
//  NewViewController.m
//  ReactiveCocoaStudy
//
//  Created by xiaoshi on 16/5/31.
//  Copyright © 2016年 https://github.com/shijinliang, http://blog.csdn.net/sjl_leaf. All rights reserved.
//

#import "NewViewController.h"
#import "ShowPromptMessage.h"
//#import <ReactiveCocoaStudy-Swift.h>
@interface NewViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *tView;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[self.btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [[ShowPromptMessage sharedManager] showPromptMessage:@"按钮点击事件委托交给rac处理"];
    }];
    
    //👌
    [[self rac_signalForSelector:@selector(tableView:didSelectRowAtIndexPath:) fromProtocol:@protocol(UITableViewDelegate)] subscribeNext:^(RACTuple *tuple) {
        UITableView *tableView = [tuple first];
        NSIndexPath *path = (NSIndexPath *)[tuple second];
        NSLog(@"%@", path);
        [[ShowPromptMessage sharedManager] showPromptMessage:@"截取点击事件的代理"];
    }];
    
    [[self rac_signalForSelector:@selector(scrollViewDidEndDragging:willDecelerate:) fromProtocol:@protocol(UIScrollViewDelegate)] subscribeNext:^(id x) {
        [[ShowPromptMessage sharedManager] showPromptMessage:@"停止滑动的代理"];
    }];
    
    //需要在上面设置完委托后再设置delegate, 你可以自己试一下不要下面这句话的时候，点击某一个cell是否可用
    //【带有返回值得代理不适合此种方法】
    self.myTableView.delegate = self;
    
    //👌自己新建一个button
    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [myButton setTitle:@"让我来测试自定义button代理" forState:UIControlStateNormal];
    myButton.frame = CGRectMake(0, CGRectGetMaxY(_myTableView.frame)+50, 280, 30);
    myButton.backgroundColor = [UIColor blueColor];
    [[myButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [[ShowPromptMessage sharedManager] showPromptMessage:@"测试自己创建按钮点击事件"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"xiaoshiceshi" object:nil];
    }];
    //[myButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myButton];
    
    //👌*******************
    UIButton *sButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [sButton setTitle:@"测试通知" forState:UIControlStateNormal];
    sButton.frame = CGRectMake(0, CGRectGetMaxY(myButton.frame)+20, 280, 30);
    sButton.backgroundColor = [UIColor blueColor];
    [[sButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"xiaoshiceshi" object:nil];
    }];
    [self.view addSubview:sButton];
    
    //*******************
    //👌监听一个方法有没有被调用
    [[self rac_signalForSelector:@selector(tableView:numberOfRowsInSection:)] subscribeNext:^(id x) {
        NSLog(@"监听tableView:numberOfRowsInSection:被调用");
    }];
    
    [[self rac_signalForSelector:@selector(goodBoy)] subscribeNext:^(id x) {
        NSLog(@"****goodBoy*****");
    }];
    
    //这个都需要放在监听后面，不然你都执行完了，才设置监听岂不是浪费了😄
    [self goodBoy];
    
    
    //👌监听通知
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"xiaoshiceshi" object:nil] subscribeNext:^(id x) {
         [[ShowPromptMessage sharedManager] showPromptMessage:@"上面点击事件给我发来通知"];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goodBoy
{
    NSLog(@"我是一个好孩子，有人调用我");
}

- (void)badBoy
{
    NSLog(@"我是一个坏孩子，没人调用我");
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell new];
    cell.textLabel.text = [NSString stringWithFormat:@"第%d行", indexPath.row+1];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

@end
