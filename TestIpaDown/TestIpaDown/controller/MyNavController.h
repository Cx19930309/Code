//
//  MyNavController.h
//  TestIpaDown
//
//  Created by gaokunpeng on 15/8/2.
//  Copyright (c) 2015年 gaokunpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Const.h"
#import "MyUtil.h"

@interface MyNavController : UIViewController

//标题
- (void)addNavLabelTitle:(NSString *)title;
//返回按钮
- (void)addBackBtnTarget:(id)target action:(SEL)action;

- (UIButton *)addnavBtnTitle:(NSString *)title bgImageName:(NSString *)bgImageName target:(id)target action:(SEL)action;


@end
