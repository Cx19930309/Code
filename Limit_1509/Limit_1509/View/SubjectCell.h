//
//  SubjectCell.h
//  Limit_1509
//
//  Created by qianfeng on 15/7/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubjectItem.h"
#import "StarView.h"

@protocol SubjectCellDelegate <NSObject>

- (void)didSelectAppItem:(AppItem *)aItem;

@end

@interface SubjectCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;

@property (weak, nonatomic) IBOutlet UIImageView *descImageView;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

//显示数据
@property (nonatomic,strong)SubjectItem *sItem;

//代理属性
@property (nonatomic,weak)id <SubjectCellDelegate>delegate;

//block的方式
@property (nonatomic,copy)void (^clickBlock)(AppItem *aItem);

@end

@interface AppButton : UIControl

{
    //图片
    UIImageView *_appImageView;
    //标题
    UILabel *_titleLabel;
    //评论
    UILabel *_commentLabel;
    //下载
    UILabel *_downloadLabel;
    //星级
    StarView *_myStarView;
}

@property (nonatomic,strong)AppItem *aItem;

@end