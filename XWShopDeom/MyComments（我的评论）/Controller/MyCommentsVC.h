//
//  MyCommentsVC.h
//  HPShop
//
//  Created by 李学文 on 2017/2/27.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum HPCommentsType
{
    HPCommentsTypeForMe,
    HPCommentsTypeForGoods,
}HPCommentsType;
@interface MyCommentsVC : UIViewController

@property(assign, nonatomic) HPCommentsType type;
@property(strong, nonatomic) NSString* commodityId;// 从商品详情进入的时候需要传入商品ID
@end
