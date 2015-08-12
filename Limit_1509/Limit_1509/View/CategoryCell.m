//
//  CategoryCell.m
//  Limit_1509
//
//  Created by qianfeng on 15/7/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CategoryCell.h"
#import "UIImageView+WebCache.h"

@implementation CategoryCell

- (void)configItem:(CategoryItem *)cItem {
    //图片
    NSString *imageName = [NSString stringWithFormat:@"category_%@.jpg",cItem.categoryName];
    self.cateImageView.image = [UIImage imageNamed:imageName];
    //标题
    self.titleLabel.text = [MyUtil transferCateName:cItem.categoryName];
    //描述
    self.descLabel.text = [NSString stringWithFormat:@"共有%@款应用, 其中限免%@款", cItem.count, cItem.lessenPrice];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
