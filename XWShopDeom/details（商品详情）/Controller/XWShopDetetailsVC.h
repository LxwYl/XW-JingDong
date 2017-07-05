//
//  XWShopDetetailsVC.h
//  HPShop
//
//  Created by 李学文 on 2017/3/28.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPhomebannderMode.h"

@interface XWShopDetetailsVC : UIViewController
@property(strong,nonatomic) NSString * commodityId;//商品ID

@property (nonatomic, strong) HPhomebannderMode *lastVCModel;
@end
