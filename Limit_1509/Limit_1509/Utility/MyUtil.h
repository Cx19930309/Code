//
//  MyUtil.h
//  Limit_1509
//
//  Created by qianfeng on 15/7/27.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MyUtil : NSObject

/*
 @param frame:控件的位置
 @param title:标签的文字
 @param font:字体大小
 @param textAlignment:对齐方式
 @param numberOfLines:显示行数
 @param textColor:文字颜色
*/
//创建标签的方法
+ (UILabel *)createLabelFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font textAlignment:(NSTextAlignment)alignment numberOfLines:(NSInteger)numbersOfLines textColor:(UIColor *)textColor;

+ (UILabel *)createLabelFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font;

//创建按钮的方法
/*
 @param frame:控件的位置
 @param title:按钮的文字
 @param bgImageName:按钮背景图片
 @param target:
 @param action:点击事件
*/
+ (UIButton *)createBtnFrame:(CGRect)frame title:(NSString *)title bgImageName:(NSString *)bgImageName target:(id)target action:(SEL)action;

//创建图片视图
+ (UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName;

+ (NSString *)transferCateName:(NSString *)name;







@end
