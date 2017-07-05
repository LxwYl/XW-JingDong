//
//  HPSearGoodsItem.h
//  HPShop
//
//  Created by 李学文 on 2017/2/20.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "HPGoodsModel.h"
//#import "HPSupermarketModel.h"
//#import "HPhomebannderMode.h"
//#import "HPMyModel.h"
@class HPSearGoodsItem;
@protocol HPSearGoodsItemDelegate <NSObject>

-(void)HPSearGoodsItem:(HPSearGoodsItem*)cell ClickAddCar:(UIButton *)sender;// 添加购物车
-(void)HPSearGoodsItem:(HPSearGoodsItem*)cell ClickAddCollect:(UIButton *)sender;   //添加收藏

@end


@interface HPSearGoodsItem : UICollectionViewCell<UIGestureRecognizerDelegate>

/*添加购物车**/
@property (weak, nonatomic) IBOutlet UIButton *addCar_btn;
/*收藏**/
@property (weak, nonatomic) IBOutlet UIButton *addCollect_btn;
/*侧滑view **/
@property (weak, nonatomic) IBOutlet UIView *ContentBottomView;
/*侧滑view的左约束**/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ContentViewX;
/*侧滑view的右约束**/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ContentViewright;
/*头像**/
@property (weak, nonatomic) IBOutlet UIImageView *headerimageview;
/*标题内容**/
@property (weak, nonatomic) IBOutlet UILabel *contentbl;
/*已购买人数**/
@property (weak, nonatomic) IBOutlet UILabel *peoplesbl;
/*价钱**/
@property (weak, nonatomic) IBOutlet UILabel *pricebl;
//
//@property(strong, nonatomic) HPGoodsModel * model;
//
//@property(strong,nonatomic) listHotGoods * superModel;//12仓库的模型

@property(weak, nonatomic) id <HPSearGoodsItemDelegate> delegate;
///* 搜索商品model**/
//@property(strong, nonatomic) HPGoodsModel * searchmodel;
///* 首页商品 **/
//@property(strong, nonatomic) HPhomebannderMode * homeMode;
///* 我的历史足迹 **/
//@property(strong, nonatomic) HPMyModel * MeMode;
//-(void)SetSeargoodsModel:(HPGoodsModel *)searchmodel;
- (IBAction)ClickAddCar:(UIButton *)sender;
- (IBAction)ClickAddCollect:(UIButton *)sender;

@end
