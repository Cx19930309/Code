//
//  HomeCell.h
//  TestIpaDown
//
//  Created by gaokunpeng on 15/8/2.
//  Copyright (c) 2015年 gaokunpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@interface LimitCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *appImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *rateLabel;

@property (weak, nonatomic) IBOutlet UILabel *categotyLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;


//显示数据
- (void)configModel:(HomeModel *)model index:(NSInteger)index;

@end
