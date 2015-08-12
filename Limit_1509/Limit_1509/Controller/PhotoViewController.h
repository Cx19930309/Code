//
//  PhotoViewController.h
//  Limit_1509
//
//  Created by qianfeng on 15/7/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController

//图片数组
@property (nonatomic,strong)NSArray *photoArray;
//点击的序号
@property (nonatomic,assign)NSInteger index;

@end
