//
//  NearButton.m
//  Limit_1509
//
//  Created by qianfeng on 15/7/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "NearButton.h"
#import "MyUtil.h"
#import "UIImageView+WebCache.h"

@implementation NearButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //图片
        _appImageView = [MyUtil createImageViewFrame:CGRectMake(0, 0, 80, 60) imageName:nil];
        [self addSubview:_appImageView];
        //文字
        _nameLabel = [MyUtil createLabelFrame:CGRectMake(0, 65, 80, 20) title:nil font:[UIFont systemFontOfSize:12]];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_nameLabel];
    }
    return self;
}

- (void)setAppModel:(LimitModel *)appModel {
    _appModel = appModel;
    //显示图片和文字
    [_appImageView sd_setImageWithURL:[NSURL URLWithString:appModel.iconUrl]];
    _nameLabel.text = appModel.name;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
