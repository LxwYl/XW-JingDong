//
//  XWShopDetetailsCell.h
//  HPShop
//
//  Created by 李学文 on 2017/3/28.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWStarRateView.h"
#import "XWShopDetetailsModel.h"
@class XWShopDetetailsCell;
@protocol XWShopDetetailsCellDelegate <NSObject>


-(void)XWShopDetetailsCell:(XWShopDetetailsCell*)cell ClickGotoStaoreButton:(UIButton *)sender;
-(void)XWShopDetetailsCell:(XWShopDetetailsCell*)cell ClickMoreGoods:(UIButton *)sender;
-(void)XWShopDetetailsCell:(XWShopDetetailsCell*)cell didSelectItemAtIndexPath:(NSIndexPath *)indexPath withStoreId:(NSString *)StoreId;
@end

@interface XWShopDetetailsCell : UITableViewCell

@property(strong, nonatomic) id<XWShopDetetailsCellDelegate> delegate;

//
@property (weak, nonatomic) IBOutlet UILabel *goodsName;

@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *pricegray;
@property (weak, nonatomic) IBOutlet UIImageView *pricegraline;

@property (weak, nonatomic) IBOutlet UIButton *infoBtn;

@property (weak, nonatomic) IBOutlet UIButton *jq_DiscountBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *jq_DisCountHeigh;
@property (weak, nonatomic) IBOutlet UIImageView *jq_couponImgView;

//2

@property (weak, nonatomic) IBOutlet UILabel *cateroySize;



//3
@property (weak, nonatomic) IBOutlet UILabel *commentNumber;

@property (weak, nonatomic) IBOutlet UILabel *Percentage;
@property (weak, nonatomic) IBOutlet UIImageView *commentHeader;
@property (weak, nonatomic) IBOutlet UILabel *commentContent;

@property (weak, nonatomic) IBOutlet UILabel *commentName;
@property(strong, nonatomic)CWStarRateView * goodStarVContent;// 星星
@property (weak, nonatomic) IBOutlet UIView *commentView;
@property (weak, nonatomic) IBOutlet UILabel *commentTime;

//4


@property (weak, nonatomic) IBOutlet UIImageView *storeheader;

@property (weak, nonatomic) IBOutlet UILabel *storenamebl;

@property (weak, nonatomic) IBOutlet UIButton *allGoodsbtn;
@property (weak, nonatomic) IBOutlet UIButton *cornBtn;
@property (weak, nonatomic) IBOutlet UIButton *storeAction;

@property (weak, nonatomic) IBOutlet UILabel *allGoodcount;
@property (weak, nonatomic) IBOutlet UILabel *corncount;
@property (weak, nonatomic) IBOutlet UILabel *storeActioncount;


- (IBAction)ClickallGoodButton:(UIButton *)sender;
- (IBAction)ClickcornButton:(UIButton *)sender;
- (IBAction)ClickstoreActionButton:(UIButton *)sender;
- (IBAction)ClickGotoStaoreButton:(UIButton *)sender;


//5

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property(strong, nonatomic) UICollectionView * mainCollection;//同类推荐

- (IBAction)ClickMoreGoods:(UIButton *)sender;

//========

@property(strong, nonatomic) XWShopDetetailsModel * model;
+ (instancetype)XWShopDetetailsCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
- (void)configTempCellWith:(NSIndexPath *)indexPath;
@end
