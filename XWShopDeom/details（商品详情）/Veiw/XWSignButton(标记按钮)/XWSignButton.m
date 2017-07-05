//
//  XWSignButton.m
//  XWSignButton
//
//  Created by 李学文 on 2017/2/26.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import "XWSignButton.h"

#define SIGNVIEW_W 10
#define SIGNVIEW_H 10



@implementation XWSignButton

//初始化button
-(void)XWSignButtoninit:(XWSignButtonType)type
{
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    
    if (self) {
        
        [self CreatNumberView];
        self.Type = XWSignButtonTypeWithNumber;
        self.MaxNumber=99;
        
        self.Type = UIButtonTypeCustom;
    }
    return self;
}
-(instancetype)init
{
    self =[super init];
    if (self) {
        
        self.Type = XWSignButtonTypeWithNumber;
         self.MaxNumber=99;
        self.frame = CGRectMake(0, 0, 30, 30);
        self.Type = UIButtonTypeCustom;
        
        [self CreatNumberView];
        NSLog(@"------%f",self.frame.size.width);
        
    }
    return self;
}
-(void)CreatNumberView
{
    _NumberLable = [[UILabel alloc] init];
    
    _NumberLable.frame = CGRectMake(0, 0, SIGNVIEW_W, SIGNVIEW_H);
    
   // _NumberLable.height = SIGNVIEW_W;
    _NumberLable.center = CGPointMake(self.frame.size.width, 0);
    
    _NumberLable.layer.masksToBounds = YES;
    
    _NumberLable.layer.cornerRadius =SIGNVIEW_W/2;
    
    _NumberLable.backgroundColor =[UIColor redColor];
    
    _NumberLable.textColor =[UIColor whiteColor];
    
    _NumberLable.font = [UIFont systemFontOfSize:9];
    
    _NumberLable.textAlignment = NSTextAlignmentCenter;
    _NumberLable.text = @"";
    
    
    [self addSubview:_NumberLable];
}

-(void)setNumberStr:(NSString *)NumberStr
{
    _NumberStr = NumberStr;
    
    self.NumberLable.text = NumberStr;
    
    if ([NumberStr integerValue]>self.MaxNumber) {
        self.NumberLable.text = [NSString stringWithFormat:@"%ld+",self.MaxNumber];
    }
    if ([NumberStr integerValue]==0||[NumberStr isEqualToString:@""]) {
        self.NumberLable.hidden =YES;
    }else
    {
        self.NumberLable.hidden =NO;
    }
    self.NumberLable.width = SIGNVIEW_W + (NumberStr.length-1)*5;
}
-(void)setRedSignWide:(CGFloat)redSignWide
{
    _redSignWide = redSignWide;
    
    _NumberLable.frame = CGRectMake(0, 0, redSignWide, redSignWide);

    _NumberLable.center = CGPointMake(self.frame.size.width, 0); 
    
    _NumberLable.layer.cornerRadius =redSignWide/2;

}
-(void)setType:(XWSignButtonType)Type
{
    if (_Type == XWSignButtonTypeWithNumber) {
        
        self.NumberLable.text = _NumberStr;
        
        if ([_NumberStr integerValue]>self.MaxNumber) {
            self.NumberLable.text = [NSString stringWithFormat:@"%ld+",self.MaxNumber];
        }

    }else
    {
         self.NumberLable.text =@"";
    }
}
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
}
-(void)setNumberFont:(UIFont *)numberFont
{
    _numberFont = numberFont;
    _NumberLable.font =numberFont;
}
// 隐藏和展示
-(void)HideXWSignButtonSign
{
    _NumberLable.hidden =YES;
}
-(void)ShowXWSignButtonSign
{
    _NumberLable.hidden =NO;
}

//更新数量
-(void)UpdataCreatXWSignButtonNumber:(NSInteger)number
{
     _NumberLable.hidden =NO;
    self.NumberLable.text = _NumberStr;
    
    if ([_NumberStr integerValue]>self.MaxNumber) {
        self.NumberLable.text = [NSString stringWithFormat:@"%ld+",self.MaxNumber];
    }
}

@end
