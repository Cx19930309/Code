//
//  BaseViewController.h
//  TestIpaDown
//
//  Created by gaokunpeng on 15/8/2.
//  Copyright (c) 2015年 gaokunpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyNavController.h"
#import "MJRefresh.h"

@interface BaseViewController : MyNavController<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>

//列表
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UITableView *tbView;

//下拉刷新
@property (nonatomic,assign)NSInteger curPage;
@property (nonatomic,assign)NSInteger pageSize;
@property (nonatomic,assign)BOOL isLoading;
@property (nonatomic,strong)MJRefreshHeaderView *headerView;
@property (nonatomic,strong)MJRefreshFooterView *footerView;


//下拉刷新
- (void)addRefresh;

//下载列表数据
- (void)downloadData;

- (void)refreshHeader;


@end
