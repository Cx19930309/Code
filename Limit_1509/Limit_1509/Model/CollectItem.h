//
//  CollectItem.h
//  LimitFree
//
//  Created by gaokunpeng on 15/1/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//与数据库里面的表格app对应的数据模型类
@interface CollectItem : NSObject

@property (nonatomic,assign)int collectId;
@property (nonatomic,strong)NSString *applicationId;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)UIImage *image;



@end
