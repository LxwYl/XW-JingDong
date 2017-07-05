//
//  HPCommentsCell.m
//  HPShop
//
//  Created by 李学文 on 2017/2/27.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import "HPCommentsCell.h"

@implementation HPCommentsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

   // [self cutCircleImg:self.headerimageView andSize:self.headerimageView.size];
    [self.goodStarVContent mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.name_bl.mas_right).offset(5);
        
        make.centerY.mas_equalTo(self.name_bl.mas_centerY).offset(0);
        
        make.width.mas_equalTo(80);
        
        make.height.mas_equalTo(15);
        
    }];

}

-(void)ceshi
{
    if (!_XWPhotoView) {
        
        _XWPhotoView = [[XWNineImageVIew alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
    }
    _XWPhotoView.Middle = 3;
    _XWPhotoView.leftspace=9;
    //    _XWPhotoView.rightspace = 9;
    _XWPhotoView.bottomsapce = 10;
    [self.contentView addSubview:_XWPhotoView];
    
    [self.XWPhotoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerView.mas_bottom).offset(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(1, 1));
    }];
    
    if (!_goodsView) {
        _goodsView = [HPCommentGoodsView viewFromXib];
        
    }
    _goodsView.hidden = YES;
    [self.contentView addSubview:_goodsView];
    

    [self.goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.XWPhotoView.mas_bottom).offset(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.01));
    }];
}

-(void)SetCommentMode:(HPCommentMode*)model andType:(HPCommentsCellType)type
{
    _Type = type;
    _model = model;
    self.goodStarVContent.scorePercent = [self.model.evaluate_buyer_val floatValue]/5;
    //NSLog(@"----%d",self.goodStarVContent.scorePercent);
     _name_bl.text = [DJTUtility YRIsEmptString:model.personName];
   // NSArray * arr = @[@"1",@"2",@"3"];
    
//    @property (weak, nonatomic) IBOutlet UIView *headerView;
//    @property (weak, nonatomic) IBOutlet UIImageView *headerimageView;
//    @property (weak, nonatomic) IBOutlet UILabel *content_bl;
//    @property (weak, nonatomic) IBOutlet UILabel *name_bl;
//    
//    @property (weak, nonatomic) IBOutlet UILabel *time_bl;
//    
//    
//    @property(strong, nonatomic) HPCommentMode * model;
    
    [_headerimageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",BASEURL,model.personPhoto]] placeholderImage:[UIImage imageNamed:@""] ];
  
    _content_bl.text = [DJTUtility YRIsEmptString:model.evaluate_info];
    _time_bl.text =[DJTUtility YRIsEmptString:model.addTime];
    NSMutableArray * imagearr =[[NSMutableArray alloc] init];
   

    if (model.photo.count>0) {
        
        for (int i=0; i<model.photo.count; i++) {
            NSString * path =[[model.photo objectAtIndex:i] objectForKey:@"pathName"];
            
           
            [imagearr addObject:[DJTUtility YRIsEmptString:path]];
            
        }
        NSLog(@"----_XWPhotoView----%lf",_XWPhotoView.width);
        NSLog(@"----%@",imagearr);
        _XWPhotoView.imageArry = imagearr;
        NSLog(@"--%lf",_XWPhotoView.toalHigh);
        [self.XWPhotoView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headerView.mas_bottom).offset(0);
            make.left.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH,_XWPhotoView.toalHigh));
        }];


        NSLog(@"-_XWPhotoView.toalHigh:----%lf",_XWPhotoView.toalHigh);
        
    }else
    {
        _XWPhotoView.imageArry = imagearr;
        [self.XWPhotoView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headerView.mas_bottom).offset(0);
            make.left.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(0.01, 0.01));
        }];
    }
    
    if (_Type==HPCommentsCellTypeHaveGoods) {
        
        _goodsView.hidden = NO;
        
        [_goodsView.goodsphoto sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",BASEURL,model.pathName]] placeholderImage:[UIImage imageNamed:@""] ];
        _goodsView.goodsname_bl.text = [DJTUtility YRIsEmptString:model.goods_name];
        
        
       
        [self.goodsView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.XWPhotoView.mas_bottom).offset(0);
            make.left.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 130));
        }];
    }else
    {
       
       
         _goodsView.hidden = YES;
        [self.goodsView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.XWPhotoView.mas_bottom).offset(0);
            make.left.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.01));
        }];

    }
    
    
}

-(CWStarRateView *)goodStarVContent
{
    if (!_goodStarVContent) {
        
        _goodStarVContent = [[CWStarRateView alloc] initWithFrame:CGRectMake(0, 0, 80, 15) numberOfStars:5];
        
        _goodStarVContent.scorePercent =1; //[self.model.EvaluateList.description_evaluate floatValue];
        _goodStarVContent.allowIncompleteStar = NO;
        _goodStarVContent.hasAnimation = YES;
        
        _goodStarVContent.userInteractionEnabled = NO;
        [self.headerView addSubview:_goodStarVContent];
        
        
    }
    return _goodStarVContent;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
