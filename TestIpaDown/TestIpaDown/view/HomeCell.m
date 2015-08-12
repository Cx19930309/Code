//
//  HomeCell.m
//  TestIpaDown
//
//  Created by gaokunpeng on 15/8/2.
//  Copyright (c) 2015年 gaokunpeng. All rights reserved.
//

#import "HomeCell.h"
#import "UIImageView+WebCache.h"

@implementation HomeCell

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
    
    
    //状态
    if (model.app_pricedrop.integerValue == 1) {
        //降价或限免
        self.statusLabel.backgroundColor = [UIColor colorWithRed:50.0f/255.0f green:120.0f/255.0f blue:200.0f/255.0f alpha:1.0f];
        self.statusLabel.layer.cornerRadius = 8;
        self.statusLabel.clipsToBounds = YES;
        self.statusLabel.textColor = [UIColor whiteColor];
        
        if (model.app_price.floatValue > 0) {
            self.statusLabel.text = @"降价中";
        }else{
            self.statusLabel.text = @"限免中";
        }
        
    }else if (model.app_pricedrop.integerValue == 0){
        //原价
        self.statusLabel.backgroundColor = [UIColor colorWithRed:50.0f/255.0f green:70.0f/255.0f blue:120.0f/255.0f alpha:1.0f];
        self.statusLabel.layer.cornerRadius = 8;
        self.statusLabel.clipsToBounds = YES;
        self.statusLabel.textColor = [UIColor whiteColor];
        
        if (model.app_price.floatValue > 0) {
            self.statusLabel.text = [NSString stringWithFormat:@"%@元",model.app_price];
        }else{
            self.statusLabel.text = @"免费";
        }
       
    }
    
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
