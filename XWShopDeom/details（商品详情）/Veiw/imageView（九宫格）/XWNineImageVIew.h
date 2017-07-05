//
//  XWNineImageVIew.h
//  HPShop
//
//  Created by 李学文 on 2017/2/27.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWNineImageVIew : UIView<UIGestureRecognizerDelegate>

@property(assign, nonatomic)  CGFloat Middle;//中间艰巨性

@property(assign, nonatomic) CGFloat leftspace;//左间距
@property(assign, nonatomic) CGFloat rightspace;//右间距
@property(assign, nonatomic) CGFloat topsapce;
@property(assign, nonatomic) CGFloat bottomsapce;

@property(strong, nonatomic) NSArray * imageArry;




@property(assign, nonatomic) CGFloat toalHigh;  //  最终高度

-(CGFloat)returnXWNineImageVIewHighWithCount:(NSInteger)count;//计算整个view的高度
@end
