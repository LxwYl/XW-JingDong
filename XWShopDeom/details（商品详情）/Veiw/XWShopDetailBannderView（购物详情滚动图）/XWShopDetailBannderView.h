//
//  XWShopDetailBannderView.h
//  HPShop
//
//  Created by 李学文 on 2017/4/13.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XWShopDetailBannderView;
@protocol XWShopDetailBannderViewDelegate <NSObject>
/** 点击图片回调 */
-(void)XWShopDetailBannderView:(XWShopDetailBannderView*)View didSelectItemAtIndex:(NSInteger)index;
/** 图片滚动回调 */
-(void)XWShopDetailBannderView:(XWShopDetailBannderView*)View didScrollToIndex:(NSInteger)index;
@end

@interface XWShopDetailBannderView : UIView


@property (nonatomic, weak) id<XWShopDetailBannderViewDelegate> delegate;

/** 占位图，用于网络未加载到图片时 */
@property (nonatomic, strong) UIImage *placeholderImage;
/** 网络图片 url string 数组 */
@property (nonatomic, strong) NSArray *imageURLStringsGroup;
/** pageButton 页码 */
@property(strong, nonatomic) UIButton * pageButton;
/** 页码字体 */
/** 页码背景颜色 */
/** 页码背景图片 */
/** 页码透明度 */
/** 页码位置 */
#pragma mark- 代码左滑
-(void)makeCodeLeftScroll;
#pragma mark- 代码又滑
-(void)makeCodeRightScroll;
@end
