//
//  CategoryViewController.m
//  Limit_1509
//
//  Created by qianfeng on 15/7/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryItem.h"
#import "CategoryCell.h"

@interface CategoryViewController () <UITableViewDataSource,UITableViewDelegate,MyDownloaderDelegate>
{
    //表格
    UITableView *_tbView;
    //数据源
    NSMutableArray *_dataArray;
}
@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //导航
    [self createMyNav];
    //表格
    [self createTableView];
    //下载数据
    _dataArray = [NSMutableArray array];
    [self downloadData];
}

//导航
- (void)createMyNav {
    //返回按钮
    UIButton *backBtn = [self addNavBtn:CGRectMake(0, 0, 60, 30) title:@"返回" target:self action:@selector(backAction:) isLeft:YES];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"buttonbar_back"] forState:UIControlStateNormal];
    //标题
    [self addNavTitle:CGRectMake(60, 0, 255, 44) title:self.titleString];
}

- (void)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//表格
- (void)createTableView {
    //导航
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //表格的创建
    _tbView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, 375, 667-64-49) style:UITableViewStylePlain];
    _tbView.delegate = self;
    _tbView.dataSource = self;
    _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tbView];
}

//下载数据
- (void)downloadData {
    MyDownloader *downloader = [[MyDownloader alloc]init];
    downloader.delegate = self;
    NSString *urlString = self.urlString;
    [downloader downloadWithUrlString:urlString];
}

#pragma mark -下载代理
- (void)downloaderFail:(MyDownloader *)downloader failWithError:(NSError *)error {
    NSLog(@"error:%@", error);
}

- (void)downloaderFinish:(MyDownloader *)downloader {
    _tbView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    id result = [NSJSONSerialization JSONObjectWithData:downloader.receiveData options:NSJSONReadingMutableContainers error:nil];
    if ([result isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = result;
        for (NSDictionary *cateDict in dict[@"category"]) {
            //第一个全部的数据不需要
            if ([cateDict[@"categoryId"] isEqual:@"0"]) {
                //不执行下面的语句
                continue;
            }
            
            //创建模型对象
            CategoryItem *cItem = [[CategoryItem alloc]init];
            [cItem setValuesForKeysWithDictionary:cateDict];
            //添加到数据源
            [_dataArray addObject:cItem];
        }
        [_dataArray insertObject:[_dataArray lastObject] atIndex:0];
        [_dataArray removeObjectAtIndex:_dataArray.count-1];
        //刷新表格
        [_tbView reloadData];
    }
}

#pragma mark -UITableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cateCellId = @"cateCellId";
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cateCellId];
    if (nil == cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CategoryCell" owner:nil options:nil] lastObject];
    }
    //数据显示
    CategoryItem *cItem = _dataArray[indexPath.row];
    [cell configItem:cItem];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //获取当前点击的对象
    CategoryItem *cItem = _dataArray[indexPath.row];
    if (self.delegate) {
        [self.delegate didSelectCateId:cItem.categoryId cateName:[MyUtil transferCateName:cItem.categoryName]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
