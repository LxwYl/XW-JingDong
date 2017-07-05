//
//  HPCommentReplyMode.h
//  HPShop
//
//  Created by 李学文 on 2017/4/1.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPCommentReplyMode : NSObject
//addTime = "2017-03-31 15:01:15";
//authorId = 1;
//authorName = admin;
//deleteStatus = 0;
//evaluateId = 2;
//id = 24;
//replyContent = "\U8bc4\U8bba\U5185\U5bb9";
//replyMark = 1;
@property(strong,nonatomic) NSString *addTime;

@property(strong,nonatomic) NSString *authorId;
@property(strong,nonatomic) NSString *authorName;

@property(strong,nonatomic) NSString *deleteStatus;
@property(strong,nonatomic) NSString *evaluateId;
@property(strong,nonatomic) NSString *id;
@property(strong,nonatomic) NSString *replyContent;
@property(strong,nonatomic) NSString *replyMark;


@property(strong, nonatomic) NSString * inputComment;//输入评论缓存
@end
