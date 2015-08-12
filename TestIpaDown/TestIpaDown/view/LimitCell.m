//
//  HomeCell.m
//  TestIpaDown
//
//  Created by gaokunpeng on 15/8/2.
//  Copyright (c) 2015年 gaokunpeng. All rights reserved.
//

#import "LimitCell.h"
#import "UIImageView+WebCache.h"

@implementation LimitCell

-(void)configModel:(HomeModel *)model index:(NSInteger)index
{
    //图片
    [self.appImageView sd_setImageWithURL:[NSURL URLWithString:model.app_icon] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    //名字
    self.nameLabel.text = [NSString stringWithFormat:@"%ld.%@",index+1,model.post_title];
    
    //评级
    if (model.app_apple_rated.integerValue >0 ) {
        self.rateLabel.text = [NSString stringWithFormat:@"评分:%@星",model.app_apple_rated];
    }else{
        self.rateLabel.text = @"评分:未知";
    }
    
    
    //类别    
    self.categotyLabel.text = [NSString stringWithFormat:@"类别:%@",model.app_category];
    
    //大小
    self.sizeLabel.text = model.app_size;
    
    
    //描述
    self.descLabel.text = model.app_desc;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
