//
//  HPCommentContentCell.h
//  HPShop
//
//  Created by 李学文 on 2017/2/27.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPCommentReplyMode.h"
@interface HPCommentContentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *namebtn;
@property (weak, nonatomic) IBOutlet UILabel *content_bl;
@property(strong, nonatomic) HPCommentReplyMode * model;
@end
