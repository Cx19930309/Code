//
//  BaseViewController.m
//  TestIpaDown
//
//  Created by gaokunpeng on 15/8/2.
//  Copyright (c) 2015年 gaokunpeng. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //表格
    [self createTableView];
    
    //下载数据
    self.curPage = 1;
    self.pageSize = 20;
    self.isLoading = NO;
    
    self.dataArray = [NSMutableArray array];
    [self downloadData];
    
}

-(void)dealloc
{
    self.headerView.scrollView = nil;
    self.headerView = nil;
    self.footerView.scrollView = nil;
    self.footerView = nil;

}

-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)createTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375, 667-64-49) style:UITableViewStylePlain];
    self.tbView.delegate = self;
    self.tbView.dataSource = self;
    [self.view addSubview:self.tbView];
    
    
    
}

- (void)addRefresh
{
    //下拉刷新
    self.headerView = [MJRefreshHeaderView header];
    self.headerView.delegate = self;
    self.headerView.scrollView = _tbView;
    
    self.footerView = [MJRefreshFooterView footer];
    self.footerView.delegate = self;
    self.footerView.scrollView = _tbView;
    
    [self.headerView beginRefreshing];
}

-(void)downloadData
{
    NSLog(@"子类需要实现方法:%s",__FUNCTION__);
}

-(void)refreshHeader
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"子类需要实现方法:%s",__FUNCTION__);
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"子类需要实现方法:%s",__FUNCTION__);
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"子类需要实现方法:%s",__FUNCTION__);
    return nil;
}

#pragma mark - MJRefresh代理
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (self.isLoading) {
        return;
    }
    
    if (refreshView == self.headerView) {
        self.curPage = 1;
        
        [self downloadData];
        
        //下拉刷新需要做的其他事情
        [self refreshHeader];
        
    }else if (refreshView == self.footerView){
        self.curPage ++;
        
        [self downloadData];
    }
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
