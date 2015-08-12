//
//  SettingViewController.m
//  Limit_1509
//
//  Created by qianfeng on 15/8/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SettingViewController.h"
#import "MyUtil.h"
#import "CollectViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //导航
    [self createMyNav];
    
    //按钮
    [self createBtns];
    
    //设置背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
}

//导航
- (void)createMyNav {
    //返回按钮
    UIButton *backBtn = [self addNavBtn:CGRectMake(0, 0, 60, 30) title:@"返回" target:self action:@selector(backAction:) isLeft:YES];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"buttonbar_back"] forState:UIControlStateNormal];
    
    //标题
    [self addNavTitle:CGRectMake(60, 0, 255, 44) title:@"设置"];
}

- (void)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//按钮创建
- (void)createBtns {
    NSArray *imageArray = @[@"account_setting@2x",@"account_favorite@2x",@"account_user@2x",@"account_collect@2x",@"account_download@2x",@"account_comment@2x",@"account_help@2x",@"account_candou@2x"];
    NSArray *nameArray = @[@"我的设置",@"我的关注",@"我的账号",@"我的收藏",@"我的下载",@"我的评论",@"我的帮助",@"蚕豆应用"];
    //循环创建按钮
    CGFloat width = 60;
    CGFloat height = 80;
    CGFloat spaceX = 45;
    CGFloat spaceY = 80;
    /*
     btn1:(40,64+40,width,height)
     btn2:(60+width+spaceX,64+40,width,height)
     btn3:(60+width+spaceX+width+spaceX,64+40,width,height)
     btn4:(60,60+40+(height+spaceY)*1,width,height)
     */
    for (int i=0; i<imageArray.count; i++) {
        //计算按钮的frame
        //行
        int row = i/3;
        //列
        int col = i%3;
        CGRect frame = CGRectMake(60+(width+spaceX)*col, 64+40+(height+spaceY)*row, width, height);
        UIButton *btn = [MyUtil createBtnFrame:frame title:nil bgImageName:nil target:self action:@selector(clickBtn:)];
        btn.tag = 300+i;
        
        //图片
        UIImageView *imageView = [MyUtil createImageViewFrame:CGRectMake(0, 0, 60, 60) imageName:imageArray[i]];
        [btn addSubview:imageView];
        
        //文字
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(0, 60, 60, 20) title:nameArray[i] font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentCenter numberOfLines:1 textColor:[UIColor blackColor]];
        [btn addSubview:label];
        
        [self.view addSubview:btn];
    }
    
}

- (void)clickBtn:(UIButton *)btn {
    NSInteger index = btn.tag-300;
    NSLog(@"点击了第%ld个按钮", index+1);
    if (index == 3) {
        //跳转收藏界面
        CollectViewController *collCtrl = [[CollectViewController alloc]init];
        [self.navigationController pushViewController:collCtrl animated:YES];
    }
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
