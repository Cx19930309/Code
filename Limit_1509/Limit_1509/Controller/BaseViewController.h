//
//  BaseViewController.h
//  Limit_1509
//
//  Created by qianfeng on 15/7/27.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "LFNavController.h"
#import "CategoryViewController.h"

@interface BaseViewController : LFNavController <UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>
{
    //数据源数组
    NSMutableArray *_dataArray;
    //表格
    UITableView *_tbView;
    
    //下拉刷新
    MJRefreshHeaderView *_headerView;
    //上拉加载
    MJRefreshFooterView *_footerView;
    
    //是否正在加载
    BOOL _isLoading;
    //当前的页数
    NSInteger _curPage;
}

@end
