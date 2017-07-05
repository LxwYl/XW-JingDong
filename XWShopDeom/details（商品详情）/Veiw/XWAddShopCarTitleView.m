//
//  XWAddShopCarTitleView.m
//  HPShop
//
//  Created by 李学文 on 2017/3/27.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import "XWAddShopCarTitleView.h"
#import "XWTitleSegmentView.h"
#define TITLE_W 150
#define LINE_H 1.5
@interface XWAddShopCarTitleView()<KXWTitleSegmentViewDelegate,UIScrollViewDelegate>
/*
 * 基于滚动
 */
@property(strong, nonatomic) UIScrollView * contentscrollView;

@property(strong, nonatomic) UIView * titleSegmentView;

@property(strong, nonatomic) UIImageView * line;

@property(strong, nonatomic) UIButton * selectBtn;

@property(strong, nonatomic) UILabel * titleLable;

@end
@implementation XWAddShopCarTitleView

-(instancetype)initWithFrame:(CGRect)frame
{
    frame = CGRectMake(0, 0, TITLE_W, 44);
    self =[super initWithFrame:frame];
    if (self) {
        
        [self CreatTitleSegmentView];
        [self CreatTitleLble];
    }
    return self;
}
#pragma mark- 创建titleSegmentView
-(void)CreatTitleSegmentView
{
    
//       self.titleSegmentView.delegate = self;
//    self.titleSegmentView.titleArr = @[@"商品",@"详情",@"评价"];
    [self.contentscrollView addSubview:self.titleSegmentView];
   NSArray * titlearr = @[@"商品",@"详情",@"评价"];
//    self.titleView.frame =CGRectMake(0, 64, self.width, TITLE_H);
    for (int i =0; i<titlearr.count; i++) {
        
        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
        
        [button addTarget:self action:@selector(ClicktitleBtn:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:[titlearr objectAtIndex:i] forState:UIControlStateNormal ];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        button.titleLabel.font =[UIFont systemFontOfSize:15];
        
        CGFloat  W = self.width/3;
        
        
        button.frame = CGRectMake(W*i, 0, W,44);
        
        button.tag = 300 + i;
        [self.titleSegmentView addSubview:button];
        
        if (i==0) {
            
            _selectBtn = button;
            self.line =[[UIImageView alloc] initWithFrame:CGRectMake(0, 44-1.5, 26, LINE_H)];
            [self.titleSegmentView addSubview:self.line];
            
            self.line.centerX = button.centerX;
            button.selected = YES;
            self.line.backgroundColor =[UIColor blackColor];
        }
    }
}
#pragma mark- 标题切换
-(void)ClicktitleBtn:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(XWAddShopCarTitleView:ClickTitleWithTag:andButton:)]) {
        
        [self.delegate XWAddShopCarTitleView:self ClickTitleWithTag:sender.tag-300 andButton:sender];
    }
    
    _selectBtn.selected = !_selectBtn.selected;
    
    sender.selected = !sender.selected;
    
    _selectBtn = sender;
    [UIView animateWithDuration:0.3 animations:^{
        
        self.line.centerX = sender.centerX;
        
    } completion:^(BOOL finished) {
        
    }];
    // 刷新webView
    
}



#pragma mark- 创建titleLble
-(void)CreatTitleLble
{
    [self.contentscrollView addSubview:self.titleLable];
}
#pragma mark- 滚动展示titleSegmentView
-(void)ScrollShowTitleSegmentViewWithDuration:(CGFloat)duration
{
   [UIView animateWithDuration:duration animations:^{
        self.contentscrollView.contentOffset = CGPointMake(0, 0);
   } completion:nil];
    
}
#pragma mark- 滚动展示titleLable
-(void)ScrollShowTitleLableWithDuration:(CGFloat)duration
{
    [UIView animateWithDuration:duration animations:^{
        self.contentscrollView.contentOffset = CGPointMake(0, 44);
    } completion:nil];
    
}
#pragma mark- 设置选中
-(void)updataSelectTitleWithTag:(NSInteger)tag
{
    _selectBtn.selected =NO;
    
    UIButton * button = [self viewWithTag:tag+300];
    
    button.selected = YES;
    
    _selectBtn = button;
    [UIView animateWithDuration:0.3 animations:^{
        
        self.line.centerX = button.centerX;
        
    } completion:^(BOOL finished) {
        
    }];
    
}
#pragma mark-get
-(UIScrollView *)contentscrollView
{
    if (!_contentscrollView) {
        _contentscrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0,0, self.width,44)];
        _contentscrollView.contentSize = CGSizeMake(TITLE_W, 44*2);

        _contentscrollView.scrollEnabled =NO;
        _contentscrollView.showsVerticalScrollIndicator = NO;
        _contentscrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_contentscrollView];
    }
    return _contentscrollView;
}
-(UIView *)titleSegmentView
{
    if (!_titleSegmentView) {
        _titleSegmentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TITLE_W, 44)];
    }
    return _titleSegmentView;
}
-(UILabel *)titleLable
{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 44, TITLE_W, 44)];
        
        _titleLable.font =[UIFont systemFontOfSize:17];
        
        _titleLable.text =@"图文详情";
        _titleLable.textAlignment = UITextAlignmentCenter;

    }
    return _titleLable;
}

@end
