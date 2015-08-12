//
//  FreeCell.m
//  Limit_1509
//
//  Created by qianfeng on 15/7/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "FreeCell.h"
#import "UIImageView+WebCache.h"
#import "MyUtil.h"

@implementation FreeCell

- (void)configModel:(LimitModel *)model index:(NSInteger)index {
    //背景图片
    if (index % 2 == 0) {
        self.bgImageView.image = [UIImage imageNamed:@"cate_list_bg1@2x"];
    } else {
        self.bgImageView.image = [UIImage imageNamed:@"cate_list_bg2@2x"];
    }
    
    //图片
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:model.iconUrl]];
    //标题
    self.titleLabel.text = model.name;
    //评分
    self.rateLabel.text = [NSString stringWithFormat:@"评分:%@分", model.ratingOverall];
    //现价
    self.curPriceLabel.text = [NSString stringWithFormat:@"现价:￥%@", model.currentPrice];
    
    //星级
    [self.myStarView setRating:model.starCurrent.floatValue];
    //类型
    self.typeLabel.text = [MyUtil transferCateName:model.categoryName];
    //分享
    self.shareLabel.text = [NSString stringWithFormat:@"分享:%@次", model.shares];
    //收藏
    self.favoriteLabel.text = [NSString stringWithFormat:@"收藏:%@次", model.favorites];
    //下载
    self.downloadLabel.text = [NSString stringWithFormat:@"分享:%@次", model.downloads];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
