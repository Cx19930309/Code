//
//  ReduceViewController.m
//  Limit_1509
//
//  Created by qianfeng on 15/7/27.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ReduceViewController.h"
#import "LimitModel.h"
#import "ReduceCell.h"
#import "SearchViewController.h"
#import "DetailViewController.h"
#import "CategoryViewController.h"
#import "SettingViewController.h"

@interface ReduceViewController () <MyDownloaderDelegate,UISearchBarDelegate,CategoryViewControllerDelegate>

//选中类型Id
@property (nonatomic,strong)NSString *cateId;
//标题控件
@property (nonatomic,strong)UILabel *titleLabel;

@end

@implementation ReduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //导航
    [self createMyNav];
    //下载数据
    //[self downloadData];
    
    [self createSearchBar];
}

- (void)createSearchBar {
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 375, 40)];
    searchBar.delegate = self;
    searchBar.placeholder = @"60万应用搜搜看";
    _tbView.tableHeaderView = searchBar;
}

//导航
- (void)createMyNav {
    //分类
    [self addNavBtn:CGRectMake(0, 0, 60, 30) title:@"分类" target:self action:@selector(gotoCategory:) isLeft:YES];
    //标题
    self.titleLabel = [self addNavTitle:CGRectMake(60, 0, 255, 44) title:@"降价"];
    //设置
    [self addNavBtn:CGRectMake(0, 0, 60, 30) title:@"设置" target:self action:@selector(gotoSet:) isLeft:NO];
}
//分类
- (void)gotoCategory:(id)sender {
    CategoryViewController *cateCtrl = [[CategoryViewController alloc]init];
    cateCtrl.titleString = @"降价分类";
    cateCtrl.urlString = kCategoryReduceUrl;
    cateCtrl.delegate = self;
    
    [self.navigationController pushViewController:cateCtrl animated:YES];
}

//设置
- (void)gotoSet:(id)sender {
    SettingViewController *setCtrl = [[SettingViewController alloc]init];
    [self.navigationController pushViewController:setCtrl animated:YES];
}

//下载数据
- (void)downloadData {
    //进入刷新状态
    _isLoading = YES;
    MyDownloader *downloader = [[MyDownloader alloc]init];
    downloader.delegate = self;
    
    NSString *urlString = [NSString stringWithFormat:kReduceUrl,_curPage];
    if (self.cateId) {
        urlString = [NSString stringWithFormat:@"%@&category_id=%@",urlString, self.cateId];
    }
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
    //下拉刷新
    //一定要写在下载数据返回的地方
    if (_curPage == 1) {
        [_dataArray removeAllObjects];
    }
    //JSON解析
    id result = [NSJSONSerialization JSONObjectWithData:downloader.receiveData options:NSJSONReadingMutableContainers error:nil];
    if ([result isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = result;
        NSArray *appArray = dict[@"applications"];
        for (NSDictionary *appDict in appArray) {
            //创建模型
            LimitModel *model = [[LimitModel alloc]init];
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

#pragma mark -UITableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"reduceCellId";
    ReduceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (nil == cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ReduceCell" owner:nil options:nil] lastObject];
    }
    //显示数据
    LimitModel *model = _dataArray[indexPath.row];
    [cell configModel:model index:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LimitModel *model = _dataArray[indexPath.row];
    //
    DetailViewController *dCtrl = [[DetailViewController alloc]init];
    dCtrl.applicationId = model.applicationId;
    [self.navigationController pushViewController:dCtrl animated:YES];
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

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
    UIView *firstSub = searchBar.subviews.lastObject;
    for (UIView *sub in firstSub.subviews) {
        if ([sub isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
            UIButton *btn = (UIButton *)sub;
            [btn setTitle:@"取消" forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
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
    searchBar.showsCancelButton = NO;
    SearchViewController *ctrl = [[SearchViewController alloc]init];
    ctrl.keyword = searchBar.text;
    ctrl.type = SearchTypeReduce;
    
    self.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:ctrl animated:YES];
    
    self.hidesBottomBarWhenPushed = NO;
    
    searchBar.text = @"";
    searchBar.showsCancelButton = NO;
}

- (void)didSelectCateId:(NSString *)categroyId cateName:(NSString *)cateName {
    self.cateId = categroyId;
    //修改标题
    if (![cateName isEqualToString:@"全部"]) {
        self.titleLabel.text = [NSString stringWithFormat:@"降价-%@",cateName];
    } else {
        self.titleLabel.text = @"降价";
    }
    //重新下载数据
    _curPage = 1;
    [_tbView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    [self downloadData];
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
