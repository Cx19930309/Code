//
//  SubjectViewController.m
//  Limit_1509
//
//  Created by qianfeng on 15/7/27.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SubjectViewController.h"
#import "SubjectItem.h"
#import "SubjectCell.h"
#import "DetailViewController.h"

@interface SubjectViewController () <MyDownloaderDelegate,SubjectCellDelegate>

@end

@implementation SubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //导航
    [self createMyNav];
}

//导航
- (void)createMyNav {
    [self addNavTitle:CGRectMake(60, 0, 255, 44) title:@"专题"];
}

//下载数据
- (void)downloadData {
    _isLoading = YES;
    MyDownloader *downloader = [[MyDownloader alloc]init];
    downloader.delegate = self;
    NSString *urlString = [NSString stringWithFormat:kSubjectUrl,_curPage];
    [downloader downloadWithUrlString:urlString];
}

- (void)downloaderFail:(MyDownloader *)downloader failWithError:(NSError *)error {
    NSLog(@"error:%@", error);
    //修改下载状态
    _isLoading = NO;
    
    [_headerView endRefreshing];
    [_footerView endRefreshing];
}

- (void)downloaderFinish:(MyDownloader *)downloader {
    _tbView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //一定在下载回来的时候删除
    if (_curPage == 1) {
        [_dataArray removeAllObjects];
    }
    id result = [NSJSONSerialization JSONObjectWithData:downloader.receiveData options:NSJSONReadingMutableContainers error:nil];
    if ([result isKindOfClass:[NSArray class]]) {
        NSArray *array = result;
        for (NSDictionary *subjectDict in array) {
            SubjectItem *sItem = [[SubjectItem alloc]init];
            [sItem setValuesForKeysWithDictionary:subjectDict];
            
            //应用数据
            NSMutableArray *appArray = [NSMutableArray array];
            for (NSDictionary *appDict in subjectDict[@"applications"]) {
                //创建应用数据模型对象
                AppItem *aItem = [[AppItem alloc]init];
                [aItem setValuesForKeysWithDictionary:appDict];
                [appArray addObject:aItem];
            }
            sItem.appArray = appArray;
            [_dataArray addObject:sItem];
        }
        //刷新表格
        [_tbView reloadData];
        
        //结束加载
        _isLoading = NO;
        [_headerView endRefreshing];
        [_footerView endRefreshing];
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *subjectCellId = @"subjectCellId";
    SubjectCell *cell = [tableView dequeueReusableCellWithIdentifier:subjectCellId];
    if (nil == cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SubjectCell" owner:nil options:nil] lastObject];
    }
    SubjectItem *sItem = _dataArray[indexPath.row];
    cell.sItem = sItem;
    
    /*
     //设置代理
    cell.delegate = self;
    */
    
    //block方式传值
    __weak SubjectViewController *weakSelf = self;
    cell.clickBlock = ^(AppItem *aItem) {
        //跳转到详情
        DetailViewController *dCtrl = [[DetailViewController alloc]init];
        dCtrl.applicationId = aItem.applicationId;
        
        weakSelf.hidesBottomBarWhenPushed = YES;
        
        [weakSelf.navigationController pushViewController:dCtrl animated:YES];
        
        weakSelf.hidesBottomBarWhenPushed = NO;
    };
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView {
    if (_isLoading) {
        return;
    }
    if (refreshView == _headerView) {
        _curPage = 1;
        [self downloadData];
    } else if (refreshView == _footerView) {
        _curPage++;
        [self downloadData];
    }
}

/*
- (void)didSelectAppItem:(AppItem *)aItem {
    //跳转到详情
    DetailViewController *dCtrl = [[DetailViewController alloc]init];
    dCtrl.applicationId = aItem.applicationId;
    
    self.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:dCtrl animated:YES];
    
    self.hidesBottomBarWhenPushed = NO;
}
*/
 
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
