//
//  HomePageController.m
//  TestIpaDown
//
//  Created by gaokunpeng on 15/8/2.
//  Copyright (c) 2015年 gaokunpeng. All rights reserved.
//

#import "HomePageController.h"
#import "AFHTTPRequestOperationManager.h"
#import "HomeModel.h"
#import "HomeCell.h"
#import "ADModel.h"
#import "ADCell.h"

@interface HomePageController ()

@property (nonatomic,strong)NSMutableArray *adArray;

@end

@implementation HomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //标题
    [self addNavLabelTitle:@"精品限时免费"];
    
    //下拉刷新
    [self addRefresh];
    
    //下载广告数据
    [self downloadAdvertismentData];
    
    
}

-(NSMutableArray *)adArray
{
    if (_adArray == nil) {
        _adArray = [NSMutableArray array];
    }
    return _adArray;
}

//下载广告数据
- (void)downloadAdvertismentData
{
    //block里面需要使用self的弱引用
    __weak HomePageController *weakSelf = self;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager GET:kHomeAdUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //解析数据
        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([result isKindOfClass:[NSArray class]]) {
            
            NSArray *array = result;
            
            for (NSDictionary *adDict in array) {
                //创建模型对象
                ADModel *model = [[ADModel alloc] init];
                [model setValuesForKeysWithDictionary:adDict];
                [weakSelf.adArray addObject:model];
            }
            
            [weakSelf.tbView reloadData];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载广告失败");
    }];
}


//下载列表数据
- (void)downloadData
{
    
    self.isLoading = YES;
    
    //block里面需要使用self的弱引用
    __weak HomePageController *weakSelf = self;
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *urlString = [NSString stringWithFormat:kHomeListUrl,self.pageSize,self.curPage];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        if (weakSelf.curPage == 1) {
            [weakSelf.dataArray removeAllObjects];
        }
        
        
       //JSON解析
        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([result isKindOfClass:[NSArray class]]) {
            NSArray *array = result;
            
            for (NSDictionary *homeDict in array) {
                //创建模型对象
                HomeModel *model = [[HomeModel alloc] init];
                [model setValuesForKeysWithDictionary:homeDict];
                [weakSelf.dataArray addObject:model];
            }
            
        }
        
        
        //刷新表格
        weakSelf.isLoading = NO;
        [weakSelf.headerView endRefreshing];
        [weakSelf.footerView endRefreshing];
        
        [weakSelf.tbView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        weakSelf.isLoading = NO;
        [weakSelf.headerView endRefreshing];
        [weakSelf.footerView endRefreshing];
        
        NSLog(@"下载失败");
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//下拉刷新时额外的操作
-(void)refreshHeader
{
    [self downloadAdvertismentData];
}

#pragma mark - UITableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger num = self.dataArray.count;
    if (self.adArray.count > 0) {
        num++;
    }
    return num;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat h = 0;
    if (self.adArray.count > 0) {
        if (indexPath.row == 0) {
            h = 160;
        }else{
            h = 110;
        }
    }else{
        h = 110;
    }
    return h;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.adArray.count > 0) {
       
        if (indexPath.row == 0) {
            
            //广告
            static NSString *cellID = @"adCellId";
            
            ADCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (nil == cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"ADCell" owner:nil options:nil] lastObject];
            }
            
            cell.dataArray = self.adArray;
            
            return cell;
            
            
            
        }else{
            //列表
            static NSString *cellId = @"homeCellId";
            
            HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (nil == cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeCell" owner:nil options:nil] lastObject];
            }
            
            HomeModel *model = self.dataArray[indexPath.row-1];
            [cell configModel:model index:indexPath.row-1];
            
            return cell;
        }
        
    }else{
        //列表
        static NSString *cellId = @"homeCellId";
        
        HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (nil == cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeCell" owner:nil options:nil] lastObject];
        }
        
        HomeModel *model = self.dataArray[indexPath.row];
        [cell configModel:model index:indexPath.row];
        
        return cell;
    }
    
    return nil;
    
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
