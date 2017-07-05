//
//  HPCommentsCell.h
//  HPShop
//
//  Created by 李学文 on 2017/2/27.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPCommentMode.h"
#import "HPCommentGoodsView.h"
#import "XWNineImageVIew.h"
#import "CWStarRateView.h"
typedef enum HPCommentsCellType
{
    HPCommentsCellTypeOnlyPhoto,// 显示图片带评论的（商品详情的评论）
    HPCommentsCellTypeHaveGoods,// 显示图片，物品信息带评论的（w我的评论）
    
}HPCommentsCellType;
@interface HPCommentsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIImageView *headerimageView;
@property (weak, nonatomic) IBOutlet UILabel *content_bl;
@property (weak, nonatomic) IBOutlet UILabel *name_bl;

@property (weak, nonatomic) IBOutlet UILabel *time_bl;


@property(strong, nonatomic) HPCommentMode * model;
@property(assign, nonatomic) HPCommentsCellType  Type; //
@property(strong, nonatomic) XWNineImageVIew * XWPhotoView;     // 展示图片
@property(strong, nonatomic) HPCommentGoodsView * goodsView;   // 展示物品信息

@property(strong,nonatomic) CWStarRateView *goodStarVContent;

-(void)SetCommentMode:(HPCommentMode*)model andType:(HPCommentsCellType)type;

-(void)ceshi;

@end
