//
//  HotCell.m
//  Limit_1509
//
//  Created by qianfeng on 15/7/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HotCell.h"
#import "UIImageView+WebCache.h"
#import "MyUtil.h"

@implementation HotCell

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
    self.titleLabel.text = [NSString stringWithFormat:@"%ld. %@", index+1, model.name];
    //现价
    self.rateLabel.text = [NSString stringWithFormat:@"评价:%@分", model.ratingOverall];
    //原价
    NSString *lastPrice = [NSString stringWithFormat:@"￥:%@", model.lastPrice];
    //NSStrikethroughStyleAttributeName表示在文字上面加横线
    //@1==[NSNumber numberWithInt:1]
    //表示横线的高度为1
    NSDictionary *dict = @{NSStrikethroughStyleAttributeName:@1};
    NSAttributedString *string = [[NSAttributedString alloc]initWithString:lastPrice attributes:dict];
    self.lastPriceLabel.attributedText = string;
    
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
