//
//  DailyViewController.m
//  TestIpaDown
//
//  Created by gaokunpeng on 15/8/2.
//  Copyright (c) 2015年 gaokunpeng. All rights reserved.
//

#import "DailyViewController.h"
#import "HomeModel.h"
#import "HomeCell.h"
#import "AFHTTPRequestOperationManager.h"

@interface DailyViewController ()

@end

@implementation DailyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //导航
    [self addNavLabelTitle:@"每日一荐"];
    
    //下拉刷新
    [self addRefresh];
    
    //返回
    [self addBackBtnTarget:self action:@selector(backAction:)];
}

- (void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)downloadData
{
    self.isLoading = NO;
    
    //block里面需要使用self的弱引用
    __weak DailyViewController *weakSelf = self;
    
    //下载数据
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *urlString = [NSString stringWithFormat:kDailyUrl,self.pageSize,self.curPage];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (weakSelf.curPage == 1) {
            [weakSelf.dataArray removeAllObjects];
        }
        
        //数据解析
        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([result isKindOfClass:[NSArray class]]) {
            NSArray *array = result;
            
            for (NSDictionary *homeDict in array) {
                //创建模型对象
                HomeModel *model = [[HomeModel alloc] init];
                [model setValuesForKeysWithDictionary:homeDict];
                [weakSelf.dataArray addObject:model];
            }
            
            //刷新表格
            weakSelf.isLoading = NO;
            [weakSelf.tbView reloadData];
            
            [weakSelf.headerView endRefreshing];
            [weakSelf.footerView endRefreshing];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"homeCellId";
    
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeCell" owner:nil options:nil] lastObject];
    }
    
    HomeModel *model = self.dataArray[indexPath.row];
    [cell configModel:model index:indexPath.row];
    
    return cell;
    
    
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
