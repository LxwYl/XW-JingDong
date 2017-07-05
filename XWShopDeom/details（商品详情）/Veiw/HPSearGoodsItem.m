//
//  HPSearGoodsItem.m
//  HPShop
//
//  Created by 李学文 on 2017/2/20.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import "HPSearGoodsItem.h"
//#import "HPLoginController.h"
@implementation HPSearGoodsItem

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _ContentBottomView.height = (SCREEN_WIDTH-3)/2;
    UISwipeGestureRecognizer *swipeleft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(ContentSwiPe:)];
     [swipeleft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.contentView addGestureRecognizer:swipeleft];
    UISwipeGestureRecognizer *swiperight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(ContentSwiPe:)];
    [swiperight setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.contentView addGestureRecognizer:swiperight];
    
    if (UI_IS_IPHONE5||UI_IS_IPHONE4) {
        _peoplesbl.font =[UIFont systemFontOfSize:12];
        _pricebl.font =[UIFont systemFontOfSize:14];
        _contentbl.font =[UIFont systemFontOfSize:12];
    }else
    {
        _peoplesbl.font =[UIFont systemFontOfSize:15];
        _pricebl.font =[UIFont systemFontOfSize:17];
        _contentbl.font =[UIFont systemFontOfSize:15];
    }
}

// 侧滑动作
-(void)ContentSwiPe:(UISwipeGestureRecognizer*)gestureRecognizer
{
    if (gestureRecognizer.direction==UISwipeGestureRecognizerDirectionRight) {
        
        self.ContentViewX.constant = 0;
        self.ContentViewright.constant = 0;
//        self.ContentViewX.constant = -(SCREEN_WIDTH-3)/2/3;
//        self.ContentViewright.constant = (SCREEN_WIDTH-3)/3;
    }else if (gestureRecognizer.direction==UISwipeGestureRecognizerDirectionLeft)
    {
        self.ContentViewX.constant = -(SCREEN_WIDTH-3)/2/3;
        self.ContentViewright.constant = (SCREEN_WIDTH-3)/3;
    }
}
/*
-(void)setModel:(HPGoodsModel *)model
{
       _model =model;
    
    if (_model.store_price.length==0) {

         _pricebl.text = [NSString stringWithFormat:@"¥%.2lf",[[DJTUtility YRIsEmptString:_model.store_pric] floatValue]];
    }else
    {
       _pricebl.text = [NSString stringWithFormat:@"¥%.2lf",[[DJTUtility YRIsEmptString:_model.store_price] floatValue]];

    }
    
    [_headerimageview  sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",BASEURL,model.pathName]] placeholderImage:[UIImage imageNamed:@"guide_1"]];
    NSString * count;
    count = [DJTUtility YRIsEmptString:model.goods_salenum];
    if ([[DJTUtility YRIsEmptString:model.goods_salenum] isEqualToString:@""]) {
        count = @"0";
    }
    _peoplesbl.text =[NSString stringWithFormat:@"%@人付款",count];
    _contentbl.text = model.goods_name;
    
    
    
}

-(void)SetSeargoodsModel:(HPGoodsModel *)searchmodel
{
        _searchmodel = searchmodel;
    _pricebl.text = [NSString stringWithFormat:@"¥%.2lf",[[DJTUtility YRIsEmptString:searchmodel.store_price] floatValue]];
    
    [_headerimageview  sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@",BASEURL,searchmodel.path,searchmodel.name]] placeholderImage:[UIImage imageNamed:@"guide_1"]];
    _peoplesbl.text =[NSString stringWithFormat:@"%@人付款",searchmodel.goods_salenum];
    _contentbl.text = searchmodel.goods_name;
}
 */
// 点击购物车
- (IBAction)ClickAddCar:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(HPSearGoodsItem:ClickAddCar:)]) {
        
        [self.delegate HPSearGoodsItem:self ClickAddCar:sender];
    }
    
}



// 点击收藏
- (IBAction)ClickAddCollect:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(HPSearGoodsItem:ClickAddCollect:)]) {
        
        [self.delegate HPSearGoodsItem:self ClickAddCollect:sender];
    }
    
}



@end
