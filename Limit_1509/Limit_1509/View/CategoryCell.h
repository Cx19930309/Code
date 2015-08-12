//
//  CategoryCell.h
//  Limit_1509
//
//  Created by qianfeng on 15/7/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryItem.h"
#import "MyUtil.h"

@interface CategoryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cateImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

//显示数据
- (void)configItem:(CategoryItem *)cItem;

@end
