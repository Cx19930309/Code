//
//  CategoryModel.h
//  TestIpaDown
//
//  Created by gaokunpeng on 15/8/2.
//  Copyright (c) 2015年 gaokunpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryModel : NSObject

@property (nonatomic,strong)NSString *header;

@property (nonatomic,strong)NSArray *typeArray;

@end

@interface CategoryType : NSObject

@property (nonatomic,strong)NSString *desc;
@property (nonatomic,strong)NSString *icon;
@property (nonatomic,strong)NSString *querystr;
@property (nonatomic,strong)NSString *title;

/*
 "desc": "共有应用47436个,还在限免7659个",
 "icon": "http://a5.mzstatic.com/us/r1000/061/Purple/v4/c7/5a/43/c75a4313-efe6-2728-24a3-eefb15d2bd1b/mzl.gmkuqwbk.175x175-75.jpg",
 "querystr": "cate=soft",
 "title": "全部应用"
 */

@end
