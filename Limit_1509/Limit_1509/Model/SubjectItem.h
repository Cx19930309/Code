//
//  SubjectItem.h
//  LimitFree
//
//  Created by gaokunpeng on 15/1/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

//专题的模型类
@interface SubjectItem : NSObject

@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *img;
@property (nonatomic,copy)NSString *desc_img;
@property (nonatomic,copy)NSString *desc;
@property (nonatomic,copy)NSString *date;

@property (nonatomic,strong)NSArray *appArray;



@end

//应用的模型类
@interface AppItem : NSObject


@property (nonatomic,copy)NSString *applicationId;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *iconUrl;
@property (nonatomic,copy)NSString *starOverall;
@property (nonatomic,copy)NSString *ratingOverall;
@property (nonatomic,copy)NSString *downloads;
@property (nonatomic,strong)NSNumber *comment;




@end
