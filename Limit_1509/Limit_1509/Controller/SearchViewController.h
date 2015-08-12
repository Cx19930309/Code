//
//  SearchViewController.h
//  Limit_1509
//
//  Created by qianfeng on 15/7/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BaseViewController.h"

//枚举类型,区分从哪个界面进入搜索界面

typedef NS_ENUM(NSInteger, SearchType) {
    SearchTypeLimit = 10,//限免
    SearchTypeReduce,//降价
    SearchTypeFree,//免费
    SearchTypeHot//热榜
};

@interface SearchViewController : BaseViewController

//搜索关键词
@property (nonatomic,strong)NSString *keyword;
//类型
@property (nonatomic,assign)SearchType type;

@end
