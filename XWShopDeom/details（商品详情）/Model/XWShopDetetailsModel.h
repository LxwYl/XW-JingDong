//
//  XWShopDetetailsModel.h
//  HPShop
//
//  Created by 李学文 on 2017/4/12.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HPShopCarModel.h"


/**  轮播图 */



@interface XWShopbannderModel : NSObject
/*
 addTime = "2016-04-04 16:36:18";
 id = 426322;
 pathName = "upload/store/1/2016/04/04/9f0
 */
@property(strong,nonatomic) NSString *addTime;
@property(strong,nonatomic) NSString *id;
@property(strong,nonatomic) NSString *pathName;
@end



/** 评论 */


@interface XWShopCommentModel : NSObject
/*
 "description_evaluate" = 5;
 evaluateGoodRate = 100;
 evaluateSize = 1;
 "evaluate_buyer_val" = 1;
 "evaluate_info" = " \U60a8\U7684\U8bc4\U4ef7\U5c06\U662f\U5176\U4ed6\U4e70\U5bb6\U7684\U53c2\U8003";
 "goods_name" = "2014-01-02 18:55:11";
 id = 1;
 markStatus = "upload/userImg/head_portrait/1/1491362352448/min.png";
 trueName = 11112;
 userName = admin;
 "user_id" = 1;
 */
@property(strong,nonatomic) NSString *description_evaluate;
@property(strong,nonatomic) NSString *evaluateGoodRate;
@property(strong,nonatomic) NSString *evaluateSize;
@property(strong,nonatomic) NSString *evaluate_buyer_val;
@property(strong,nonatomic) NSString *evaluate_info;
@property(strong,nonatomic) NSString *goods_name;
@property(strong,nonatomic) NSString *id;
@property(strong,nonatomic) NSString *markStatus;
@property(strong,nonatomic) NSString *trueName;
@property(strong,nonatomic) NSString *userName;
@property(strong,nonatomic) NSString *user_id;
@end




/** 商店信息 */
@interface XWStoreMessageModel : NSObject
/*
 addTime = "2013-12-24 12:55:25";
 id = 1;
 "store_info" = "";
 "store_logo_id" = "resources/style/common/images/good.jpg";
 "store_name" = "\U5e73\U53f0\U81ea\U8425\U5e97";
 
 */
@property(strong,nonatomic) NSString *addTime;
@property(strong,nonatomic) NSString *id;
@property(strong,nonatomic) NSString *store_info;
@property(strong,nonatomic) NSString *store_logo_id;
@property(strong,nonatomic) NSString *store_name;
@property(strong,nonatomic) NSString *ringLetterAccount;
@property (nonatomic, strong) NSString *cut_price;
@property (nonatomic, strong) NSString *full_price;

@end




@interface XWcommodityMessageModel : NSObject
/*
 "gc_id" = 17;
 "goods_name" = "2016???? ????????????????A???";
 "goods_store_id" = 1;
 id = 98412;
 "store_price" = 178;
 */
@property(strong,nonatomic) NSString *gc_id;
@property(strong,nonatomic) NSString *goods_name;
@property(strong,nonatomic) NSString *goods_store_id;
@property(strong,nonatomic) NSString *id;
@property(strong,nonatomic) NSString *store_price;//现价

@property(strong, nonatomic) NSString * pathMainName;


@property (nonatomic, strong) NSString *price; //原价
@property (nonatomic, strong) NSString *coupon_name;
@property (nonatomic, strong) NSString *coupon_amount;
@property (nonatomic, strong) NSString *bargainMark;

@end

@interface XWShopcatgorylistModel : NSObject
@property(strong,nonatomic) NSString *catgoryName; // 规格名称 颜色，尺码等等
@property(strong, nonatomic) NSMutableArray * catgoryList; // 当前名称 下的所有可选规格
@property(assign, nonatomic) NSInteger  index;// 本分类中被选中的下标（非请求，自定义标示）
@end

/** 分类 */
@interface XWShopcatgoryModel : NSObject
/*
 "goods_name" = "2013-12-24 08:59:56";
 id = 20;
 sequence = 7;
 "spec_id" = 2;
 value = XL;
 
 */
@property(strong,nonatomic) NSString *goods_name;
@property(strong,nonatomic) NSString *id;
@property(strong,nonatomic) NSString *sequence;
@property(strong,nonatomic) NSString *spec_id;
@property(strong,nonatomic) NSString *value;
@property(strong, nonatomic) NSString * isSelected;//0是未备选中 1 是被选中

@end


/** 推荐 */


@interface XWShopsalesVolumeModel : NSObject

/*
 "goods_name" = "2016???? ????????????????A???";
 id = 98412;
 pathName = "upload/store/1/2016/04/04/c51ca320-b9d9-4bed-b64a-f4768557f57c.jpg";
 "sales_volume" = 3;
 "store_price" = 178;
 */
@property(strong,nonatomic) NSString *goods_name;
@property(strong,nonatomic) NSString *id;
@property(strong,nonatomic) NSString *pathName;
@property(strong,nonatomic) NSString *sales_volume;
@property(strong,nonatomic) NSString *store_price;
@property(strong, nonatomic) NSString *pathMainName;


@end


@interface XWShopExplainModel : NSObject
@property(strong,nonatomic) NSString *after_sale;
@property(strong,nonatomic) NSString *image_text;
@property(strong,nonatomic) NSString *standard;

@end

@interface XWShopDetetailsModel : NSObject

@property(strong,nonatomic) NSString *storeSizeList;//店铺总个数
@property(strong,nonatomic) NSString *dynamicSizeList;// 动态个数
@property(strong,nonatomic) NSString *goodsSizeList;//商品个数

@property(strong,nonatomic) XWShopCommentModel *EvaluateList;//评论

@property(strong, nonatomic) XWStoreMessageModel * StoreMessage;//商店详情

@property(strong, nonatomic) XWcommodityMessageModel * commodityMessageList;//商品详情

@property(strong, nonatomic) NSMutableArray * commodityPropertyList;//分类

@property(strong, nonatomic) NSMutableArray * imgList;//商品图片 bannder

@property(strong, nonatomic) NSMutableArray * salesVolume;//商品推荐

@property(strong, nonatomic) XWShopExplainModel * mapUrlList;//图文参数
@property(strong,nonatomic) NSString * whetherCollectList; // 收藏状态 1 以收藏 0 未收藏

/*
 *  运费
 */

@property(strong, nonatomic) HPFreightMode * freightS;// 运费


@end

