//
//  RecommendViewController.m
//  TestIpaDown
//
//  Created by gaokunpeng on 15/8/2.
//  Copyright (c) 2015年 gaokunpeng. All rights reserved.
//

#import "RecommendViewController.h"
#import "MyUtil.h"
#import "DailyViewController.h"

@interface RecommendViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIPageControl *pageCtrl;

@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //导航
    [self addNavLabelTitle:@"精品栏目推荐"];
    
    
    //九宫格
    [self createBtns];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}


//九宫格
- (void)createBtns
{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    //创建滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 375, 667-64-49)];
    scrollView.delegate = self;
//    scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrollView];
    
    NSArray *nameArray = @[@"每日一荐",@"本周热门应用",@"本周热门游戏",@"上榜精品",@"GameCenter游戏",@"装机必备",@"知名网站客户端",@"五星好评应用",@"随便看看",@"i派党移动版",@"苹果新闻",@"iphone4壁纸",@"用户交流QQ群",@"i派党移动微博"];
    NSArray *imageArray = @[@"i-commend",@"i-soft",@"i-game",@"i-top",@"i-gamecenter",@"i-musthave",@"i-famous",@"i-star",@"i-random",@"i-ipadown",@"i-news",@"i-download",@"i-qqgroup",@"i-sinaweibo"];
    
    //循环创建按钮
    CGFloat w = 105;
    CGFloat h = 100;
    CGFloat spaceX = 10;
    CGFloat spaceY = 10;
    
    for (NSInteger i=0; i<nameArray.count; i++) {
        
        //页
        NSInteger pageIndex = i/12;
        NSInteger rowAndCol = i%12;
        //行
        NSInteger row = rowAndCol/3;
        NSInteger col = rowAndCol%3;
        
        NSString *title = nameArray[i];
        NSString *imageName = imageArray[i];
        
        CGRect frame = CGRectMake(20+pageIndex*375+col*(w+spaceX)+26, 40+row*(h+spaceY), 50, 50);
        UIButton *btn = [MyUtil createBtnFrame:frame title:nil bgImageName:imageName target:self action:@selector(clickBtn:)];
        btn.tag = 300+i;
        [scrollView addSubview:btn];
        
        
        CGRect labelFrame = CGRectMake(20+pageIndex*375+col*(w+spaceX), 40+row*(h+spaceY)+60, w, 30);
        UILabel *label = [MyUtil createLabelFrame:labelFrame title:title font:[UIFont systemFontOfSize:12]];
        label.text = title;
        label.textAlignment = NSTextAlignmentCenter;
        label.adjustsFontSizeToFitWidth = YES;
        [scrollView addSubview:label];
        
    }
    //一共多少页
    NSInteger pageCnt = nameArray.count/12;
    if (nameArray.count%12 > 0) {
        pageCnt++;
    }
    scrollView.contentSize = CGSizeMake(375*pageCnt, scrollView.bounds.size.height);
    
    //显示页数
    
    self.pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 510, 375, 40)];
    self.pageCtrl.numberOfPages = pageCnt;
    [self.view addSubview:self.pageCtrl];
    
}

- (void)clickBtn:(UIButton *)sender
{
    if (sender.tag == 300) {
        //每日一荐
        DailyViewController *ctrl = [[DailyViewController alloc] init];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollView代理
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/scrollView.bounds.size.width;
    
    self.pageCtrl.currentPage = index;
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
