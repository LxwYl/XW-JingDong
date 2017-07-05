//
//  XWNineImageVIew.m
//  HPShop
//
//  Created by 李学文 on 2017/2/27.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import "XWNineImageVIew.h"
#define COL 3
#define SelfWIDTH self.frame.size.width
#define SelfHEIGHT self.frame.size.height
@implementation XWNineImageVIew

-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame ];
    if (self) {
        
        
        
        
    }
    return self;
}
-(instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self ;
}

-(void)setImageArry:(NSArray*)imageArry
{
    _imageArry = imageArry;
    
    NSInteger yu = imageArry.count%COL;
    NSInteger row = imageArry.count/COL;
    if (yu>0) {
        row = row+1;
    }
    
    NSInteger index=0;
    
    
    CGFloat imageWidh = (SCREEN_WIDTH - (COL-1)*self.Middle-self.leftspace-self.rightspace)/COL;
    
    
    self.toalHigh = imageWidh*row+self.Middle*(row-1)+self.topsapce+self.bottomsapce;
    for (int i=0; i<row; i++) {
        
        for (int j=0; j<COL; j++) {
            
            index++;
            if (index>imageArry.count) {
                return;
            }
            UIImageView * imageview =[[UIImageView alloc] initWithFrame:CGRectMake(self.leftspace+j*imageWidh+(j-1)*self.Middle, self.topsapce+i*imageWidh*(i-1)*self.Middle, imageWidh, imageWidh)];
            imageview.contentMode  = UIViewContentModeScaleAspectFill;
            imageview.clipsToBounds = YES;
            UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapImageVIew:)];
            imageview.tag = 900+index-1;
            [imageview addGestureRecognizer:tap];
            [self addSubview:imageview];
            
            
            
            NSString * imgUrl;
            NSString * sss = [imageArry objectAtIndex:0];
            if([sss hasPrefix:@"http"]){
                imgUrl = sss;
            }else{
                imgUrl = [NSString stringWithFormat:@"%@/%@",BASEURL,[imageArry objectAtIndex:0]];
            }
            [imageview sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"商城九宫格的图片显示不出来时"]];

            
        }
    }

   
}

-(CGFloat)returnXWNineImageVIewHighWithCount:(NSInteger)count
{

    
    NSInteger yu = count%COL;
    NSInteger row = count/COL;
    if (yu>0) {
        row = row;
    }
    
    
    
    
    CGFloat imageWidh = (SelfWIDTH - (COL-1)*self.Middle-self.leftspace-self.rightspace)/3;
    
    
    self.toalHigh = imageWidh*row+self.Middle*(row-1)+self.topsapce+self.bottomsapce;

    return self.toalHigh;
}
-(void)CreatnineImageViewWithArry:(NSArray*)arry
{
   }
-(void)TapImageVIew:(UITapGestureRecognizer*)GestureRecognizer
{
    NSInteger tag = GestureRecognizer.view.tag-900;
    
}
@end
