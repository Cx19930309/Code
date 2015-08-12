//
//  DetailViewController.m
//  Limit_1509
//
//  Created by qianfeng on 15/7/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailItem.h"
#import "UIImageView+WebCache.h"
#import "MyUtil.h"
#import "LimitModel.h"
#import "NearButton.h"
#import "PhotoViewController.h"
#import "DBManager.h"

@interface DetailViewController () <MyDownloaderDelegate>

//详情数据
@property (nonatomic,strong)DetailItem *dItem;
//附近
@property (nonatomic,strong)NSMutableArray *nearbyArray;

@end

@implementation DetailViewController

//懒加载的方式初始化数组
- (NSMutableArray *)nearbyArray {
    if (_nearbyArray == nil) {
        _nearbyArray = [NSMutableArray array];
    }
    return _nearbyArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //导航
    [self createMyNav];
    
    //下载详情信息
    [self downloadDetailData];
    //附近应用的数据下载
    [self downloadNearbyData];
    
    //判断是否已收藏
    BOOL ret = [[DBManager sharedInstance]isAppFavorite:self.applicationId];
    if (ret) {
        //已收藏
        self.favoriteButton.enabled = NO;
        [self.favoriteButton setTitle:@"已收藏" forState:UIControlStateNormal];
        [self.favoriteButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
}

//附近应用的数据下载
- (void)downloadNearbyData {
    MyDownloader *downloader = [[MyDownloader alloc]init];
    downloader.delegate = self;
    downloader.type = 200;
    NSString *urlString = kNearByUrl;
    [downloader downloadWithUrlString:urlString];
}

//导航
- (void)createMyNav {
    //返回按钮
    UIButton *btn = [self addNavBtn:CGRectMake(0, 0, 60, 30) title:@"返回" target:self action:@selector(backAction:) isLeft:YES];
    [btn setBackgroundImage:[UIImage imageNamed:@"buttonbar_back"] forState:UIControlStateNormal];
    //标题
    [self addNavTitle:CGRectMake(60, 0, 255, 44) title:@"应用详情"];
}

- (void)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//下载详情数据
- (void)downloadDetailData {
    MyDownloader *downloader = [[MyDownloader alloc]init];
    downloader.delegate = self;
    downloader.type = 100;
    NSString *urlString = [NSString stringWithFormat:kDetailUrl, self.applicationId];
    [downloader downloadWithUrlString:urlString];
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

- (IBAction)shareAction:(id)sender {
}

//收藏
- (IBAction)favoriteAction:(id)sender {
    
    if (self.dItem == nil) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"数据还没下载完成,请稍后再收藏" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
        return;
    }
    
    //创建收藏的对象
    CollectItem *cItem = [[CollectItem alloc]init];
    cItem.applicationId = self.dItem.applicationId;
    cItem.name = self.dItem.name;
    cItem.image = self.appImageView.image;
    
    [[DBManager sharedInstance]addCollect:cItem];
    
    //修改收藏按钮的状态
    [self.favoriteButton setTitle:@"已收藏" forState:UIControlStateNormal];
    [self.favoriteButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.favoriteButton.enabled = NO;
    
}

- (IBAction)downloadAction:(id)sender {
    //跳转appStore界面
    if (self.dItem.itunesUrl) {
        NSURL *url = [NSURL URLWithString:self.dItem.itunesUrl];
        [[UIApplication sharedApplication]openURL:url];
    }
}

//显示附近数据
- (void)showNearbyData {
    //循环创建按钮
    CGFloat width = 80;
    CGFloat height = 80;
    CGFloat space = 10;
    for (int i=0; i<self.nearbyArray.count; i++) {
        //获取模型对象
        LimitModel *model = self.nearbyArray[i];
        //按钮
        CGRect frame = CGRectMake((width+space)*i, 0, width, height);
        NearButton *btn = [[NearButton alloc]initWithFrame:frame];
        btn.appModel = model;
        //设置tag值
        btn.tag = 200+i;
        //事件
        [btn addTarget:self action:@selector(clickNearBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.nearbyScrollView addSubview:btn];
        //设置滚动范围
        CGFloat scrollWidth = (width+space)*self.nearbyArray.count;
        if (scrollWidth >self.nearbyScrollView.bounds.size.width) {
            self.nearbyScrollView.contentSize = CGSizeMake(scrollWidth, 80);
        } else {
            self.nearbyScrollView.contentSize = CGSizeMake(self.nearbyScrollView.bounds.size.width+10, 80);
        }
    }
}

- (void)clickNearBtn:(NearButton *)btn {
    NSInteger index = btn.tag - 200;
    //获取模型对象
    LimitModel *model = self.nearbyArray[index];
    //跳转详情
    DetailViewController *dCtrl = [[DetailViewController alloc]init];
    dCtrl.applicationId = model.applicationId;
    [self.navigationController pushViewController:dCtrl animated:YES];
}

//显示详情的数据
- (void)showDetailData {
    //图片
    [self.appImageView sd_setImageWithURL:[NSURL URLWithString:self.dItem.iconUrl]];
    //名字
    self.nameLabel.text = self.dItem.name;
    //原价
    self.priceLabel.text = [NSString stringWithFormat:@"原价:￥%@", self.dItem.currentPrice];
    //免费
    if ([self.dItem.priceTrend isEqualToString:@"limited"]) {
        self.statusLabel.text = @"限免中";
    } else if ([self.dItem.priceTrend isEqualToString:@"limited"]) {
        self.statusLabel.text = @"免费";
    }
    //大小
    self.sizeLabel.text = [NSString stringWithFormat:@"%@MB", self.dItem.fileSize];
    //类型
    self.typeLabel.text = [MyUtil transferCateName:self.dItem.categoryName];
    //评分
    self.rateLabel.text = [NSString stringWithFormat:@"%.1f分", self.dItem.starCurrent.floatValue];
    //图片
    CGFloat width = 80;
    CGFloat height = 90;
    for (int i=0; i<self.dItem.photoArray.count; i++) {
        //图片数据对象
        PhotoItem *pItem = self.dItem.photoArray[i];
        CGRect frame = CGRectMake((width+10)*i, 0, width, height);
        UIImageView *tmpImageView = [MyUtil createImageViewFrame:frame imageName:nil];
        [tmpImageView sd_setImageWithURL:[NSURL URLWithString:pItem.smallUrl]];
        //点击事件
        //添加手势
        tmpImageView.userInteractionEnabled = YES;
        tmpImageView.tag = 200+i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [tmpImageView addGestureRecognizer:tap];
        
        [self.imageScrollView addSubview:tmpImageView];
    }
    self.imageScrollView.contentSize = CGSizeMake((width+10)*self.dItem.photoArray.count, height);
    //描述
    self.descLabel.text = self.dItem.myDescription;
    self.descLabel.numberOfLines = 0;
    
    
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    UIImageView *imageView = (UIImageView *)tap.view;
    NSInteger index = imageView.tag - 200;
    //跳转图片界面
    PhotoViewController *pCtrl = [[PhotoViewController alloc]init];
    pCtrl.photoArray = self.dItem.photoArray;
    pCtrl.index = index;
    pCtrl.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:pCtrl animated:YES completion:nil];
}

- (void)downloaderFail:(MyDownloader *)downloader failWithError:(NSError *)error {
    NSLog(@"error:%@", error);
}

- (void)downloaderFinish:(MyDownloader *)downloader {
    if (downloader.type == 100) {
        //详情数据
        id result = [NSJSONSerialization JSONObjectWithData:downloader.receiveData options:NSJSONReadingMutableContainers error:nil];
        if ([result isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dict = result;
            
            //创建模型对象
            self.dItem = [[DetailItem alloc]init];
            [self.dItem setValuesForKeysWithDictionary:dict];
            //图片数组
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *photoDict in dict[@"photos"]) {
                PhotoItem *pItem = [[PhotoItem alloc]init];
                [pItem setValuesForKeysWithDictionary:photoDict];
                [array addObject:pItem];
            }
            self.dItem.photoArray = array;
            //显示数据
            [self showDetailData];
        }
    } else if (downloader.type == 200) {
        //附近的数据
        id result = [NSJSONSerialization JSONObjectWithData:downloader.receiveData options:NSJSONReadingMutableContainers error:nil];
        if ([result isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dict = result;
            for (NSDictionary *appDict in dict[@"applications"]) {
                //创建模型对象
                LimitModel *model = [[LimitModel alloc]init];
                [model setValuesForKeysWithDictionary:appDict];
                //懒加载的方式一定要用getter方法使用数据
                [self.nearbyArray addObject:model];
            }
            //显示数据
            [self showNearbyData];
            
        }
    }
    
    
}

@end
