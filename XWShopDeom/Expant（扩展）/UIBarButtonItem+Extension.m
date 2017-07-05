
//
//  UIBarButtonItem+Extension.m
//  tabBar以及导航框架搭建
//
//  Created by 韩军强 on 15/12/28.
//  Copyright © 2015年 韩军强. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@interface UIBarButtonItem ()

@property (nonatomic, strong) UIBarButtonItem *barItem;
@end
@implementation UIBarButtonItem (Extension)

+ (UIButton *) shareBarButtonItem
{
    static  UIButton *itemBtn;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        itemBtn = [[UIButton alloc]init];
    });
    return itemBtn;
}

+ (UILabel *) shareTitleView
{
    static  UILabel *titleView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        titleView = [[UILabel alloc]init];
    });
    return titleView;
}



+(void)hiddenBackTitle
{
    [[UIBarButtonItem appearance]setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)forBarMetrics:UIBarMetricsDefault];
//    [UIBarButtonItem shareBarButtonItem].tintColor=[UIColor whiteColor];
//    [UIBarButtonItem appearance].tintColor = [UIColor whiteColor];
//    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]} forState:UIControlStateNormal];
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
}

//+(UIBarButtonItem *)barButtonItemWithNorImageName:(NSString *)norImageName target:(id)target action:(SEL)action
//{
//    UIButton *button=[UIBarButtonItem shareBarButtonItem];
//    
//    [button setImage:[UIImage imageNamed:norImageName] forState:UIControlStateNormal];
//    [button setImage:[UIImage imageNamed:norImageName] forState:UIControlStateSelected];
//    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    button.frame=CGRectMake(0, 0, 40, 30);
//    
//    return [[UIBarButtonItem alloc]initWithCustomView:button];
//}


+(NSArray *)barButtonItemWithSize:(CGSize)size FontH:(CGFloat )fontH andColor:(UIColor *)color space:(CGFloat)spaceW image:(NSString *)imageName target:(id)target action:(SEL)action withTitle:(NSString *)title
{
    //这里的自定义按钮不能抽出来，不然执行事件的就是item了，会报错
        UIButton *button=[UIBarButtonItem shareBarButtonItem];
        button.frame=CGRectMake(0, 0, size.width, size.height);
    if (title.length>0) {
        
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:color forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont systemFontOfSize:fontH];
    }else
    {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
#warning 图片左右位置
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = spaceW;//自己设定
    
    return [NSArray arrayWithObjects:space,rightItem, nil];
}


+(UILabel *)barButtonItemForTitleView:(NSString *)title color:(UIColor *)color fontH:(CGFloat)fontH
{
    UILabel *titleLabel = [UIBarButtonItem shareTitleView];
    titleLabel.frame=CGRectMake(0, 0, 70, 25);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
    if (color) {
        titleLabel.textColor=color;
    }else
    {
        titleLabel.textColor = [UIColor whiteColor];
    }
    
    if (fontH) {
        titleLabel.font=[UIFont systemFontOfSize:fontH];
    }else
    {
        titleLabel.font=[UIFont systemFontOfSize:15];
    }
    
    return titleLabel;
}



//导航左、右按钮,创建新按钮。开辟新空间
+(NSArray *)barButtonItemWithSizeNewBtn:(CGSize)size FontH:(CGFloat )fontH andColor:(UIColor *)color space:(CGFloat)spaceW image:(NSString *)imageStr target:(id)target action:(SEL)action withTitle:(NSString *)title
{
    //这里的自定义按钮不能抽出来，不然执行事件的就是item了，会报错
    UIButton *button=[UIButton new];
    button.frame=CGRectMake(0, 0, size.width, size.height);
    if (title.length>0) {
        
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:color forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont systemFontOfSize:fontH];
    }else
    {
        [button setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imageStr] forState:UIControlStateHighlighted];

    }
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    button.clipsToBounds = YES;
    
    //把返回按钮放在一个view上面，然后添加到导航上，不然返回的范围很大。
    UIView *leftView = [UIView new];
    leftView.frame= button.frame;
    [leftView addSubview:button];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:leftView];
    
#warning 图片左右位置
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = spaceW;//自己设定
    
    return [NSArray arrayWithObjects:space,rightItem, nil];
}


//导航titleView,创建新label
+(UILabel *)barButtonItemForTitleViewNewLabel:(NSString *)title color:(UIColor *)color fontH:(CGFloat)fontH
{
    UILabel *titleLabel = [UILabel new];
    titleLabel.frame=CGRectMake(0, 0, 70, 25);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
    if (color) {
        titleLabel.textColor=color;
    }else
    {
        titleLabel.textColor = [UIColor whiteColor];
    }
    
    if (fontH) {
        titleLabel.font=[UIFont systemFontOfSize:fontH];
    }else
    {
        titleLabel.font=[UIFont systemFontOfSize:15];
    }
    
    return titleLabel;
}

@end
