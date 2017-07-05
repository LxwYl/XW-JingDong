//
//  XWTitleSegmentView.m
//  HPShop
//
//  Created by 李学文 on 2017/3/15.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import "XWTitleSegmentView.h"
static  NSString * identifer = @"XWTitleSegmentViewID";
@interface XWTitleSegmentView ()<UICollectionViewDelegate,UICollectionViewDataSource>


/**
 * 下划线
 */
@property(strong, nonatomic) UIView * underline;

/**
 * 默认选中的标题
 */
@property(strong, nonatomic) UIButton * selectbtn;

/**
 *
 */
@property(strong, nonatomic) UIScrollView * titleScrollView;
@property (nonatomic, strong) NSMutableArray *titleWidthArray;          // store title widths

/**
 * titleview 的宽度
 */
@property(assign, nonatomic) CGFloat  titleContentWidth;
@end
@implementation XWTitleSegmentView

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        
        
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.titleScrollView.backgroundColor =[UIColor whiteColor];
        self.titleScrollView.frame = CGRectMake(0, 0 , frame.size.width, frame.size.height);
               
        
    }
    return self;
}

-(void)setTitleArr:(NSArray *)titleArr
{
    _titleArr = titleArr;
    self.titleScrollView.frame = CGRectMake(0, 0 , self.width, self.height);
    [self _calculateTitleContentWidth];
     [self SetuptitleView];
}
-(void)SetuptitleView
{
    CGFloat titleX = spacing;
    
    NSLog(@"----%lf，%lf",self.titleScrollView.width,self.titleScrollView.height);
    
    for (int i=0; i<self.titleArr.count; i++) {
        
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
       // [button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        CGFloat titlebtnW = 0.0;
        [button addTarget:self action:@selector(clickTitleWithButton:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = self.font;
        [button setTitle:[_titleArr objectAtIndex:i] forState:UIControlStateNormal ];
        [button setTitleColor:self.fontColor forState:UIControlStateNormal];
        [button setTitleColor:self.selectfontColor forState:UIControlStateSelected];
       
        // 计算标题的宽度
        button.tag = 600 + i;
        titlebtnW =[self.titleWidthArray[i] floatValue]+paddingValue*2;
        button.frame = CGRectMake(titleX, 0, titlebtnW, self.height-lineheight);
       //  button.frame = CGRectMake(0, 0, 20, 30);
        titleX = titleX + titlebtnW+spacing;
        [self.titleScrollView addSubview:button];
        if (i==0) {
            
            // 创建下滑线
            
            self.underline.frame = CGRectMake(0, self.height-lineheight,titlebtnW-paddingValue*2, lineheight);
            self.underline.centerX = button.centerX;
            
            [self.titleScrollView addSubview:self.underline];
            
            // 设置默认选中
            
            button.selected = YES;
            self.selectbtn = button;
        }
    }
    
}
-(void)clickTitleWithButton:(UIButton *)sender
{
    NSInteger index = sender.tag -600;
    NSLog(@"点击了第%ld个title",index);
    
    self.selectbtn.selected = !self.selectbtn.selected;
    sender.selected =  !sender.selected;
    self.selectbtn = sender;
    
   
    
    // 判断往左移还是往右移
    /*
        需要判断当前的控件的中心位置是否在跟视图的左边还是右边，
     CtX: 选中的控件的centerX
     B：底部视图的X轴偏移量 titleScrollView.contentOffset.x
     O：跟视图的中心 self.centerX
     S：当前根视图的宽 self.widh
     C:title布局所需要的总宽度（ titleScrollView的contentSize.Width ）
     
     
  右偏：
     公式 ： CtX - B < O;
     
          1 .右偏有结余
     
          B>O-(Ctx-B) :偏移量为：B-（O-(Ctx-B)）
     
          2 .右偏无结余（有多少偏多少）
          B<O-(Ctx-B) 偏移量为：B
     
    左偏：
       公式：CtX - B < O;
         1.左边右结余
        （C-B）- S>(Ctx-B)-O :偏移量为：B+ (Ctx-B)-O
     
         2.右偏没结余
         （C-B）- S<(Ctx-B)-O :偏移量为：（C-B）- S
     
     */
    [UIView animateWithDuration:0.01 animations:^{
        if (sender.centerX-self.titleScrollView.contentOffset.x<self.centerX) {
            
            
            
            if (self.titleScrollView.contentOffset.x>self.centerX-(sender.centerX-self.titleScrollView.contentOffset.x)) {
                NSLog(@"将要往右移动:%lf",self.centerX-(sender.centerX-self.titleScrollView.contentOffset.x));
                
                //
                _titleScrollView.contentOffset=CGPointMake(self.titleScrollView.contentOffset.x-(self.centerX-(sender.centerX-self.titleScrollView.contentOffset.x)), 0);
            }else
            {
                NSLog(@"将要往右移动%lf,",_titleScrollView.contentOffset.x);
                _titleScrollView.contentOffset=CGPointMake(self.titleScrollView.contentOffset.x-(_titleScrollView.contentOffset.x), 0);
            }
        }
        else
        {
            
            
            if (self.titleContentWidth-self.titleScrollView.contentOffset.x-self.width>sender.x-self.titleScrollView.contentOffset.x-self.centerX) {
                
                NSLog(@"将要往左移动:%lf",sender.x-self.titleScrollView.contentOffset.x-self.centerX);
                _titleScrollView.contentOffset = CGPointMake( _titleScrollView.contentOffset.x+sender.centerX-self.titleScrollView.contentOffset.x-self.centerX, 0);
            }else
            {
                NSLog(@"将要往左移动:%lf",self.titleContentWidth-self.titleScrollView.contentOffset.x-self.width);
                _titleScrollView.contentOffset = CGPointMake( _titleScrollView.contentOffset.x+self.titleContentWidth-self.titleScrollView.contentOffset.x-self.width, 0);
            }
        }

    } completion:^(BOOL finished) {
        
    }];
    
    // 改变下划线的位置
    
    [UIView animateWithDuration:0.4 animations:^{
        self.underline.width = [[self.titleWidthArray objectAtIndex:index] floatValue];
        self.underline.centerX = sender.centerX;
        
        
    }];
    
    if ([self.delegate respondsToSelector:@selector(XWTitleSegmentView:didselectOfIndex:)]) {
        
        [self.delegate XWTitleSegmentView:self didselectOfIndex:index];
    }
}


/**
 *  计算每个title的宽度 和titleScrollView显示的宽度
 */
- (void)_calculateTitleContentWidth {
    if (![self _isTitlesContentNotLessThanViewWidth:self.titleArr]) {
        //1 如果为NO 表示一个self.width 能够放下所有的标签 不需要滚动
        self.titleContentWidth = self.width;
        CGFloat titlesTotalLength = 0.0f;
        for (NSNumber *value in self.titleWidthArray) {
            titlesTotalLength += [value floatValue]+2*paddingValue;
        }
        
        // 重新计算每个title控件的间距，使他们能够正好充满全屏
        spacing = (self.width - titlesTotalLength )/(self.titleArr.count+1);
        return;
    }
    //2 表示一个self.width 放不下所有的标签 需要滚动 按照原来设置间距计算所需要的titleview的总宽度
    CGFloat titleContentWidth = 0;
    for (int index = 0; index < self.titleWidthArray.count; index ++) {
        
        titleContentWidth +=[self.titleWidthArray[index] floatValue]+2*paddingValue;
        
    }
    titleContentWidth = titleContentWidth + (self.titleWidthArray.count+1)*spacing;
    self.titleContentWidth = titleContentWidth;
    
    self.titleScrollView.contentSize = CGSizeMake(titleContentWidth, self.height);
}

/**
 *  先计算titles是否可以占满屏幕 可以就一个一个的布局 不可以就修改distanceBetweenTitles的值。刚好去占满屏幕
 */
- (BOOL)_isTitlesContentNotLessThanViewWidth:(NSArray *)dataArray {
    CGFloat titleContentWidth = 0;
    for (int index = 0; index < dataArray.count; index ++) {
       
        CGFloat calculate = [self widthFromString:[dataArray objectAtIndex:index] withFont:self.font constraintToHeight:self.height-lineheight];
        [self.titleWidthArray addObject:@(calculate)];
       // titleContentWidth += calculate;
       // titleContentWidth += (index == dataArray.count -1)?titleHorizontalMargin:distanceBetweenTitles;
        titleContentWidth += calculate+paddingValue*2;
    }
    titleContentWidth = titleContentWidth+spacing*(dataArray.count+1);
    return (titleContentWidth >= self.width);
}


- (CGFloat)widthFromString:(NSString*)text withFont:(UIFont*)font constraintToHeight:(CGFloat)height
{
    CGRect rect;
    
    float iosVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (iosVersion >= 7.0) {
        rect = [text boundingRectWithSize:CGSizeMake(1000, height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
    }else {
        CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(1000, height) lineBreakMode:NSLineBreakByWordWrapping];
        rect = CGRectMake(0, 0, size.width, size.height);
    }
    return rect.size.width ;
}


#pragma mark - get

- (UIScrollView *)titleScrollView {
    if (!_titleScrollView) {
        _titleScrollView = [[UIScrollView alloc] init];
        _titleScrollView.showsHorizontalScrollIndicator = NO;
        _titleScrollView.delegate = self;
        [self addSubview:self.titleScrollView];
    }
    return _titleScrollView;
}

- (UIView *)underline {
    if (!_underline) {
        _underline = [[UIView alloc] init];
        _underline.backgroundColor = self.selectlineColeor;
    }
    return _underline;
}


-(NSMutableArray *)imageArr
{
    if (!_imageArr) {
        _imageArr =[[NSMutableArray alloc] init];
        
    }
    return _imageArr;
}
-(UIFont *)font
{
    if (!_font) {
        _font =[UIFont systemFontOfSize:13];
        
    }
    return _font;
}
-(UIColor *)selectfontColor
{
    if (!_selectfontColor) {
        _selectfontColor =[UIColor colorFromHexRGB:@"c32e00"];
    }
    return _selectfontColor;
}
-(UIColor *)fontColor
{
    if (!_fontColor) {
        _fontColor =[UIColor blackColor];
    }
    return _fontColor;
}
-(UIColor*)selectlineColeor
{
    if (!_selectlineColeor) {
        
        _selectlineColeor =[UIColor colorFromHexRGB:@"c32e00"];
    }
    return _selectlineColeor;
}
-(NSMutableArray *)titleWidthArray
{
    if (!_titleWidthArray) {
        _titleWidthArray = [[NSMutableArray alloc] init];
    }
    return _titleWidthArray;
}
@end
