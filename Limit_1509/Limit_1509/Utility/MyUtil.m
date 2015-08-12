//
//  MyUtil.m
//  Limit_1509
//
//  Created by qianfeng on 15/7/27.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MyUtil.h"

@implementation MyUtil

+ (UILabel *)createLabelFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font textAlignment:(NSTextAlignment)alignment numberOfLines:(NSInteger)numbersOfLines textColor:(UIColor *)textColor {
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    if (title) {
        label.text = title;
    }
    if (font) {
        label.font = font;
    }
    
    label.textAlignment = alignment;
    label.numberOfLines = numbersOfLines;
    
    if (textColor) {
        label.textColor = textColor;
    }
    return label;
}

+ (UILabel *)createLabelFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font {
    UILabel *label = [self createLabelFrame:frame title:title font:font textAlignment:NSTextAlignmentLeft numberOfLines:1 textColor:[UIColor blackColor]];
    return label;
}

+ (UIButton *)createBtnFrame:(CGRect)frame title:(NSString *)title bgImageName:(NSString *)bgImageName target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    if (title) {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    if (target && action) {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    if (bgImageName) {
        [btn setBackgroundImage:[UIImage imageNamed:bgImageName] forState:UIControlStateNormal];
    }
    return btn;
}

+ (UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName {
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    if (imageName) {
        imageView.image = [UIImage imageNamed:imageName];
    }
    return imageView;
}

+ (NSString *)transferCateName:(NSString *)name
{
    
    if ([name isEqualToString:@"Business"]) {
        return @"商业";
    }else if ([name isEqualToString:@"Weather"]) {
        return @"天气";
    }else if ([name isEqualToString:@"Tool"]) {
        return @"工具";
    }else if ([name isEqualToString:@"Travel"]) {
        return @"旅行";
    }else if ([name isEqualToString:@"Sports"]) {
        return @"体育";
    }else if ([name isEqualToString:@"Social"]) {
        return @"社交";
    }else if ([name isEqualToString:@"Refer"]) {
        return @"参考";
    }else if ([name isEqualToString:@"Ability"]) {
        return @"效率";
    }else if ([name isEqualToString:@"Photography"]) {
        return @"摄影";
    }else if ([name isEqualToString:@"News"]) {
        return @"新闻";
    }else if ([name isEqualToString:@"Gps"]) {
        return @"导航";
    }else if ([name isEqualToString:@"Music"]) {
        return @"音乐";
    }else if ([name isEqualToString:@"Life"]) {
        return @"生活";
    }else if ([name isEqualToString:@"Health"]) {
        return @"健康";
    }else if ([name isEqualToString:@"Finance"]) {
        return @"财务";
    }else if ([name isEqualToString:@"Pastime"]) {
        return @"娱乐";
    }else if ([name isEqualToString:@"Education"]) {
        return @"教育";
    }else if ([name isEqualToString:@"Book"]) {
        return @"书籍";
    }else if ([name isEqualToString:@"Medical"]) {
        return @"医疗";
    }else if ([name isEqualToString:@"Catalogs"]) {
        return @"商品指南";
    }else if ([name isEqualToString:@"FoodDrink"]) {
        return @"美食";
    }else if ([name isEqualToString:@"Game"]) {
        return @"游戏";
    }else if([name isEqualToString:@"All"]){
        return @"全部";
    }
    
    return nil;
}

@end
