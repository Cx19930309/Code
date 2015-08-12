//
//  Const.h
//  TestIpaDown
//
//  Created by gaokunpeng on 15/8/2.
//  Copyright (c) 2015年 gaokunpeng. All rights reserved.
//

#ifndef TestIpaDown_Const_h
#define TestIpaDown_Const_h

//首页
//1、广告
#define kHomeAdUrl    (@"http://api.ipadown.com/iphone-client/ad.flash.php?count=5&device=iphone")
//2、列表
#define kHomeListUrl  (@"http://api.ipadown.com/iphone-client/apps.list.php?t=index&count=%ld&page=%ld&device=iPhone&price=all")

//今日限免
//1、今日限免
#define kLimitToday (@"http://api.ipadown.com/iphone-client/apps.list.php?device=iPhone&price=pricedrop&count=%ld&page=%ld")
//2、本周热门限免
#define kLimitMonth (@"http://api.ipadown.com/iphone-client/apps.list.php?device=iPhone&price=pricedrop&subday=7&orderby=views&count=%ld&page=%ld")
//3、热门限免总榜
#define kLimitHot  (@"http://api.ipadown.com/iphone-client/apps.list.php?device=iPhone&price=pricedrop&orderby=views&count=%ld&page=%ld")


//分类
//1、分类列表
#define kCategoryListUrl  (@"http://api.ipadown.com/iphone-client/category.list.php")
//2、分类进入的具体类型列表
#define kCategoryUrl  (@"http://api.ipadown.com/iphone-client/apps.list.php?%@&count=%ld&page=%ld&device=iPhone&price=%@")



//推荐
//1、每日一荐
#define kDailyUrl  (@"http://api.ipadown.com/iphone-client/apps.list.php?t=commend&count=%ld&page=%ld&device=iPhone&price=all")





#endif
