//
//  XWAddShopBar.h
//  HPShop
//
//  Created by 李学文 on 2017/3/28.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FL_Button.h"
@class XWAddShopBar;
@protocol XWAddShopBarDelegate <NSObject>

-(void)XWAddShopBar:(XWAddShopBar*)bar ClickbootomBarWithBtn:(UIButton *)sender  withIndex:(NSInteger )index;

@end

@interface XWAddShopBar : UIView

@property(weak, nonatomic) id<XWAddShopBarDelegate> delegate;
@property(strong, nonatomic) FL_Button * follwBtn;//关注按钮
-(void)XWAddShopBarfollwBtnWithState:(NSInteger)state;
@end
