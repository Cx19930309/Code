//
//  PhotoViewController.m
//  Limit_1509
//
//  Created by qianfeng on 15/7/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "PhotoViewController.h"
#import "MyUtil.h"
#import "DetailItem.h"
#import "UIImageView+WebCache.h"

@interface PhotoViewController () <UIScrollViewDelegate>
{
    UIPageControl *_pageControl;
    UIActivityIndicatorView *_activity;
}
@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    //导航
    [self createMyNav];
    //显示图片
    [self createPhoto];
}

//显示图片
- (void)createPhoto {
    _activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _activity.frame = CGRectMake(self.view.bounds.size.width/2, 350, 0, 0);
    [_activity startAnimating];
    [self.view addSubview:_activity];
    
    //滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 200, 375, 300)];
    [self.view addSubview:scrollView];
    //设置代理
    scrollView.delegate = self;
    for (int i=0; i<self.photoArray.count; i++) {
        //图片数据对象
        PhotoItem *pItem = self.photoArray[i];
        //图片
        CGRect frame = CGRectMake(375*i, 0, 375, 300);
        
        UIImageView *tmpImageView = [MyUtil createImageViewFrame:frame imageName:nil];
        [tmpImageView sd_setImageWithURL:[NSURL URLWithString:pItem.originalUrl]];
        [scrollView addSubview:tmpImageView];
    }
    scrollView.pagingEnabled = YES;
    //滚动范围
    scrollView.contentSize = CGSizeMake(375*self.photoArray.count, 300);
    
    //显示到当前点击的序号
    scrollView.contentOffset = CGPointMake(375*self.index, 0);
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 500, 375, 30)];
    _pageControl.numberOfPages = self.photoArray.count;
    _pageControl.currentPage = self.index;
    [self.view addSubview:_pageControl];
}

#pragma mark -UIScrollView代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x/scrollView.bounds.size.width;
    //修改标题文字
    UIImageView *bgImageView = (UIImageView *)[self.view viewWithTag:500];
    UILabel *titleLabel = (UILabel *)[bgImageView viewWithTag:600];
    titleLabel.text = [NSString stringWithFormat:@"%ld / %ld", index+1, self.photoArray.count];
    
    _pageControl.currentPage = index;
}

#pragma mark -状态栏
- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

//导航
- (void)createMyNav {
    //背景图片
    UIImageView *bgImageView = [MyUtil createImageViewFrame:CGRectMake(0, 20, 375, 44) imageName:@"navigationbar"];
    bgImageView.userInteractionEnabled = YES;
    bgImageView.tag = 500;
    [self.view addSubview:bgImageView];
    
    //文字
    NSString *title = [NSString stringWithFormat:@"%ld / %ld", self.index+1, self.photoArray.count];
    UILabel *titleLabel = [MyUtil createLabelFrame:CGRectMake(100, 0, 175, 44) title:title font:[UIFont systemFontOfSize:20]];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.tag = 600;
    [bgImageView addSubview:titleLabel];
    
    //按钮
    UIButton *btn = [MyUtil createBtnFrame:CGRectMake(275, 4, 60, 30) title:@"done" bgImageName:@"buttonbar_action" target:self action:@selector(clickBtn:)];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bgImageView addSubview:btn];
}

- (void)clickBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
