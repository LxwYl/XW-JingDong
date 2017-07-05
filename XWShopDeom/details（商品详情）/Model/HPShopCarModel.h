//
//  HPShopCarModel.h
//  HPShop
//
//  Created by 李学文 on 2017/1/28.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPShopCarModel : NSObject
/**
 *
 *  购物车详情
 */
@property(strong, nonatomic) NSMutableArray * content; /*--------!模型里面套数组！--------------  */

@property(strong, nonatomic) NSString * storeId;//商店id

/** 满减活动*/
@property(strong, nonatomic) NSString * full_price;//满减的条件 大于0时存在满减活动
@property(strong, nonatomic) NSString * cut_price;// 减的价钱

@property(strong,nonatomic) NSString * currentSelectprice;//当前商店以选中要购买商品总金额

/** 最大件数*/
@property(strong, nonatomic) NSString * maxnumber;
/** 最小件数*/
@property(strong, nonatomic) NSString * minnumber;

/** 是否选中*/
@property(assign, nonatomic) BOOL isSelectArr;

@property(strong,nonatomic) NSString * titleinfo;

@property(strong,nonatomic) NSString *canMadeCoup;// 此订单 是否可以使用优惠劵 “1” 不可以使用
@end

/**
 *
 *  运费
 */
@interface HPFreightMode : NSObject

// 运费减免条件
@property(strong,nonatomic) NSString * fill_exempt; 
//运费
@property(strong,nonatomic) NSString * freight;
//实际运费 经过计算的来
@property(strong,nonatomic) NSString * actionfreight;


@end




/**
 *
 *  商品详情
 */
@interface HPShopdetailModel : NSObject
#pragma mark- 测试
/** id*/
@property(strong, nonatomic) NSString * id;
/** 姓名*/
@property(strong, nonatomic) NSString * name;
/** 详细*/
@property(strong, nonatomic) NSString * detail;
/** 商品数量*/
@property(strong, nonatomic) NSString * number;
/** 图片路径*/
@property(strong, nonatomic) NSString * imageUrl;
/** 价格 */
@property(strong, nonatomic) NSString * rice;
/** 总价格 */
@property(strong, nonatomic) NSString * toalrice;
/** 运费 */
@property(strong, nonatomic) NSString * carrice;


#pragma mark- 真实

/** id*/
@property(strong, nonatomic) NSString * store_id;
/** 姓名*/
@property(strong, nonatomic) NSString * goods_name;
/** id*/
@property(strong, nonatomic) NSString * goods_id;

/** 商品数量*/
@property(strong, nonatomic) NSString * count;
/** 图片路径*/
@property(strong, nonatomic) NSString * pathName;
/** 价格 */
@property(strong, nonatomic) NSString * price;

/** 商店名称 */
@property(strong, nonatomic) NSString * store_name;

//"spec_info": "鞋码:37 ",
@property(strong, nonatomic) NSString * spec_info;

@property(strong,nonatomic) NSString * goodsMark;//下架 -2 是下架



/**活动列表 */
@property(strong, nonatomic) NSArray * activelist;/*--------!模型里面套数组再套数组！--------------  */






/** 是否选中*/
@property(assign, nonatomic) BOOL isSelect;
@end


/**
 *
 *  活动详情
 */
@interface HPShopActiveListModel : NSObject



@end


