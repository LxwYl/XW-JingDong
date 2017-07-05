//
//  XWPhotoWebView.h
//  HPShop
//
//  Created by 李学文 on 2017/3/27.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@class XWPhotoWebView;
@protocol XWPhotoWebViewDelegate <NSObject>

-(void)XWPhotoWebViewDropdown:(XWPhotoWebView*)View;

@end

@interface XWPhotoWebView : UIView

@property(weak, nonatomic) id<XWPhotoWebViewDelegate>  delegate;
/*
 * 是否开启下拉监听
 */
@property(assign, nonatomic) BOOL Yesdrop;
/*
 *
 */
@property(strong, nonatomic) NSString * goodsId;
@end
