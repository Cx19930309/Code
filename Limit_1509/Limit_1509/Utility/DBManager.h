//
//  DBManager.h
//  Limit_1509
//
//  Created by qianfeng on 15/8/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "CollectItem.h"
@interface DBManager : NSObject

//获取单例对象
+ (DBManager *)sharedInstance;

//增加
- (void)addCollect:(CollectItem *)cItem;
//判断是否收藏
- (BOOL)isAppFavorite:(NSString *)appId;
//查询所有收藏的数据
- (NSArray *)searchAllFavoriteApps;
//删除数据
- (void)deleteAppWithAppId:(NSString *)appId;


@end
