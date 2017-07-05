//
//  UIBarButtonItem+Extension.h
//  tabBar以及导航框架搭建
//
//  Created by 韩军强 on 15/12/28.
//  Copyright © 2015年 韩军强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface UIBarButtonItem (Extension)

@property (nonatomic, strong) UIButton *itemBtn;

+(UIBarButtonItem *)barButtonItemWithNorImageName:(NSString *)norImageName target:(id)target action:(SEL)action;

/**
 *  导航titleView,重用。
 */
//+(UILabel *)barButtonItemForTitleView:(NSString *)title color:(UIColor *)color fontH:(CGFloat)fontH;
//
///**
// *  导航左、右按钮,重用。
// */
//+(NSArray *)barButtonItemWithSize:(CGSize)size FontH:(CGFloat )fontH andColor:(UIColor *)color space:(CGFloat)spaceW image:(NSString *)imageName target:(id)target action:(SEL)action withTitle:(NSString *)title;

/**
 *  导航左、右按钮,创建新按钮。
 */
+(NSArray *)barButtonItemWithSizeNewBtn:(CGSize)size FontH:(CGFloat )fontH andColor:(UIColor *)color space:(CGFloat)spaceW image:(NSString *)imageStr target:(id)target action:(SEL)action withTitle:(NSString *)title;
/**
 *  导航titleView,创建新label
 */
+(UILabel *)barButtonItemForTitleViewNewLabel:(NSString *)title color:(UIColor *)color fontH:(CGFloat)fontH;


+(void)hiddenBackTitle;

@end
