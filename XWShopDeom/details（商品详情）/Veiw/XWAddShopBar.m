//
//  XWAddShopBar.m
//  HPShop
//
//  Created by 李学文 on 2017/3/28.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import "XWAddShopBar.h"


#define BUYBTNW 100/375.0*SCREEN_WIDTH
#define OTHERBTNW (SCREEN_WIDTH-200/375.0*SCREEN_WIDTH)/3
@implementation XWAddShopBar
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor =[UIColor whiteColor];
        [self CreatSubView];
    }
    return self;
}
-(void)CreatSubView
{
    NSArray * titleArr =@[@"",@"",@"",@"加入购物车",@"立即购买"];
    NSArray *imageArr = @[@"kefu",@"dianp",@"yigzh",@"",@""];
    
    for (int i= 0; i<titleArr.count; i++) {
        
        FL_Button *button =[[FL_Button alloc]initWithAlignmentStatus:FLAlignmentStatusNormal];
        [button setImage:[UIImage imageNamed:[imageArr objectAtIndex:i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(ClickbootomBarWithBtn:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:[titleArr objectAtIndex:i] forState:UIControlStateNormal ];
//        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:11];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self addSubview:button];
        button.tag = 90 + i;
        if (i==2) {
            _follwBtn = button;
        }
        button.frame = CGRectMake(i*OTHERBTNW, 2, OTHERBTNW, self.height-2);
        
        if (i==3) {
            
            button.frame = CGRectMake(3*OTHERBTNW, 2, BUYBTNW, self.height-2);
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            button.backgroundColor =[UIColor colorFromHexRGB:@"ffa44c"];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            
            
        }
        if (i==4) {
            
              button.frame = CGRectMake(3*OTHERBTNW+BUYBTNW, 2, BUYBTNW, self.height-2);
             button.titleLabel.font = [UIFont systemFontOfSize:13];
             button.backgroundColor =[UIColor colorFromHexRGB:@"ff7e00"];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    
    }
}

-(void)ClickbootomBarWithBtn:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(XWAddShopBar:ClickbootomBarWithBtn:withIndex:)]) {
        [self.delegate XWAddShopBar:self ClickbootomBarWithBtn:sender withIndex:sender.tag-90];
    }

}
-(void)XWAddShopBarfollwBtnWithState:(NSInteger)state
{
    
    if (state==0) {
        
        [_follwBtn  setImage:[UIImage imageNamed:@"gzh"] forState:UIControlStateNormal];
    }else
    {
         [_follwBtn  setImage:[UIImage imageNamed:@"yigzh"] forState:UIControlStateNormal];
    }
    
}
@end
