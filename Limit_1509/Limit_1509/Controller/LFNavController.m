//
//  LFNavController.m
//  Limit_1509
//
//  Created by qianfeng on 15/7/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LFNavController.h"
#import "MyUtil.h"

@interface LFNavController ()

@end

@implementation LFNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (UIButton *)addNavBtn:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)action isLeft:(BOOL)isLeft {
    //按钮
    UIButton *btn = [MyUtil createBtnFrame:frame title:title bgImageName:@"buttonbar_action" target:target action:action];
    
    //设置颜色
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    //UIBarButtonItem
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    if (isLeft) {
        self.navigationItem.leftBarButtonItem = item;
    } else {
        self.navigationItem.rightBarButtonItem = item;
    }
    
    return btn;
}

- (UILabel *)addNavTitle:(CGRect)frame title:(NSString *)title {
    //字体
    UIFont *font = [UIFont boldSystemFontOfSize:22];
    //颜色
    UIColor *color = [UIColor colorWithRed:80.0f/255.0f green:180.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    UILabel *label = [MyUtil createLabelFrame:frame title:title font:font textAlignment:NSTextAlignmentCenter numberOfLines:1 textColor:color];
    self.navigationItem.titleView = label;
    return label;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
