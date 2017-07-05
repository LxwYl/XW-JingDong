//
//  HPPublishCommentModel.m
//  HPShop
//
//  Created by 李学文 on 2017/4/10.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import "HPPublishCommentModel.h"

@implementation HPPublishCommentModel
-(NSMutableArray *)photoArry
{
    if (!_photoArry) {
        
        _photoArry = [[NSMutableArray alloc] init];
    }
    return _photoArry;
}
@end
