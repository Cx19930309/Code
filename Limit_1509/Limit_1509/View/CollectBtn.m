//
//  CollectBtn.m
//  Limit_1509
//
//  Created by qianfeng on 15/8/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CollectBtn.h"
#import "MyUtil.h"

@implementation CollectBtn

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //图片
        _imageView = [MyUtil createImageViewFrame:CGRectMake(20, 20, 60, 60) imageName:nil];
        [self addSubview:_imageView];
        //文字
        _textLabel = [MyUtil createLabelFrame:CGRectMake(0, 80, 100, 20) title:nil font:[UIFont systemFontOfSize:10] textAlignment:NSTextAlignmentCenter numberOfLines:1 textColor:[UIColor blackColor]];
        [self addSubview:_textLabel];
        //删除按钮
        _deleteBtn = [MyUtil createBtnFrame:CGRectMake(0, 0, 40, 40) title:nil bgImageName:@"close@2x" target:self action:@selector(deleteAction:)];
        _deleteBtn.hidden = YES;
        [self addSubview:_deleteBtn];
        
    }
    return self;
}

- (void)deleteAction:(id)sender {
    if (self.delegate) {
        //[self.delegate didDeleteBtnWithAppId:self.cItem.applicationId];
        [self.delegate didDeleteBtnWithIndex:self.tag-300];
    }
}

- (void)setCItem:(CollectItem *)cItem {
    _cItem = cItem;
    //图片
    _imageView.image = cItem.image;
    //文字
    _textLabel.text = cItem.name;
}

- (void)setEdit:(BOOL)edit {
    _edit = edit;
    //修改删除按钮状态
    if (edit) {
        _deleteBtn.hidden = NO;
    } else {
        _deleteBtn.hidden = YES;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
