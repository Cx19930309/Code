//
//  FreeViewController.m
//  Limit_1509
//
//  Created by qianfeng on 15/7/27.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "FreeViewController.h"
#import "LimitModel.h"
#import "FreeCell.h"
#import "SearchViewController.h"
#import "DetailViewController.h"
#import "CategoryViewController.h"
#import "SettingViewController.h"

@interface FreeViewController () <MyDownloaderDelegate,UISearchBarDelegate,CategoryViewControllerDelegate>

@property (nonatomic,strong)NSString *cateId;
@property (nonatomic,strong)UILabel *titleLabel;

@end

@implementation FreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createMyNav];
    
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
    self.titleLabel = [self addNavTitle:CGRectMake(60, 0, 255, 44) title:@"免费"];
    //设置
    [self addNavBtn:CGRectMake(0, 0, 60, 30) title:@"设置" target:self action:@selector(gotoSet:) isLeft:NO];
    
}

//分类
- (void)gotoCategory:(id)sender {
    CategoryViewController *cateCtrl = [[CategoryViewController alloc]init];
    cateCtrl.titleString = @"免费分类";
    cateCtrl.urlString = kCategoryFreeUrl;
    
    cateCtrl.delegate = self;
    
    [self.navigationController pushViewController:cateCtrl animated:YES];
}

//设置
- (void)gotoSet:(id)sender {
    SettingViewController *setCtrl = [[SettingViewController alloc]init];
    [self.navigationController pushViewController:setCtrl animated:YES];
}

- (void)downloadData {
    MyDownloader *downloader = [[MyDownloader alloc]init];
    downloader.delegate = self;
    NSString *urlSrtring = [NSString stringWithFormat:kFreeUrl,_curPage];
    if (self.cateId) {
        urlSrtring = [NSString stringWithFormat:@"%@&category_id=%@",urlSrtring, self.cateId];
    }
    [downloader downloadWithUrlString:urlSrtring];
    
}

- (void)downloaderFail:(MyDownloader *)downloader failWithError:(NSError *)error {
    NSLog(@"error:%@",error);
    //修改下载状态
    _isLoading = NO;
    
    [_headerView endRefreshing];
    [_footerView endRefreshing];
}

- (void)downloaderFinish:(MyDownloader *)downloader {
    if (_curPage == 1) {
        [_dataArray removeAllObjects];
    }
    id result = [NSJSONSerialization JSONObjectWithData:downloader.receiveData options:NSJSONReadingMutableContainers error:nil];
    if ([result isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = result;
        for (NSDictionary *appDict in dict[@"applications"]) {
            LimitModel *model = [[LimitModel alloc]init];
            [model setValuesForKeysWithDictionary:appDict];
            [_dataArray addObject:model];
        }
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
    static NSString *cellId = @"freeCellId";
    FreeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (nil == cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FreeCell" owner:nil options:nil] lastObject];
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
    ctrl.type = SearchTypeFree;
    
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
        self.titleLabel.text = [NSString stringWithFormat:@"免费-%@",cateName];
    } else {
        self.titleLabel.text = @"免费";
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
