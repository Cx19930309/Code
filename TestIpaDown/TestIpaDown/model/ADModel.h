//
//  ADModel.h
//  TestIpaDown
//
//  Created by gaokunpeng on 15/8/2.
//  Copyright (c) 2015年 gaokunpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADModel : NSObject

@property (nonatomic,strong)NSString *type;

@property (nonatomic,strong)NSString *pic;

@property (nonatomic,strong,setter=setGoto:)NSString *jumpUrl;

@property (nonatomic,strong)NSString *title;

/*
 "type": "http",
 "pic": "http://file.ipadown.com/uploads/zt/20150731092812530.jpg",
 "goto": "http://www.ipadown.com/app-zhuanti/2015-7-30-best-apps",
 "title": "2015-7-30大作之夜 - 机智！ 怒鸟续作巧搭CJ顺风车"
 */

@end
