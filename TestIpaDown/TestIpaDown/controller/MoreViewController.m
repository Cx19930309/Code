//
//  MoreViewController.m
//  TestIpaDown
//
//  Created by gaokunpeng on 15/8/2.
//  Copyright (c) 2015年 gaokunpeng. All rights reserved.
//

#import "MoreViewController.h"
#import "MyUtil.h"


#define kImageArray    (@"imageArray")
#define kTitleArray    (@"titleArray")
#define kSubtileArray  (@"subtitleArray")

@interface MoreViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tbView;

//数据源
@property (nonatomic,strong)NSMutableArray *dataArray;

//组标题
@property (nonatomic,strong)NSArray *titleArray;

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //数据源
    self.titleArray = @[@"更多栏目",@"客户端设置",@"关于客户端",@"关于i派党",@"我们的iOS移动客户端",@"我们的电脑客户端"];
    
    [self createDataArray];
    
    //表格
    [self createTableView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}

//数据源
- (void)createDataArray
{
    self.dataArray = [NSMutableArray array];
    
    //更多栏目
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    [dict1 setObject:@[@"c-top",@"c-zt",@"c-guide",@"c-jc"] forKey:kImageArray];
    [dict1 setObject:@[@"排行标题",@"应用专题",@"精品导购",@"苹果学院"] forKey:kTitleArray];
    [dict1 setObject:@[@"Appstroe各国实时排行榜",@"归类推荐精品软件游戏",@"精品应用程序导购指南",@"iPhone小技巧一网打尽"] forKey:kSubtileArray];
    [self.dataArray addObject:dict1];
    
    //客户端设置
    NSMutableDictionary *dict2 = [NSMutableDictionary dictionary];
    [dict2 setObject:@[@"我收藏的Apps",@"清空本地缓存",@"开启或关闭推送"] forKey:kTitleArray];
    [dict2 setObject:@[@"",@"一键清空",@"设置"] forKey:kSubtileArray];
    [self.dataArray addObject:dict2];
    
    //关于客户端
    NSMutableDictionary *dict3 = [NSMutableDictionary dictionary];
    [dict3 setObject:@[@"软件名称",@"软件作者",@"意见反馈",@"技术支持",@"去AppStore给我们评价"] forKey:kTitleArray];
    [dict3 setObject:@[@"精品显示免费",@"花太香齐",@"ieliwb@gmail.com",@"www.ipadown.com",@""] forKey:kSubtileArray];
    [self.dataArray addObject:dict3];
    
    //关于i派党
    NSMutableDictionary *dict4 = [NSMutableDictionary dictionary];
    [dict4 setObject:@[@"关于ipai党",@"团队联系方式",@"App玩家交流QQ群"] forKey:kTitleArray];
    [self.dataArray addObject:dict4];
    
    
    //我们的iOS移动客户端
    NSMutableDictionary *dict5 = [NSMutableDictionary dictionary];
    [dict5 setObject:@[@"《精品限时免费》 for iPad",@"《苹果i新闻》for iPhone"] forKey:kTitleArray];
    [self.dataArray addObject:dict5];
    
    
    //我们的电脑客户端
    NSMutableDictionary *dict6 = [NSMutableDictionary dictionary];
    [dict6 setObject:@[@"i派党Mac客户端",@"ipai党AIR客户端"] forKey:kTitleArray];
    [self.dataArray addObject:dict6];
}


//表格
- (void)createTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375, 667-64-49) style:UITableViewStyleGrouped];
    self.tbView.delegate = self;
    self.tbView.dataSource = self;
    [self.view addSubview:self.tbView];
    
    
    UIImageView *headView = [MyUtil createImageViewFrame:CGRectMake(0, 0, 375, 80) imageName:@"logo_empty"];
    self.tbView.tableHeaderView = headView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  UITableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dict = self.dataArray[section];
    
    NSArray *titleArray = dict[kTitleArray];
    return titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    UITableViewCellStyle style = UITableViewCellStyleSubtitle;
    if (indexPath.section == 1 || indexPath.section == 2) {
        style = UITableViewCellStyleValue1;
    }
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:style reuseIdentifier:cellId];
    }
    
    NSDictionary *dict = self.dataArray[indexPath.section];
    //标题
    NSArray *titleArray = dict[kTitleArray];
    cell.textLabel.text = titleArray[indexPath.row];
    
    //图片
    if ([[dict allKeys] containsObject:kImageArray]) {
        NSArray *imageArray = dict[kImageArray];
        
        NSString *imageName = imageArray[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:imageName];
    }
    
    //副标题
    if ([[dict allKeys] containsObject:kSubtileArray]) {
        NSArray *subtitleArray = dict[kSubtileArray];
        
        cell.detailTextLabel.text = subtitleArray[indexPath.row];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    return cell;
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
