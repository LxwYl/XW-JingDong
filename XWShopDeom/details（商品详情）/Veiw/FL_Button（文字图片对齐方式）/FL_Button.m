//
//  FL_Button.m
//
//  Created by 孔凡列 on 15/12/10.
//  Copyright © 2015年 czebd. All rights reserved.
//

#import "FL_Button.h"
/**
 *  定义宏：按钮中文本和图片的间隔
 */
#define fl_padding 7
#define fl_btnRadio 0.6
//    获得按钮的大小
#define fl_btnWidth self.bounds.size.width
#define fl_btnHeight self.bounds.size.height
//    获得按钮中UILabel文本的大小
#define fl_labelWidth self.titleLabel.bounds.size.width
#define fl_labelHeight self.titleLabel.bounds.size.height
//    获得按钮中image图标的大小
#define fl_imageWidth self.imageView.bounds.size.width
#define fl_imageHeight self.imageView.bounds.size.height

@implementation FL_Button

+ (instancetype)fl_shareButton{
    return [[self alloc] init];
}

- (instancetype)initWithAlignmentStatus:(FLAlignmentStatus)status{
    FL_Button *fl_button = [[FL_Button alloc] init];
    fl_button.status = status;
    return fl_button;
}

- (void)setStatus:(FLAlignmentStatus)status{
    _status = status;
//    [self layoutIfNeeded];
}
#pragma mark - 左对齐
- (void)alignmentLeft{
    //    获得按钮的文本的frame
    CGRect titleFrame = self.titleLabel.frame;
    //    设置按钮的文本的x坐标为0-－－左对齐
    titleFrame.origin.x = 0;
    //    获得按钮的图片的frame
    CGRect imageFrame = self.imageView.frame;
    //    设置按钮的图片的x坐标紧跟文本的后面
    imageFrame.origin.x = CGRectGetWidth(titleFrame);
    //    重写赋值frame
    self.titleLabel.frame = titleFrame;
    self.imageView.frame = imageFrame;
}
#pragma mark - 右对齐
- (void)alignmentRight{
    // 计算文本的的宽度
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = self.titleLabel.font;
    CGRect frame = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictM context:nil];
    
    CGRect imageFrame = self.imageView.frame;
    imageFrame.origin.x = self.bounds.size.width - fl_imageWidth;
    CGRect titleFrame = self.titleLabel.frame;
    titleFrame.origin.x = imageFrame.origin.x - frame.size.width ;
    //    重写赋值frame
    self.titleLabel.frame = titleFrame;
    self.imageView.frame = imageFrame;
}

#pragma mark - 居中对齐
- (void)alignmentCenter{
    //    设置文本的坐标
    CGFloat labelX = (fl_btnWidth - fl_labelWidth -fl_imageWidth - fl_padding) * 0.5;
    CGFloat labelY = (fl_btnHeight - fl_labelHeight) * 0.5;
    
    //    设置label的frame
    self.titleLabel.frame = CGRectMake(labelX, labelY, fl_labelWidth, fl_labelHeight);
    
    //    设置图片的坐标
    CGFloat imageX = CGRectGetMaxX(self.titleLabel.frame) + fl_padding;
    CGFloat imageY = (fl_btnHeight - fl_imageHeight) * 0.5;
    //    设置图片的frame
    self.imageView.frame = CGRectMake(imageX, imageY, fl_imageWidth, fl_imageHeight);
}

#pragma mark - 图标在上，文本在下(居中)
- (void)alignmentTop{
    // 计算文本的的宽度
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = self.titleLabel.font;
    CGRect frame = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictM context:nil];
    
    CGFloat imageX = (fl_btnWidth - fl_imageWidth) * 0.5;
    self.imageView.frame = CGRectMake(imageX, fl_btnHeight * 0.5 - fl_imageHeight * fl_buttonTopRadio, fl_imageWidth, fl_imageHeight);
    self.titleLabel.frame = CGRectMake((self.center.x - frame.size.width) * 0.5, fl_btnHeight * 0.5 + fl_labelHeight * fl_buttonTopRadio, fl_labelWidth, fl_labelHeight);
    CGPoint labelCenter = self.titleLabel.center;
    labelCenter.x = self.imageView.center.x;
    self.titleLabel.center = labelCenter;
}

#pragma mark - 图标在下，文本在上(居中)
- (void)alignmentBottom{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    // 计算文本的的宽度
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = self.titleLabel.font;
    CGRect frame = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictM context:nil];
    
    CGFloat imageX = (fl_btnWidth - fl_imageWidth) * 0.5;
    self.titleLabel.frame = CGRectMake((self.center.x - frame.size.width) * 0.5, fl_btnHeight * 0.5 - fl_labelHeight * (1 + fl_buttonBottomRadio), fl_labelWidth, fl_labelHeight);
    self.imageView.frame = CGRectMake(imageX, fl_btnHeight * 0.5 , fl_imageWidth, fl_imageHeight);
    CGPoint labelCenter = self.titleLabel.center;
    labelCenter.x = self.imageView.center.x;
    self.titleLabel.center = labelCenter;
}

/**
 *  布局子控件
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    // 判断
    if (_status == FLAlignmentStatusNormal) {
        
    }
    else if (_status == FLAlignmentStatusLeft){
        [self alignmentLeft];
    }
    else if (_status == FLAlignmentStatusCenter){
        [self alignmentCenter];
    }
    else if (_status == FLAlignmentStatusRight){
        [self alignmentRight];
    }
    else if (_status == FLAlignmentStatusTop){
        [self alignmentTop];
    }
    else if (_status == FLAlignmentStatusBottom){
        [self alignmentBottom];
    }
}



@end
