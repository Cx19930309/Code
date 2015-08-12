//
//  MyUtil.h
//  TestIpaDown
//
//  Created by gaokunpeng on 15/8/2.
//  Copyright (c) 2015年 gaokunpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MyUtil : NSObject

+ (UILabel *)createLabelFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font;

+ (UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName;

+ (UIButton *)createBtnFrame:(CGRect)frame title:(NSString *)title bgImageName:(NSString *)bgImageName target:(id)target action:(SEL)action;

@end
