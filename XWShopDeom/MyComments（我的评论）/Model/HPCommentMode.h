//
//  HPCommentMode.h
//  HPShop
//
//  Created by 李学文 on 2017/2/27.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HPCommentReplyMode.h"
@interface HPCommentMode : NSObject
//EvaluateReplyList =                 (
//);
//addTime = "2014-01-02 18:55:11";
//"description_evaluate" = 5;
//"evaluate_buyer_val" = 1;
//"evaluate_info" = " \U60a8\U7684\U8bc4\U4ef7\U5c06\U662f\U5176\U4ed6\U4e70\U5bb6\U7684\U53c2\U8003";
//"evaluate_user_id" = 1;
//"goods_name" = "2016???? ????????????????A???";
//id = 1;
//pathName = "upload/store/1/2016/04/04/c51ca320-b9d9-4bed-b64a-f4768557f57c.jpg";
//personName = 11112;
//personPhoto = "resources/style/system/front/default/images/usercenter/headimg.jpg";
//photo =                 (
//);

@property(strong,nonatomic) NSString *addTime;//addTim
@property(strong,nonatomic) NSString *evaluate_buyer_val;//评价分数
@property(strong,nonatomic) NSString *evaluate_info;//评价内容
@property(strong,nonatomic) NSString *evaluate_user_id;
@property(strong,nonatomic) NSString *goods_name;//商品名称
@property(strong,nonatomic) NSString *id;
@property(strong,nonatomic) NSString *pathName;//
@property(strong,nonatomic) NSArray *photo; //图片列表
@property(strong,nonatomic) NSMutableArray *EvaluateReplyList;//回复列表
@property(strong,nonatomic) NSString *description_evaluate;
@property(strong,nonatomic) NSString *personPhoto;//个人头像
@property(strong,nonatomic) NSString *personName;//个人名称
@end
