//
//  LFNavController.h
//  Limit_1509
//
//  Created by qianfeng on 15/7/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Const.h"
#import "MyDownloader.h"

@interface LFNavController : UIViewController

//添加导航上面的按钮
/*
 @param isLeft:是左边按钮还是右边按钮
 */
- (UIButton *)addNavBtn:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)action isLeft:(BOOL)isLeft;

//添加导航上面的文字
- (UILabel *)addNavTitle:(CGRect)frame title:(NSString *)title;

@end
