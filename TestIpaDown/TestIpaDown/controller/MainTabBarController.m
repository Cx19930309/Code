//
//  MainTabBarController.m
//  TestIpaDown
//
//  Created by gaokunpeng on 15/8/2.
//  Copyright (c) 2015年 gaokunpeng. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //创建试图控制器
    [self createViewControllers];
}


- (void)createViewControllers
{
    NSArray *ctrlArray = @[@"HomePageController",@"LimitViewController",@"CategoryViewController",@"RecommendViewController",@"MoreViewController"];
    NSArray *titleArray = @[@"首页",@"今日限免",@"分类",@"推荐",@"更多"];
    NSArray *imageArray = @[@"item_app_home",@"item_app_pricedrop",@"item_app_category",@"item_app_hot",@"item_app_more"];
    
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i=0; i<ctrlArray.count; i++) {
        //创建试图控制器
        NSString *clsName = ctrlArray[i];
        Class cls = NSClassFromString(clsName);
        
        UIViewController *ctrl = [[cls alloc] init];
        ctrl.tabBarItem.title = titleArray[i];
        ctrl.tabBarItem.image = [UIImage imageNamed:imageArray[i]];
        
        UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:ctrl];
        [array addObject:navCtrl];
        
    }
    
    self.viewControllers = array;
    
    
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
