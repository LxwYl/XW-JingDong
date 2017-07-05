//
//  HPhomebannderMode.h
//  HPShop
//
//  Created by 李学文 on 2017/3/24.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPhomebannderMode : NSObject
//"goodsid" :98377,
//"name" :"b9225406-e3e7-4335-ad93-4dcc44b2d8d1.jpg",
//"path" :"upload/store/1/2016/03/09",
//"size" :0.0,
//"width" :474,
//"height" :475,
//"ext" :"jpg"


// 商品ID
@property(strong, nonatomic) NSString * goodsid;

@property(assign, nonatomic) CGSize  size;


@property(assign, nonatomic) CGFloat  width;


@property(assign, nonatomic) CGFloat  height;

@property(strong,nonatomic) NSString *url;//状态 commodity ： 商品   store：店铺
@property(strong,nonatomic) NSString *commodityId;
@property(strong,nonatomic) NSString * storeId;//商店id



// 轮播图的图片 路径
@property(strong, nonatomic) NSString * ext;//扩展

//封面路径需要这两个参数拼接
@property(strong, nonatomic) NSString * path; //路径
@property(strong, nonatomic) NSString * name;// 名称

//@property (nonatomic, strong) NSString *url;  //banner详情的URL

@property (nonatomic, strong) NSString *album;
@property (nonatomic, strong) NSString *id;

@property (nonatomic, strong) NSString *goodsName;  //商品名称
@property (nonatomic, strong) NSString *goods_price; //商品价格
@property (nonatomic, strong) NSString *goods_salenum; //已售数量

@property (nonatomic, strong) NSString *store_price;  //货物价格（估计是原价）

- (NSString *)GetPhotoPath;
@end
