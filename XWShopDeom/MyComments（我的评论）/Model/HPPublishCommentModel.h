//
//  HPPublishCommentModel.h
//  HPShop
//
//  Created by 李学文 on 2017/4/10.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPPublishCommentModel : NSObject
@property(strong,nonatomic) NSString * evaluate_buyer_val;//评价（好、中、差）
@property(strong, nonatomic) NSString * goodsId;//商品ID
@property(strong,nonatomic) NSString *evaluate_info;//评论内容
@property(strong, nonatomic) NSString * description_evaluate;//商品评分（1-5）
@property(strong, nonatomic) NSString * ship_evaluate;//物流评分（1-5）
@property(strong,nonatomic) NSMutableArray *photoArry;//photoFile 图片数组
@property(strong, nonatomic) NSString * commodityTopMath;//图片路径
@property(strong,nonatomic) NSString * commodityId;//ID
@property(strong,nonatomic) NSString * commodityName;// name



@end
