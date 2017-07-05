//
//  XWShopSelectSizeView.h
//  HPShop
//
//  Created by 李学文 on 2017/3/28.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWShopDetetailsModel.h"
@class XWShopSelectSizeView;
@protocol XWShopSelectSizeViewDelegate <NSObject>

-(void)XWShopSelectSizeView:(XWShopSelectSizeView*)View ClickAddCar:(UIButton*)sender;
-(void)XWShopSelectSizeView:(XWShopSelectSizeView*)View ClickGoBuy:(UIButton*)sender;

@end

@interface XWShopSelectSizeView : UIView

typedef void(^BlockUpdateBtnTitle)(NSString *contentstr,NSInteger count);


@property (nonatomic, copy) BlockUpdateBtnTitle blockUpdateBtnTitle;


/**
 *  数据
 */
@property(strong, nonatomic) NSMutableArray * dataArr;

@property(weak,nonatomic) id<XWShopSelectSizeViewDelegate> degate;

@property(strong,nonatomic) XWcommodityMessageModel * Goodsmodel;

/**
 *  显示
 */
- (void)show;

/**
 *  消失
 */
- (void)dismiss;


/**
 *  3D显示
 */
- (void)showWith3D:(BOOL)isYes;

/**
 *  3D消失
 */
- (void)dismissWith3D:(BOOL)isYes;


@end
