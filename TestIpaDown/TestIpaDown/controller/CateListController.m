//
//  CateListController.m
//  TestIpaDown
//
//  Created by gaokunpeng on 15/8/2.
//  Copyright (c) 2015年 gaokunpeng. All rights reserved.
//

#import "CateListController.h"
#import "HomeModel.h"
#import "HomeCell.h"
#import "AFHTTPRequestOperationManager.h"

@interface CateListController ()

//筛选按钮
@property (nonatomic,strong)UIButton *chooseBtn;

//选中的序号
@property (nonatomic,assign)NSInteger selectIndex;

@property (nonatomic,strong)UISegmentedControl *segCtrl;

//筛选的视图
@property (nonatomic,strong)UIView *maskView;

@end

@implementation CateListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //导航
    [self addNavLabelTitle:self.cateName];
    
    [self addBackBtnTarget:self action:@selector(backAction:)];
    
    
    //下拉刷新
    [self addRefresh];
    
    //选择条件
    self.chooseBtn = [self addnavBtnTitle:@"全部" bgImageName:@"navButton" target:self action:@selector(clickBtn:)];
    
}

- (void)clickBtn:(id)sender
{
    
    if ([[self.chooseBtn currentTitle] isEqualToString:@"取消"]) {
       
        [self.segCtrl removeFromSuperview];
        self.segCtrl = nil;
        [self.maskView removeFromSuperview];
        self.maskView = nil;
        
        //修改按钮文字
        NSString *title = [self.segCtrl titleForSegmentAtIndex:self.selectIndex];
        [self.chooseBtn setTitle:title forState:UIControlStateNormal];
        
    }else{
        //显示筛选界面
        self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 667-64-49)];
        self.maskView.backgroundColor = [UIColor blackColor];
        self.maskView.alpha = 0.8;
        [self.view addSubview:self.maskView];
        
        //选择控件
        self.segCtrl = [[UISegmentedControl alloc] initWithItems:@[@"全部",@"免费",@"限免",@"付费"]];
        self.segCtrl.frame = CGRectMake(50, 80, 280, 44);
        //文字
        [self.segCtrl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
        //事件
        [self.segCtrl addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventValueChanged];
        //显示上次选中的序号
        self.segCtrl.selectedSegmentIndex = self.selectIndex;
        [self.view addSubview:self.segCtrl];
        
        
        [self.chooseBtn setTitle:@"取消" forState:UIControlStateNormal];
    }
    
    
 
}

- (void)selectAction:(UISegmentedControl *)segCtrl
{
    
    //下载数据
    self.selectIndex = segCtrl.selectedSegmentIndex;
    
    self.curPage = 1;
    
    [self downloadData];
    
    //修改按钮文字
    NSString *title = [segCtrl titleForSegmentAtIndex:self.selectIndex];
    [self.chooseBtn setTitle:title forState:UIControlStateNormal];
    
    //视图隐藏
    [self.segCtrl removeFromSuperview];
    self.segCtrl = nil;
    [self.maskView removeFromSuperview];
    self.maskView = nil;
    
}

- (void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)downloadData
{
    
    self.isLoading = NO;
    
    //block里面需要使用self的弱引用
    __weak CateListController *weakSelf = self;
    
    //下载数据
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    /*
     price=all:全部
     price=free:免费
     price=pricedrop:限免
     price=paid:付费
     */
    NSString *price = nil;
    if (self.selectIndex == 0) {
        price = @"all";
    }else if (self.selectIndex == 1){
        price = @"free";
    }else if (self.selectIndex == 2){
        price = @"pricedrop";
    }else if (self.selectIndex == 3){
        price = @"paid";
    }
    
    NSString *urlString = [NSString stringWithFormat:kCategoryUrl,self.categoryStr,self.pageSize,self.curPage,price];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (weakSelf.curPage == 1) {
            [weakSelf.dataArray removeAllObjects];
        }
        
        //数据解析
        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([result isKindOfClass:[NSArray class]]) {
            NSArray *array = result;
            
            for (NSDictionary *homeDict in array) {
                //创建模型对象
                HomeModel *model = [[HomeModel alloc] init];
                [model setValuesForKeysWithDictionary:homeDict];
                [weakSelf.dataArray addObject:model];
            }
            
            //刷新表格
            weakSelf.isLoading = NO;
            [weakSelf.tbView reloadData];
            
            [weakSelf.headerView endRefreshing];
            [weakSelf.footerView endRefreshing];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"homeCellId";
    
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeCell" owner:nil options:nil] lastObject];
    }
    
    HomeModel *model = self.dataArray[indexPath.row];
    [cell configModel:model index:indexPath.row];
    
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
