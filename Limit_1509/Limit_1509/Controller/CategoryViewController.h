//
//  CategoryViewController.h
//  Limit_1509
//
//  Created by qianfeng on 15/7/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LFNavController.h"

@protocol CategoryViewControllerDelegate <NSObject>

/*
 @param categroyId:类别的Id
 @param cateName:类别的名字
 */
- (void)didSelectCateId:(NSString *)categroyId cateName:(NSString *)cateName;

@end

@interface CategoryViewController : LFNavController

//标题文字
@property (nonatomic,strong)NSString *titleString;
//下载链接
@property (nonatomic,strong)NSString *urlString;
//代理的属性
@property (nonatomic,weak)id <CategoryViewControllerDelegate> delegate;

@end
