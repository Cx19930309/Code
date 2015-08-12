//
//  BaseViewController.m
//  Limit_1509
//
//  Created by qianfeng on 15/7/27.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //创建表格
    [self createTableView];
    
    //下载
    _dataArray = [NSMutableArray array];
    
    _isLoading = NO;
    _curPage = 1;
}

//创建表格
- (void)createTableView {
    //在导航下面显示表格
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tbView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, 375, 667-64-49)];
    _tbView.dataSource = self;
    _tbView.delegate = self;
    //去掉分割线
    _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tbView];
    
    //下拉刷新
    _headerView = [MJRefreshHeaderView header];
    _headerView.scrollView = _tbView;
    _headerView.delegate = self;
    
    //上拉加载
    _footerView = [MJRefreshFooterView footer];
    _footerView.scrollView = _tbView;
    _footerView.delegate = self;
    
    //下拉刷新
    [_headerView beginRefreshing];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    _headerView.scrollView = nil;
    _footerView.scrollView = nil;
}

#pragma mark -UITableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"子类必须实现方法%s", __FUNCTION__);
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"子类必须实现方法%s", __FUNCTION__);
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"子类必须实现方法%s", __FUNCTION__);
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"子类必须实现方法%s", __FUNCTION__);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
