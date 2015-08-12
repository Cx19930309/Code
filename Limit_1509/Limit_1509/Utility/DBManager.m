//
//  DBManager.m
//  Limit_1509
//
//  Created by qianfeng on 15/8/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager
{
    //数据库操作对象
    FMDatabase *_myDataBase;
}
+ (DBManager *)sharedInstance {
    static DBManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //代码在程序运行中只会执行一次
        if (manager == nil) {
            manager = [[DBManager alloc]init];
        }
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        //初始化数据库操作的对象
        [self createDataBase];
    }
    return self;
}

//初始化数据库操作对象
- (void)createDataBase {
    //本地数据库文件
    NSString *dbPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/app.sqlite"];
    NSLog(@"%@", dbPath);
    //创建FMDataBase对象
    _myDataBase = [[FMDatabase alloc]initWithPath:dbPath];
    
    //打开数据库
    BOOL ret = [_myDataBase open];
    if (ret) {
        //数据库打开正常
        
        //创建表(对应于代码中的一个类)
        //表名:collect
        //字段:id(数据库序号)、applicationId(应用的id)、name(应用的名字)、image(图片)
        NSString *createSql = @"create table if not exists collect(id integer primary key autoincrement,applicationId varchar(255),name varchar(255),image blob)";
        BOOL flag = [_myDataBase executeUpdate:createSql];
        if (flag) {
            
        } else {
            NSLog(@"表格创建失败");
        }
    } else {
        //数据库打开失败
        NSLog(@"数据库打开失败");
    }
}

//增加
- (void)addCollect:(CollectItem *)cItem {
    NSString *insertSql = @"insert into collect (applicationId,name,image) values(?,?,?)";
    NSData *data = UIImagePNGRepresentation(cItem.image);
    BOOL ret = [_myDataBase executeUpdate:insertSql,cItem.applicationId,cItem.name,data];
    if (!ret) {
        NSLog(@"insert error:%@",_myDataBase.lastErrorMessage);
    }
}

//判断是否收藏
- (BOOL)isAppFavorite:(NSString *)appId {
    /*
     NSString *selectSql = @"select * from collect where applicationId = ?";
     FMResultSet *set = [_myDataBase executeQuery:selectSql,appId];
     return [set next];
     */
    NSString *selectSql = @"select count(*) as cnt from collect where applicationId = ?";
    FMResultSet *set = [_myDataBase executeQuery:selectSql,appId];
    //获取记录个数
    int count = 0;
    if ([set next]) {
        count = [set intForColumn:@"cnt"];
    }
    if (count > 0) {
        return YES;
    }
    return NO;
}

- (NSArray *)searchAllFavoriteApps {
    NSString *selectSql = @"select * from collect";
    //存储查询结果
    NSMutableArray *resultArray = [NSMutableArray array];
    FMResultSet *set = [_myDataBase executeQuery:selectSql];
    while ([set next]) {
        //创建一个对象
        CollectItem *cItem = [[CollectItem alloc]init];
        cItem.collectId = [set intForColumn:@"id"];
        cItem.applicationId = [set stringForColumn:@"applicationId"];
        cItem.name = [set stringForColumn:@"name"];
        
        NSData *data = [set dataForColumn:@"image"];
        cItem.image = [UIImage imageWithData:data];
        //添加到数组中
        [resultArray addObject:cItem];
    }
    return [resultArray copy];
}

- (void)deleteAppWithAppId:(NSString *)appId {
    NSString *deleteSql = @"delete from collect where applicationId = ?";
    BOOL ret = [_myDataBase executeUpdate:deleteSql,appId];
    if (!ret) {
        NSLog(@"delete error:%@", _myDataBase.lastErrorMessage);
    }
}

@end
