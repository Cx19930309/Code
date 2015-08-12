//
//  CollectBtn.h
//  Limit_1509
//
//  Created by qianfeng on 15/8/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectItem.h"

@protocol CollectBtnDelegate <NSObject>

/*
- (void)didDeleteBtnWithAppId:(NSString *)applicationId;
*/
- (void)didDeleteBtnWithIndex:(NSInteger)index;

@end

@interface CollectBtn : UIControl
{
    //图片
    UIImageView *_imageView;
    //文字
    UILabel *_textLabel;
    //删除按钮
    UIButton *_deleteBtn;
}

//显示数据
@property (nonatomic,strong)CollectItem *cItem;
//设置编辑状态
@property (nonatomic,assign)BOOL edit;
//设置代理属性(ARC下面用weak修饰)
@property (nonatomic,weak)id <CollectBtnDelegate>delegate;

@end
