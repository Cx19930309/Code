//
//  ADCell.m
//  TestIpaDown
//
//  Created by gaokunpeng on 15/8/2.
//  Copyright (c) 2015年 gaokunpeng. All rights reserved.
//

#import "ADCell.h"
#import "ADModel.h"
#import "UIImageView+WebCache.h"
#import "MyUtil.h"

@implementation ADCell


-(void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    
    for (int i=0; i<dataArray.count; i++) {
        
        //模型对象
        ADModel *model = dataArray[i];
        
        CGRect frame = CGRectMake(375*i, 0, 375, 160);
        
        UIImageView *imageView = [MyUtil createImageViewFrame:frame imageName:nil];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        [self.myScrollView addSubview:imageView];
    }
    
    self.myScrollView.delegate = self;
    self.myScrollView.pagingEnabled = YES;
    self.myScrollView.bounces = NO;
    self.myScrollView.contentSize = CGSizeMake(375*dataArray.count, 160);
    
    
    //分页
    self.myPageCtrl.numberOfPages = dataArray.count;
}

#pragma mark - UIScrollView代理
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/scrollView.bounds.size.width;
    
    self.myPageCtrl.currentPage = index;
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
