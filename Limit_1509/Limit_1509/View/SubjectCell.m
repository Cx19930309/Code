//
//  SubjectCell.m
//  Limit_1509
//
//  Created by qianfeng on 15/7/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SubjectCell.h"
#import "UIImageView+WebCache.h"
#import "MyUtil.h"

@implementation SubjectCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createAppButtons];
    }
    return self;
}

//xib
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self createAppButtons];
    }
    return self;
}

//初始化应用数据的视图
- (void)createAppButtons {
    //循环创建四个应用数据的显示按钮
    for (int i=0; i<4; i++) {
        CGRect frame = CGRectMake(150, 40+48*i, 200, 48);
        AppButton *btn = [[AppButton alloc]initWithFrame:frame];
        btn.tag = 300+i;
        
        [self addSubview:btn];
    }
}

- (void)setSItem:(SubjectItem *)sItem {
    _sItem = sItem;
    //显示数据
    //标题
    self.titleLabel.text = sItem.title;
    //图片
    [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:sItem.img]];
    //描述图片
    [self.descImageView sd_setImageWithURL:[NSURL URLWithString:sItem.desc_img]];
    //描述的文字
    self.descLabel.text = sItem.desc;
    self.descLabel.numberOfLines = 0;
    
    //相关应用的内容
    for (int i=0; i<4; i++) {
        //获取显示应用的按钮
        AppButton *btn = (AppButton *)[self viewWithTag:300+i];
        
        if (i < sItem.appArray.count) {
            //设置属性
            AppItem *aItem = sItem.appArray[i];
            btn.aItem = aItem;
            
            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            btn.hidden = NO;
        } else {
            btn.hidden = YES;
        }
        
    }
    
}

- (void)clickBtn:(AppButton *)btn {
    //传递到视图控制器
    NSInteger index = btn.tag-300;
    
    AppItem *aItem = self.sItem.appArray[index];
    /*
     代理传值
    if (self.delegate) {
        [self.delegate didSelectAppItem:aItem];
    }
     */
    //block方式传值
    if (self.clickBlock) {
        self.clickBlock(aItem);
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@implementation AppButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //图片
        _appImageView = [MyUtil createImageViewFrame:CGRectMake(0, 0, 40, 40) imageName:nil];
        [self addSubview:_appImageView];
        
        //标题
        _titleLabel = [MyUtil createLabelFrame:CGRectMake(50, 0, 130, 10) title:nil font:[UIFont systemFontOfSize:8]];
        [self addSubview:_titleLabel];
        
        //评论
        //图片
        UIImageView *commentImageView = [MyUtil createImageViewFrame:CGRectMake(50, 10, 10, 10) imageName:@"topic_Comment"];
        [self addSubview:commentImageView];
        
        //文字
        _commentLabel = [MyUtil createLabelFrame:CGRectMake(60, 10, 60, 10) title:nil font:[UIFont systemFontOfSize:8]];
        [self addSubview:_commentLabel];
        
        //下载
        //图片
        UIImageView *downloadImageView = [MyUtil createImageViewFrame:CGRectMake(120, 10, 10, 10) imageName:@"topic_Download"];
        [self addSubview:downloadImageView];
        
        //文字
        _downloadLabel = [MyUtil createLabelFrame:CGRectMake(130, 10, 50, 10) title:nil font:[UIFont systemFontOfSize:8]];
        [self addSubview:_downloadLabel];
        
        //星级
        _myStarView = [[StarView alloc]initWithFrame:CGRectMake(50, 20, 65, 23)];
        _myStarView.userInteractionEnabled = NO;
        [self addSubview:_myStarView];
    }
    return self;
}

- (void)setAItem:(AppItem *)aItem {
    _aItem = aItem;
    //显示数据
    [_appImageView sd_setImageWithURL:[NSURL URLWithString:aItem.iconUrl]];
    //标题
    _titleLabel.text = aItem.name;
    //评论
    _commentLabel.text = [NSString stringWithFormat:@"%@", aItem.ratingOverall];
    //下载
    _downloadLabel.text = aItem.downloads;
    //星级
    [_myStarView setRating:aItem.starOverall.floatValue];
}

@end











