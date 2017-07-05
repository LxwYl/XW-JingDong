//
//  XWbannderItem.m
//  HPShop
//
//  Created by 李学文 on 2017/4/13.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import "XWbannderItem.h"

@implementation XWbannderItem

- (void)awakeFromNib {
    [super awakeFromNib];

    self.photoView.contentMode = UIViewContentModeScaleAspectFill;
    self.photoView.clipsToBounds = YES;
}

@end
