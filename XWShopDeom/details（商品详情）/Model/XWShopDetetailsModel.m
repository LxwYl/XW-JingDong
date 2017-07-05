//
//  XWShopDetetailsModel.m
//  HPShop
//
//  Created by 李学文 on 2017/4/12.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import "XWShopDetetailsModel.h"

@implementation XWShopbannderModel

@end


@implementation XWShopCommentModel

@end


@implementation XWStoreMessageModel

@end


@implementation XWcommodityMessageModel

@end


@implementation XWShopcatgorylistModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"catgoryList":[XWShopcatgoryModel class]
             };
}
@end



@implementation XWShopcatgoryModel

@end


@implementation XWShopsalesVolumeModel

@end

@implementation XWShopExplainModel

@end

@implementation XWShopDetetailsModel


+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"commodityPropertyList":[XWShopcatgorylistModel class],
             @"imgList":[XWShopbannderModel class],
             @"salesVolume":[XWShopsalesVolumeModel class],
             @"EvaluateList":[XWShopCommentModel class],
             @"StoreMessage":[XWStoreMessageModel class],
             @"commodityMessageList":[XWShopcatgorylistModel class],
             @"mapUrlList":[XWShopExplainModel class]
             };
}

@end


