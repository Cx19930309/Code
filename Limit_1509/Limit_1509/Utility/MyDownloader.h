//
//  MyDownloader.h
//  Limit_1509
//
//  Created by qianfeng on 15/7/27.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyDownloader;

@protocol MyDownloaderDelegate <NSObject>

//下载失败
- (void)downloaderFail:(MyDownloader *)downloader failWithError:(NSError *)error;

//下载成功,并且下载结束
- (void)downloaderFinish:(MyDownloader *)downloader;

@end

//NSURLConnectionDelegate协议用来处理下载是成功还是失败
//NSURLConnectionDataDelegate协议用来处理下载成功时的网络返回的数据
@interface MyDownloader : NSObject <NSURLConnectionDelegate,NSURLConnectionDataDelegate>

//下载的方法
/*
 @param urlString:下载链接的字符串
 */
- (void)downloadWithUrlString:(NSString *)urlString;

/*
        基本类型    代理属性    其他对象
 MRC    assign     assign    retain
 ARC    assign     weak      strong
 */
//代理属性
@property (nonatomic,weak)id<MyDownloaderDelegate>delegate;
//获取下载回来的数据
//readonly表示只会自动生成getter方法
@property (nonatomic,readonly)NSData *receiveData;

//类型
@property (nonatomic,assign)NSInteger type;


@end
