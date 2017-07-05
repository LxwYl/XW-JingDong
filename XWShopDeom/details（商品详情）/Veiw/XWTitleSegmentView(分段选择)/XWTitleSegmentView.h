//
//  XWTitleSegmentView.h
//  HPShop
//
//  Created by 李学文 on 2017/3/15.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import <UIKit/UIKit.h>

static  CGFloat paddingValue =7; // 文字左右的间距（目的是让按钮的点击范围变大一点）

static  CGFloat lineheight= 2 ;// 线的高度

static  CGFloat spacing =10; // 每个title控件间的间距



typedef enum XWTitleSegmentViewType
{
    XWTitleSegmentViewTypeOfScroll,//滚动
    XWTitleSegmentViewTypeOfFixed,// 固定
}XWTitleSegmentViewType;

@class XWTitleSegmentView;

@protocol KXWTitleSegmentViewDelegate <NSObject>
// 监听选中的title
-(void)XWTitleSegmentView:(XWTitleSegmentView*)view didselectOfIndex:(NSInteger)index;

@end


@interface XWTitleSegmentView : UIView

/**
 * 标题文字大小
 */
@property(strong, nonatomic) UIFont * font;
/**
* 被选中的颜色
*/
@property(strong, nonatomic) UIColor * selectfontColor;
/**
 * 正常颜色
 */
@property(strong, nonatomic) UIColor * fontColor;
/**
 * 选中下滑线颜色
 */
@property(strong, nonatomic) UIColor * selectlineColeor;
/**
* 内间距 （标题和view边界的宽度）
*/
@property(assign, nonatomic) CGFloat padding;

/**
 * 标题数组
 */
@property(strong, nonatomic) NSArray * titleArr;
/**
 * 图标数组
 */
@property(strong, nonatomic) NSMutableArray * imageArr;//暂未处理

/**
 * 是否显示下滑线
 */
@property(assign, nonatomic) bool haveline;

/**
 *  type
 */
@property(assign, nonatomic) XWTitleSegmentViewType type;

@property(weak, nonatomic) id<KXWTitleSegmentViewDelegate> delegate;

@end
