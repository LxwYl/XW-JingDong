//
//  XWShopSelectContentView.h
//  HPShop
//
//  Created by 李学文 on 2017/3/29.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWShopSelectContentView : UIView
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *pricebl;
@property (weak, nonatomic) IBOutlet UILabel *shopNumber;
@property (weak, nonatomic) IBOutlet UIImageView *line;
@property (weak, nonatomic) IBOutlet UIButton *addShopCar;
@property (weak, nonatomic) IBOutlet UIButton *gobuy;
- (IBAction)ClickAddShopCar:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *headerimageView;

@end
