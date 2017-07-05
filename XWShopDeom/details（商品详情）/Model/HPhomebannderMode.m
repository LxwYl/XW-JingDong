//
//  HPhomebannderMode.m
//  HPShop
//
//  Created by 李学文 on 2017/3/24.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import "HPhomebannderMode.h"

@implementation HPhomebannderMode
// 获取图片路径
- (NSString *)GetPhotoPath
{
    NSString * Allpath;
    
    Allpath = [NSString stringWithFormat:@"%@/%@/%@",BASEURL,_path,_name];
    
    return Allpath;
}
@end
