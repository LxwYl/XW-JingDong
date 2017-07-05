//
//  HPCommentMode.m
//  HPShop
//
//  Created by 李学文 on 2017/2/27.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import "HPCommentMode.h"

@implementation HPCommentMode

-(void)setEvaluateReplyList:(NSArray *)EvaluateReplyList
{
     NSMutableArray *ReplyList = [HPCommentReplyMode mj_objectArrayWithKeyValuesArray:EvaluateReplyList];
    _EvaluateReplyList= ReplyList;
}

@end
