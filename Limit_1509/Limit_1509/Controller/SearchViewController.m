//
//  SearchViewController.m
//  Limit_1509
//
//  Created by qianfeng on 15/7/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SearchViewController.h"
#import "LimitModel.h"
#import "LimitCell.h"
#import "ReduceCell.h"
#import "FreeCell.h"
#import "HotCell.h"
#import "DetailViewController.h"

@interface SearchViewController () <MyDownloaderDelegate,UISearchBarDelegate>

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //导航
    [self createMyNav];
    
    //修改tableView的frame
    _tbView.frame = CGRectMake(0, 64, 375, 667-64);
    
    //搜索框
    [self createSearchBar];
    
}

- (void)createSearchBar {
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 375, 40)];
    searchBar.delegate = self;
    searchBar.text = self.keyword;
    
    _tbView.tableHeaderView = searchBar;
}

- (void)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//导航
- (void)createMyNav {
    //返回按钮
    UIButton *btn = [self addNavBtn:CGRectMake(0, 0, 60, 30) title:@"返回" target:self action:@selector(backAction:) isLeft:YES];
    [btn setBackgroundImage:[UIImage imageNamed:@"buttonbar_back"] forState:UIControlStateNormal];
    //标题
    [self addNavTitle:CGRectMake(60, 0, 255, 44) title:@"搜索"];
}

//下载数据
- (void)downloadData {
    _isLoading = YES;
    MyDownloader *downloader = [[MyDownloader alloc]init];
    downloader.delegate = self;
    NSString *urlString = nil;
    if (self.type == SearchTypeLimit) {
        //限免搜索
        urlString = [NSString stringWithFormat:kLimitSearchUrl, _curPage,self.keyword];
    } else if (self.type == SearchTypeReduce) {
        urlString = [NSString stringWithFormat:KReduceSearchUrl,_curPage,self.keyword];
    } else if (self.type == SearchTypeFree) {
        urlString = [NSString stringWithFormat:kFreeSearchUrl,_curPage,self.keyword];
    } else if (self.type == SearchTypeHot) {
        urlString = [NSString stringWithFormat:kHotSearchUrl,_curPage,self.keyword];
    }
    [downloader downloadWithUrlString:urlString];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)downloaderFail:(MyDownloader *)downloader failWithError:(NSError *)error {
    NSLog(@"error:%@", error);
}

- (void)downloaderFinish:(MyDownloader *)downloader {
    if (_curPage == 1) {
        [_dataArray removeAllObjects];
    }
    
    //解析数据
    id result = [NSJSONSerialization JSONObjectWithData:downloader.receiveData options:NSJSONReadingMutableContainers error:nil];
    if ([result isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = result;
        NSArray *appArray = [dict objectForKey:@"applications"];
        for (NSDictionary *appDict in appArray) {
            //创建一个模型对象
            LimitModel *model = [[LimitModel alloc]init];
            //kvc设置属性
            [model setValuesForKeysWithDictionary:appDict];
            [_dataArray addObject:model];
        }
        
        //刷新表格
        [_tbView reloadData];
        _isLoading = NO;
        [_headerView endRefreshing];
        [_footerView endRefreshing];
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.type == SearchTypeLimit) {
        //限免的搜索
        static NSString *limitCellId = @"limitCellId";
        LimitCell *cell = [tableView dequeueReusableCellWithIdentifier:limitCellId];
        if (nil == cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"LimitCell" owner:nil options:nil] lastObject];
        }
        //模型对象
        LimitModel *model = _dataArray[indexPath.row];
        [cell configModel:model index:indexPath.row cutLength:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    } else if (self.type == SearchTypeReduce) {
        static NSString *reduceCellId = @"reduceCellId";
        ReduceCell *cell = [tableView dequeueReusableCellWithIdentifier:reduceCellId];
        if (nil == cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ReduceCell" owner:nil options:nil] lastObject];
        }
        //模型对象
        LimitModel *model = _dataArray[indexPath.row];
        [cell configModel:model index:indexPath.row];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    } else if (self.type == SearchTypeFree) {
        static NSString *freeCellId = @"freeCellId";
        FreeCell *cell = [tableView dequeueReusableCellWithIdentifier:freeCellId];
        if (nil == cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"FreeCell" owner:nil options:nil] lastObject];
        }
        //模型对象
        LimitModel *model = _dataArray[indexPath.row];
        [cell configModel:model index:indexPath.row];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    } else if (self.type == SearchTypeHot) {
        static NSString *hotCellId = @"hotCellId";
        HotCell *cell = [tableView dequeueReusableCellWithIdentifier:hotCellId];
        if (nil == cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"HotCell" owner:nil options:nil] lastObject];
        }
        //模型对象
        LimitModel *model = _dataArray[indexPath.row];
        [cell configModel:model index:indexPath.row];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LimitModel *model = _dataArray[indexPath.row];
    //
    DetailViewController *dCtrl = [[DetailViewController alloc]init];
    dCtrl.applicationId = model.applicationId;
    [self.navigationController pushViewController:dCtrl animated:YES];
}

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView {
    //如果正在刷新,不进行任何操作
    if (_isLoading) {
        return;
    }
    if (refreshView == _headerView) {
        //下拉刷新
        _curPage = 1;
        [self downloadData];
    } else if (refreshView == _footerView) {
        //上拉加载
        _curPage++;
        [self downloadData];
    }
}

#pragma mark -UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    //显示取消按钮
    searchBar.showsCancelButton = YES;
    
    UIView *firstSub = [searchBar.subviews lastObject];
    
    NSArray *subArray = [firstSub subviews];
    for (UIView *sub in subArray) {
        if ([sub isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
            UIButton *btn = (UIButton *)sub;
            [btn setTitle:@"取消" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn setBackgroundImage:[UIImage imageNamed:@"buttonbar_action@2x"] forState:UIControlStateNormal];
        }
    }
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    searchBar.showsCancelButton = NO;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    //重新下载数据
    self.keyword = searchBar.text;
    _curPage = 1;
    [self downloadData];
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
