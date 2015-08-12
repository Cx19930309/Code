//
//  CollectViewController.m
//  Limit_1509
//
//  Created by qianfeng on 15/8/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CollectViewController.h"
#import "DBManager.h"
#import "CollectBtn.h"
#import "DetailViewController.h"

@interface CollectViewController () <CollectBtnDelegate,UIScrollViewDelegate>
{
    //显示应用信息的滚动视图
    UIScrollView *_scrollView;
    //编辑按钮
    UIButton *_editBtn;
    //页数的显示
    UIPageControl *_pageControl;
}

//数据源
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation CollectViewController

//懒加载
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //导航
    [self createMyNav];
    //滚动视图
    [self createScrollView];
    //查询数据
    [self searchApps];
    
    //背景颜色
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
}

- (void)createScrollView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, 375, 667-64-49)];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    //页数的显示
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(60, 550, 255, 40)];
    _pageControl.currentPage = 0;
    [self.view addSubview:_pageControl];
}

//查询所有的数据
- (void)searchApps {
    
    //dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) 获取系统并行线程队列
    //dispatch_async 异步执行线程
    //dispatch_get_main_queue() 返回主线程
    //self的弱引用
    __weak CollectViewController *weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *array = [[DBManager sharedInstance]searchAllFavoriteApps];
        weakSelf.dataArray = [NSMutableArray arrayWithArray:array];
        dispatch_async(dispatch_get_main_queue(), ^{
            //显示数据
            [weakSelf createBtns];
        });
        
    });
    
}

//显示数据
- (void)createBtns {
    //删除之前的按钮
    for (UIView *sub in _scrollView.subviews) {
        if ([sub isKindOfClass:[CollectBtn class]]) {
            [sub removeFromSuperview];
        }
    }
    //循环创建按钮
    CGFloat w = 80;
    CGFloat h = 100;
    CGFloat spaceX = 25;
    CGFloat spaceY = 60;
    for (int i=0; i<self.dataArray.count; i++) {
        //获取模型对象
        CollectItem *cItem = self.dataArray[i];
        //第几页
        int page = i/9;
        int rowAndCol = i%9;
        //行
        int row = rowAndCol/3;
        //列
        int col = rowAndCol%3;
        //按钮
        CGRect frame = CGRectMake(page*375+35+(w+spaceX)*col, 40+(h+spaceY)*row, w, h);
        CollectBtn *btn = [[CollectBtn alloc]initWithFrame:frame];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 300+i;
        btn.cItem = cItem;
        if ([[_editBtn titleForState:UIControlStateNormal] isEqualToString:@"编辑"]) {
            btn.edit = NO;
        } else {
            btn.edit = YES;
        }
        //设置代理
        btn.delegate = self;
        [_scrollView addSubview:btn];
    }
    //设置滚动范围
    //总页数
    NSInteger cnt = self.dataArray.count/9;
    if (self.dataArray.count%9 > 0) {
        cnt++;
    }
    _scrollView.contentSize = CGSizeMake(375*cnt, _scrollView.bounds.size.height);
    //设置最大页数
    _pageControl.numberOfPages = cnt;
}

- (void)clickBtn:(CollectBtn *)btn {
    //如果正在编辑,不让跳转
    if ([[_editBtn currentTitle]isEqualToString:@"完成"]) {
        return;
    }
    
    NSInteger index = btn.tag-300;
    //获取模型对象
    CollectItem *cItem = self.dataArray[index];
    //跳转详情
    DetailViewController *detailCtrl = [[DetailViewController alloc]init];
    detailCtrl.applicationId = cItem.applicationId;
    
    self.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:detailCtrl animated:YES];
    
    self.hidesBottomBarWhenPushed = NO;
}

- (void)createMyNav {
    //返回按钮
    UIButton *backBtn = [self addNavBtn:CGRectMake(0, 0, 60, 30) title:@"返回" target:self action:@selector(backAction:) isLeft:YES];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"buttonbar_back"] forState:UIControlStateNormal];
    
    //标题
    [self addNavTitle:CGRectMake(60, 0, 255, 44) title:@"我的收藏"];
    //编辑按钮
    _editBtn = [self addNavBtn:CGRectMake(0, 0, 60, 30) title:@"编辑" target:self action:@selector(editAction:) isLeft:NO];
    
}

//返回
- (void)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//编辑
- (void)editAction:(id)sender {
    //进入编辑状态
    if ([_editBtn.currentTitle isEqualToString:@"编辑"]) {
        for (UIView *sub in _scrollView.subviews) {
            if ([sub isKindOfClass:[CollectBtn class]]) {
                //设置为编辑状态
                CollectBtn *btn = (CollectBtn *)sub;
                btn.edit = YES;
            }
        }
        //修改文字
        [_editBtn setTitle:@"完成" forState:UIControlStateNormal];
    } else {
        //结束编辑状态
        for (UIView *sub in _scrollView.subviews) {
            if ([sub isKindOfClass:[CollectBtn class]]) {
                CollectBtn *btn = (CollectBtn *)sub;
                btn.edit = NO;
            }
        }
        //修改文字
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    }
}

#pragma mark -CollectBtn代理
/*
- (void)didDeleteBtnWithAppId:(NSString *)applicationId {
    //根据applicationId删除收藏的app
    [[DBManager sharedInstance]deleteAppWithAppId:applicationId];
    //界面删除
    [self searchApps];
    
}
*/

- (void)didDeleteBtnWithIndex:(NSInteger)index {
    CollectItem *cItem = self.dataArray[index];
    //数据库删除
    [[DBManager sharedInstance]deleteAppWithAppId:cItem.applicationId];
    //界面删除
    [self.dataArray removeObjectAtIndex:index];
    //重新显示按钮
    [self createBtns];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x/scrollView.bounds.size.width;
    _pageControl.currentPage = index;
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
