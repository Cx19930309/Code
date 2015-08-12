//
//  LimitViewController.m
//  TestIpaDown
//
//  Created by gaokunpeng on 15/8/2.
//  Copyright (c) 2015年 gaokunpeng. All rights reserved.
//

#import "LimitViewController.h"
#import "HomeModel.h"
#import "LimitCell.h"
#import "AFHTTPRequestOperationManager.h"

@interface LimitViewController ()

@property (nonatomic,assign)NSInteger selectIndex;

@end

@implementation LimitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //导航
    [self createSegmetCtrl];
    
    //下拉刷新
    [self addRefresh];
}


//导航
- (void)createSegmetCtrl
{
    UISegmentedControl *segCtrl = [[UISegmentedControl alloc] initWithItems:@[@"今日限免",@"本周热门限免",@"热门限免总榜"]];
    [segCtrl addTarget:self action:@selector(clickSegCtrl:) forControlEvents:UIControlEventValueChanged];
    //修改文字颜色
    [segCtrl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    self.navigationItem.titleView = segCtrl;
}

- (void)clickSegCtrl:(UISegmentedControl *)segCtrl
{
    self.selectIndex = segCtrl.selectedSegmentIndex;
    
    self.curPage = 1;
    
    self.tbView.contentOffset = CGPointZero;
    [self downloadData];
}

- (void)downloadData
{
    //下载列表数据
    self.isLoading = YES;
    
    
    //block里面需要使用self的弱引用
    __weak LimitViewController *weakSelf = self;
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    NSString *urlString = nil;
    if (self.selectIndex == 0) {
        urlString = [NSString stringWithFormat:kLimitToday,self.pageSize,self.curPage];
    }else if (self.selectIndex == 1){
        urlString = [NSString stringWithFormat:kLimitMonth,self.pageSize,self.curPage];
    }else if (self.selectIndex == 2){
        urlString = [NSString stringWithFormat:kLimitHot,self.pageSize,self.curPage];
    }
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (weakSelf.curPage == 1) {
            [weakSelf.dataArray removeAllObjects];
        }
        
        //JSON解析
        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([result isKindOfClass:[NSArray class]]) {
            NSArray *array = result;
            
            for (NSDictionary *limitDict in array) {
                //创建模型对象
                HomeModel *model = [[HomeModel alloc] init];
                [model setValuesForKeysWithDictionary:limitDict];
                [weakSelf.dataArray addObject:model];
            }
            
            //刷新表格
            weakSelf.isLoading = NO;
            [weakSelf.headerView endRefreshing];
            [weakSelf.footerView endRefreshing];
            
            [weakSelf.tbView reloadData];
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
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"limitCellId";
    
    LimitCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (nil == cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LimitCell" owner:nil options:nil] lastObject];
    }
    
    //显示数据
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
