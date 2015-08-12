//
//  CategoryCell.m
//  TestIpaDown
//
//  Created by gaokunpeng on 15/8/2.
//  Copyright (c) 2015年 gaokunpeng. All rights reserved.
//

#import "CategoryCell.h"
#import "UIImageView+WebCache.h"

@implementation CategoryCell

-(void)config:(CategoryType *)type
{
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:type.icon]];
    
    self.titleLabel.text = type.title;
    
    self.descLabel.text = type.desc;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
