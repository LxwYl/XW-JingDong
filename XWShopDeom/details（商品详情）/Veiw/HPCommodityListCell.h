//
//  HPCommodityListCell.h
//  HPShop
//
//  Created by 李学文 on 2017/2/8.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HPCommodityListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title_bl;
@property (weak, nonatomic) IBOutlet UILabel *detail_bl;
@property (weak, nonatomic) IBOutlet UILabel *count_bl;
@property (weak, nonatomic) IBOutlet UIImageView *icon_bl;
@property (weak, nonatomic) IBOutlet UILabel *price_bl;

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@end
