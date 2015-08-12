//
//  MyNavController.m
//  TestIpaDown
//
//  Created by gaokunpeng on 15/8/2.
//  Copyright (c) 2015年 gaokunpeng. All rights reserved.
//

#import "MyNavController.h"

@interface MyNavController ()

@end

@implementation MyNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
}

-(void)addNavLabelTitle:(NSString *)title
{
    UILabel *label = [MyUtil createLabelFrame:CGRectMake(80, 20, 215, 44) title:title font:[UIFont boldSystemFontOfSize:28]];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    
}

-(void)addBackBtnTarget:(id)target action:(SEL)action
{
    UIButton *btn = [MyUtil createBtnFrame:CGRectMake(0, 0, 60, 36) title:@"返回" bgImageName:@"backButton" target:target action:action];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.navigationItem.leftBarButtonItem = item;
}

-(UIButton *)addnavBtnTitle:(NSString *)title bgImageName:(NSString *)bgImageName target:(id)target action:(SEL)action
{
    UIButton *btn = [MyUtil createBtnFrame:CGRectMake(0, 0, 60, 36) title:title bgImageName:bgImageName target:target action:action];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.navigationItem.rightBarButtonItem = item;
    
    return btn;
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
