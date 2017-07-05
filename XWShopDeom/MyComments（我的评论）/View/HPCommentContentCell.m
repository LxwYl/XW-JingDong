//
//  HPCommentContentCell.m
//  HPShop
//
//  Created by 李学文 on 2017/2/27.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import "HPCommentContentCell.h"

@implementation HPCommentContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(HPCommentReplyMode *)model
{
    _model = model;
    
    if ([[DJTUtility YRIsEmptString:model.replyMark] isEqualToString:@"0"]) {
       
         [_namebtn setTitle:@"回复：" forState:UIControlStateNormal];
        [_namebtn setTitleColor:[UIColor colorFromHexRGB:@"c32e00"] forState:UIControlStateNormal];
        _content_bl.textColor = [UIColor blackColor];
    }else
    {
         [_namebtn setTitle:[DJTUtility YRIsEmptString:model.authorName] forState:UIControlStateNormal];
          [_namebtn setTitleColor:[UIColor colorFromHexRGB:@"808080"] forState:UIControlStateNormal];
         _content_bl.textColor = [UIColor colorFromHexRGB:@"808080"];
    }
   
    _content_bl.text = [DJTUtility YRIsEmptString:model.replyContent];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
