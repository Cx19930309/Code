//
//  CategoryItem.h
//  LimitFree
//
//  Created by gaokunpeng on 15/1/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryItem : NSObject

@property (nonatomic,copy)NSString *categoryId;
@property (nonatomic,copy)NSString *categoryName;
@property (nonatomic,copy)NSString *count;
@property (nonatomic,copy)NSString *lessenPrice;
/*
 "categoryId": "0",
 "categoryName": "全部",
 "count": "3",
 "lessenPrice": "36"
 */

@end
