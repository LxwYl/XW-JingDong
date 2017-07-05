//
//  HPCommentFooterView.m
//  HPShop
//
//  Created by 李学文 on 2017/3/5.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import "HPCommentFooterView.h"

@implementation HPCommentFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.distributionStarVContent = [[CWStarRateView alloc] initWithFrame:CGRectMake(0, 0, 105, 20) numberOfStars:5];
   
    self.distributionStarVContent.scorePercent = 0.2;
    self.distributionStarVContent.allowIncompleteStar = NO;
    self.distributionStarVContent.hasAnimation = YES;
    self.distributionStarVContent.delegate = self;
    [self.distributionStarView addSubview:self.distributionStarVContent];

    self.goodStarVContent = [[CWStarRateView alloc] initWithFrame:CGRectMake(0, 0, 105, 20) numberOfStars:5];
     self.goodStarVContent.delegate = self;
    self.goodStarVContent.scorePercent = 0.2;
    self.goodStarVContent.allowIncompleteStar = NO;
    self.goodStarVContent.hasAnimation = YES;
    [self.goodStarView addSubview:self.goodStarVContent];

     _goodStarVbl.text = @"差评";
    _distributionStarVbl.text = @"差评";
}
#pragma mark-
#pragma mark- CWStarRateView 星级评价代理
- (void)starRateView:(CWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent
{
    CommentstarType  type = CommentstarTypeOfdistributionStarV;
    newScorePercent =  newScorePercent *5;
    if ([starRateView isEqual: self.distributionStarVContent]) {
        if (newScorePercent>=3&&newScorePercent<=4) {
            _distributionStarVbl.text = @"中评";
            //中评
        }else if (newScorePercent>=0&&newScorePercent<3)
        {
            //差评
             _distributionStarVbl.text = @"差评";
        }else if (newScorePercent>4)
        {
            //好评
             _distributionStarVbl.text = @"好评";
        }
        type = CommentstarTypeOfdistributionStarV;
    }else if ([starRateView isEqual: self.goodStarVContent])
    {
        if (newScorePercent>=3&&newScorePercent<=4) {
            
            _goodStarVbl.text = @"中评";
            //中评
        }else if (newScorePercent>=0&&newScorePercent<3)
        {
            //差评
             _goodStarVbl.text = @"差评";
        }else if (newScorePercent>4)
        {
            //好评
             _goodStarVbl.text = @"好评";
        }
        type  = CommentstarTypeOfgoodStarV;
    }
    
    
    if ([self.delegate respondsToSelector:@selector(HPCommentFooterView:starRateView:scroePercentDidChange:abountType:)]) {
        
        [self.delegate HPCommentFooterView:self starRateView:starRateView scroePercentDidChange:newScorePercent abountType:type];
    }
}

@end
