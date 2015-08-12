//
//  DetailViewController.h
//  Limit_1509
//
//  Created by qianfeng on 15/7/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BaseViewController.h"
#import "LFNavController.h"

@interface DetailViewController : LFNavController

@property (weak, nonatomic) IBOutlet UIImageView *appImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) IBOutlet UILabel *rateLabel;

- (IBAction)shareAction:(id)sender;

- (IBAction)favoriteAction:(id)sender;

- (IBAction)downloadAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *nearbyScrollView;

@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;

//应用的appId
@property (nonatomic,strong)NSString *applicationId;

@end
