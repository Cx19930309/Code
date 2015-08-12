//
//  LimitFreeViewController.m
//  Limit_1509
//
//  Created by qianfeng on 15/7/27.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LimitFreeViewController.h"
#import "LimitModel.h"
#import "LimitCell.h"
#import "SearchViewController.h"
#import "DetailViewController.h"
#import "SettingViewController.h"

@interface LimitFreeViewController () <MyDownloaderDelegate,UISearchBarDelegate,CategoryViewControllerDelegate>

//选中类型Id
@property (nonatomic,strong)NSString *cateId;
//标题控件
@property (nonatomic,strong)UILabel *titleLabel;

@end

@implementation LimitFreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //导航
    [self createMyNav];
    
    //搜索框
    [self createSearchBar];
    //[self downloadData];
}

//搜索框
- (void)createSearchBar {
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 375, 40)];
    //设置代理
    searchBar.delegate = self;
    //设置默认文字
    searchBar.placeholder = @"60万应用搜搜看";
    _tbView.tableHeaderView = searchBar;
}

//下载数据
- (void)downloadData {
    //修改下载状态
    _isLoading = YES;
    
    MyDownloader *downloader = [[MyDownloader alloc]init];
    downloader.delegate = self;
    
    NSString *urlString = [NSString stringWithFormat:kLimitUrl,_curPage];
    if (self.cateId) {
        //修改下载链接
        urlString = [NSString stringWithFormat:@"%@&category_id=%@",urlString, self.cateId];
    }
    [downloader downloadWithUrlString:urlString];
}

//创建导航
- (void)createMyNav {
    //标题
    self.titleLabel = [self addNavTitle:CGRectMake(0, 0, 255, 44) title:@"限免"];
    //分类
    [self addNavBtn:CGRectMake(0, 0, 60, 30) title:@"分类" target:self action:@selector(gotoCategory:) isLeft:YES];
    //设置
    [self addNavBtn:CGRectMake(0, 0, 60, 30) title:@"设置" target:self action:@selector(gotoSet:) isLeft:NO];
}

//分类
- (void)gotoCategory:(id)sender {
    //跳转分类界面
    CategoryViewController *cateCtrl = [[CategoryViewController alloc]init];
    cateCtrl.titleString = @"限免分类";
    cateCtrl.urlString = kCategoryLimitUrl;
    //设置代理
    cateCtrl.delegate = self;
    
    [self.navigationController pushViewController:cateCtrl animated:YES];
}

//设置
- (void)gotoSet:(id)sender {
    SettingViewController *setCtrl = [[SettingViewController alloc]init];
    [self.navigationController pushViewController:setCtrl animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MyDownloader代理
- (void)downloaderFail:(MyDownloader *)downloader failWithError:(NSError *)error {
    NSLog(@"%@", error);
    //修改下载状态
    _isLoading = NO;
    
    [_headerView endRefreshing];
    [_footerView endRefreshing];
}

- (void)downloaderFinish:(MyDownloader *)downloader {
    //下拉刷新
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
        
        //修改下载状态
        _isLoading = NO;
        
        [_headerView endRefreshing];
        [_footerView endRefreshing];
        
    }
}

#pragma mark - UITableView代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *limitCellId = @"limitCellId";
    LimitCell *cell = [tableView dequeueReusableCellWithIdentifier:limitCellId];
    if (nil == cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"LimitCell" owner:nil options:nil] lastObject];
    }
    //模型对象
    LimitModel *model = _dataArray[indexPath.row];
    [cell configModel:model index:indexPath.row cutLength:2];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //获取模型对象
    LimitModel *model = _dataArray[indexPath.row];
    //跳转详情界面
    DetailViewController *dCtrl = [[DetailViewController alloc]init];
    dCtrl.applicationId = model.applicationId;
    
    [self.navigationController pushViewController:dCtrl animated:YES];
}

#pragma mark -MJRefreshBaseView代理
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

#pragma nark -UISearchBar代理
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    //显示取消按钮
    searchBar.showsCancelButton = YES;
    UIView *firstSub = [searchBar.subviews lastObject];
    for (UIView *sub in firstSub.subviews) {
        //是否是取消按钮
        Class cls = NSClassFromString(@"UINavigationButton");
        if ([sub isKindOfClass:cls]) {
            //转换成按钮
            UIButton *btn = (UIButton *)sub;
            //设置文字
            [btn setTitle:@"取消" forState:UIControlStateNormal];
            //设置背景图片
            [btn setBackgroundImage:[UIImage imageNamed:@"buttonbar_action@2x"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
        }
    }
}

//点击取消按钮
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    searchBar.showsCancelButton = NO;
}

//搜索操作
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    searchBar.showsCancelButton = NO;
    //跳转到所搜结果界面
    SearchViewController *ctrl = [[SearchViewController alloc]init];
    ctrl.keyword = searchBar.text;
    //类型(限免)
    ctrl.type = SearchTypeLimit;
    
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
        self.titleLabel.text = [NSString stringWithFormat:@"限免-%@",cateName];
    } else {
        self.titleLabel.text = @"限免";
    }
    //重新下载数据
    _curPage = 1;
    [_tbView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
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
