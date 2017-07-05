//
//  HPCommentFooterView.h
//  HPShop
//
//  Created by 李学文 on 2017/3/5.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import <UIKit/UIKit.h>
// 高设置为308
#import "CWStarRateView.h"

typedef enum CommentstarType
{
    CommentstarTypeOfdistributionStarV,
    CommentstarTypeOfgoodStarV
}CommentstarType;
@class HPCommentFooterView;
@protocol HPCommentFooterViewDelegate <NSObject>

-(void)HPCommentFooterView:(HPCommentFooterView*)View starRateView:(CWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent abountType:(CommentstarType)type;

@end

@interface HPCommentFooterView : UIView<CWStarRateViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *distributionStarView;
@property (weak, nonatomic) IBOutlet UIView *goodStarView;
@property (weak, nonatomic) IBOutlet UILabel *distributionStarVbl;
@property (weak, nonatomic) IBOutlet UILabel *ordernumberbl;
@property (weak, nonatomic) IBOutlet UILabel *ordertimebl;

@property(strong, nonatomic) CWStarRateView * distributionStarVContent;//配送星级评级
@property(strong, nonatomic) CWStarRateView * goodStarVContent;//商品星级评价
@property (weak, nonatomic) IBOutlet UILabel *goodStarVbl;

@property (weak, nonatomic) IBOutlet UIButton *publishBtn;
@property(weak, nonatomic) id<HPCommentFooterViewDelegate> delegate;


@end
