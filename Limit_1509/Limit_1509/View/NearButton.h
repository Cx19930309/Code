//
//  NearButton.h
//  Limit_1509
//
//  Created by qianfeng on 15/7/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LimitModel.h"

@interface NearButton : UIControl
{
    //图片
    UIImageView *_appImageView;
    //文字
    UILabel *_nameLabel;
}

@property (nonatomic,strong)LimitModel *appModel;

@end
