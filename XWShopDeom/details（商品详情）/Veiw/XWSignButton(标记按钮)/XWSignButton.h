//
//  XWSignButton.h
//  XWSignButton
//
//  Created by 李学文 on 2017/2/26.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum XWSignButtonType
{
    XWSignButtonTypeWithNumber,// 显示数量
    XWSignButtonTypeWithNumberSpot,//显示红点
}XWSignButtonType;
@interface XWSignButton : UIButton

//标记数量
@property(strong, nonatomic) NSString * NumberStr;
//标记视图Lable
@property(strong, nonatomic) UILabel * NumberLable;
@property(assign,nonatomic) XWSignButtonType Type;
@property(assign, nonatomic) NSInteger  MaxNumber;//最大显示数量 ，超过显示MaxNumber++
@property(assign, nonatomic) CGFloat redSignWide;//标记的宽
@property(strong, nonatomic) UIFont * numberFont;//标记字体大小


//初始化Type
-(void)XWSignButtoninit:(XWSignButtonType)type;

// 隐藏和展示
-(void)HideXWSignButtonSign;
-(void)ShowXWSignButtonSign;

//更新数量
-(void)UpdataCreatXWSignButtonNumber:(NSInteger)number;

@end
