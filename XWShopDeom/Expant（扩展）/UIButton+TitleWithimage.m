//
//  UIButton+TitleWithimage.m
//  HPShop
//
//  Created by 李学文 on 2017/3/7.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import "UIButton+TitleWithimage.h"

@implementation UIButton (TitleWithimage)
- (void)verticalImageAndTitle:(CGFloat)spacing buttonW:(CGFloat)buttonW
{
    self.titleLabel.backgroundColor = [UIColor greenColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;//设置title的字体居中
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize textSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    [self sizeToFit];
  
    NSLog(@"-------%lf---%lf---%lf",self.width,imageSize.width,titleSize.width);
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
//    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, - titleSize.width, 0.0);
//    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
    
//       self.imageEdgeInsets = UIEdgeInsetsMake( - (totalHeight - imageSize.height),  (buttonW-imageSize.width)/2, - titleSize.width, 0.0);
      self.imageEdgeInsets = UIEdgeInsetsMake( - (totalHeight - imageSize.height),  -( imageSize.width+(titleSize.width-imageSize.width)/2), - titleSize.width, 0.0);
    self.titleEdgeInsets = UIEdgeInsetsMake(0,  - imageSize.width, - (totalHeight - titleSize.height), 0.0);
   
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
//    [self setTitleEdgeInsets:UIEdgeInsetsMake(self.imageView.frame.size.height ,-self.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
//    [self setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0,0.0, -self.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
    
}
@end
