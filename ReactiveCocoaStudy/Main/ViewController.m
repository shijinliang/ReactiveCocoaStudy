//
//  ViewController.m
//  ReactiveCocoaStudy
//
//  Created by xiaoshi on 16/5/31.
//  Copyright © 2016年 https://github.com/shijinliang, http://blog.csdn.net/sjl_leaf. All rights reserved.
//

#import "ViewController.h"
#import "ViewCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "NewViewController.h"
#import "LogonViewController.h"


@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *_dataArray;
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"首页";
    
    [self setData];
    [self setSignal];
    
    [self.view addSubview:self.tableView];
    
}

- (void)setData
{
    ViewItem *item1 = [ViewItem initWithTitle:@"rac_signalForSelector" content:@"用于替代代理"];
    
    ViewItem *item2 = [ViewItem initWithTitle:@"" content:@""];
    ViewItem *item3 = [ViewItem initWithTitle:@"" content:@""];
    ViewItem *item4 = [ViewItem initWithTitle:@"combineLatest:reduce:" content:@"KVO监听按钮多个状态"];
    //………………
    _dataArray = @[item1, item2, item3, item4];
}

- (void)setSignal
{
    /**
     *  用RAC写代理是有局限的，它只能实现返回值为void的代理方法
     *  subscribeNext返回的是RACTuple，
     *  设置代理在设置信号的下面执行
     */
    [[self rac_signalForSelector:@selector(tableView:didSelectRowAtIndexPath:) fromProtocol:@protocol(UITableViewDelegate)] subscribeNext:^(RACTuple *tuple) {
        NSIndexPath *path = (NSIndexPath *)tuple.second;
        switch (path.row) {
            case 0:
                [self openNew];
                break;
            case 1:
                [self openLogon];
            case 2:
                [self openLogon];
            case 3:
                [self openLogon];
            default:
                break;
        }
        NSLog(@"点击了某一个cell");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ViewCell *cell = [ViewCell cellWithTableView:tableView];
    cell.item = _dataArray[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"12312");
//}

- (IBAction)click:(id)sender {
    NewViewController *ctrl = [[NewViewController alloc] init];
    ctrl.delegateSignal = [RACSubject subject];
    [ctrl.delegateSignal subscribeNext:^(id x) {
        NSLog(@"12312");
    }];
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (void)openNew
{
    NewViewController *ctrl = [[NewViewController alloc] init];
    ctrl.delegateSignal = [RACSubject subject];
    [ctrl.delegateSignal subscribeNext:^(id x) {
        NSLog(@"12312");
    }];
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (void)openLogon
{
    LogonViewController *ctrl = [[LogonViewController alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor lightGrayColor];
        _tableView.rowHeight = 50;
    }
    return _tableView;
}

@end
