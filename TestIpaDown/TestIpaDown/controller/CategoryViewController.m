//
//  CategoryViewController.m
//  TestIpaDown
//
//  Created by gaokunpeng on 15/8/2.
//  Copyright (c) 2015年 gaokunpeng. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryModel.h"
#import "CategoryCell.h"
#import "AFHTTPRequestOperationManager.h"
#import "CateListController.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //标题
    [self addNavLabelTitle:@"按分类筛选"];
    
    //下载数据
    [self downloadData];
    
}

-(void)downloadData
{

    
    //block里面需要使用self的弱引用
    __weak CategoryViewController *weakSelf = self;
    
    //下载数据
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:kCategoryListUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //解析数据
        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([result isKindOfClass:[NSArray class]]) {
            NSArray *array = result;
            
            for (NSDictionary *cateDict in array) {
                //创建模型对象
                CategoryModel *model = [[CategoryModel alloc] init];
                [model setValuesForKeysWithDictionary:cateDict];
                
                //类型列表
                NSMutableArray *listArray = [NSMutableArray array];
                for (NSDictionary *typeDict in cateDict[@"list"]) {
                    //类型对象
                    CategoryType *typeModel = [[CategoryType alloc] init];
                    [typeModel setValuesForKeysWithDictionary:typeDict];
                    [listArray addObject:typeModel];
                }
                
                model.typeArray = listArray;
                
                [weakSelf.dataArray addObject:model];
            }
            
            //刷新表格
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CategoryModel *model = self.dataArray[section];
    return model.typeArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cateCellId";
    
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CategoryCell" owner:nil options:nil] lastObject];
    }
    
    CategoryModel *model = self.dataArray[indexPath.section];
    CategoryType *type = model.typeArray[indexPath.row];
    [cell config:type];
    
    return cell;

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    CategoryModel *model = self.dataArray[section];
    return model.header;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryModel *model = self.dataArray[indexPath.section];
    CategoryType *type = model.typeArray[indexPath.row];
    
    //跳转分类结果列表
    CateListController *listCtrl = [[CateListController alloc] init];
    listCtrl.categoryStr = type.querystr;
    listCtrl.cateName = type.title;
    
    [self.navigationController pushViewController:listCtrl animated:YES];
    
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
