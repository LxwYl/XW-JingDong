//
//  XWShopDetetailsCell.m
//  HPShop
//
//  Created by 李学文 on 2017/3/28.
//  Copyright © 2017年 李学文. All rights reserved.
//
#import "HPSearGoodsItem.h"
#import "XWShopDetetailsCell.h"

static NSString * HPSearGoodsItemID = @"HPSearGoodsItemAddCarID";
@interface XWShopDetetailsCell()<UICollectionViewDelegate,UICollectionViewDataSource>


@end
@implementation XWShopDetetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    

    
}



+ (instancetype)XWShopDetetailsCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"";//对应xib中设置的identifier
    NSInteger index = 0; //xib中第几个Cell
    switch (indexPath.section) {
        case 0:
            identifier = @"ShopDetetailsGoodDataCell";
            index = 0;
            break;
        case 1:
            identifier = @"ShopDetetailsSelectSizeCell";
            index = 1;
            break;
        case 2:
            
            identifier = @"ShopDetetailsCommentCell";
            index = 2;
            break;
        case 3:
            
            identifier = @"ShopDetetailsdstoredataCell";
            index = 3;
            break;
        case 4:
            
            identifier = @"ShopDetetailsMoreGoodsCell";
            index = 4;
            break;
            
        default:
            break;
    }
    XWShopDetetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XWShopDetetailsCell" owner:self options:nil] objectAtIndex:index];
    }
  
    return cell;
    
}
- (void)configTempCellWith:(NSIndexPath *)indexPath
{
    switch (indexPath.section ) {
        case 0:
        {
            self.goodsName.text = [DJTUtility YRIsEmptString:self.model.commodityMessageList.goods_name];
            
            self.price.text=[NSString stringWithFormat:@"¥%.2lf",[[DJTUtility YRIsEmptString:self.model.commodityMessageList.store_price] floatValue]];
            
            if ([DJTUtility YRIsEmptString:self.model.commodityMessageList.price].length>0) {
                
                // 打折之后的价钱展示
                self.pricegray.hidden =NO;
                self.pricegray.text =[NSString stringWithFormat:@"¥%.2lf",[[DJTUtility YRIsEmptString:self.model.commodityMessageList.price] floatValue]];
                self.pricegraline.hidden = NO;
            }else
            {
                // 没打折
                self.pricegray.hidden =YES;
                 self.pricegraline.hidden = YES;
            }
            
            
            //一开始假设优惠那一栏没有高度
            self.jq_DisCountHeigh.constant = 0.0001;

            NSString *mjStr;
            XWStoreMessageModel *storeModel = _model.StoreMessage;
            
            if ([storeModel.cut_price integerValue]) {
                mjStr = [NSString stringWithFormat:@"满¥%@减%@",storeModel.full_price,storeModel.cut_price];
                self.jq_DisCountHeigh.constant = 36;

            }else
            {
                mjStr = @"";
            }
            
            
            NSString *yhjStr;
            
            //有优惠信息和无优惠消息调整高度
            XWcommodityMessageModel *commodModel = _model.commodityMessageList;

            if ([commodModel.coupon_amount integerValue]) {
                
                self.jq_DisCountHeigh.constant = 36;
                yhjStr = [NSString stringWithFormat:@"可用%@元优惠券",commodModel.coupon_amount];
            }else
            {
                
                yhjStr = @"";
            }
            
            if (yhjStr.length>1) {
                mjStr = [mjStr stringByAppendingString:@"、"];
                mjStr = [mjStr stringByAppendingString:yhjStr];
            }
            
            if (mjStr.length>1) {
                
                self.jq_couponImgView.image = [UIImage imageNamed:@"dpyh"];
                [self.jq_DiscountBtn setTitle:mjStr forState:UIControlStateNormal];
            }else
            {
                self.jq_couponImgView.image = nil;
                [self.jq_DiscountBtn setTitle:@"" forState:UIControlStateNormal];
            }

         
        }
            break;
        case 1:
        {
//            if (self.model.commodityPropertyList.count>0) {
//                
//                self.cateroySize.text = @"数量";
//            }
        }
            break;

        case 2:
        {
            self.goodStarVContent = [[CWStarRateView alloc] initWithFrame:CGRectMake(0, 0, 80, 15) numberOfStars:5];
           
            self.goodStarVContent.scorePercent = [self.model.EvaluateList.description_evaluate floatValue];
            self.goodStarVContent.allowIncompleteStar = NO;
            self.goodStarVContent.hasAnimation = YES;
            
            self.goodStarVContent.userInteractionEnabled = NO;
            [self.commentView addSubview:self.goodStarVContent];
            
            [self.goodStarVContent mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo(self.commentName.mas_right).offset(5);
                
                make.centerY.mas_equalTo(self.commentName.mas_centerY).offset(0);
                
                make.width.mas_equalTo(80);
                
                make.height.mas_equalTo(15);
                
            }];
            
            self.commentTime.text = [DJTUtility YRIsEmptString:self.model.EvaluateList.goods_name];
            
            self.commentName.text = [DJTUtility YRIsEmptString:self.model.EvaluateList.userName];
           
            self.commentContent.text = [DJTUtility YRIsEmptString:self.model.EvaluateList.evaluate_info];
            
            self.commentNumber.text =[NSString stringWithFormat:@"评论/(%@)",[DJTUtility YRIsEmptString:self.model.EvaluateList.evaluateSize]];
            [self.commentHeader sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",BASEURL,[DJTUtility YRIsEmptString:self.model.EvaluateList.markStatus]]] placeholderImage: [UIImage imageNamed:@"guide_1"]];
            self.Percentage.text = [NSString stringWithFormat:@"好评度：%@",[DJTUtility YRIsEmptString:self.model.EvaluateList.evaluateGoodRate]];  ;

            if (_model.EvaluateList.id.length==0) {
//                self.goodStarVContent.hidden = YES;
//                self.commentContent.hidden =YES;
//                self.commentName.hidden =YES;
                self.commentView.hidden =YES;
                 self.commentNumber.text =@"评论/(0)";
                self.Percentage.text =@"";
            }else
            {
                self.commentView.hidden =NO;
            }
        }
            break;

        case 3:
        {
            self.allGoodcount.text = [DJTUtility YRIsEmptString:self.model.goodsSizeList];
            self.corncount.text = [DJTUtility YRIsEmptString:self.model.storeSizeList];
            self.storeActioncount.text = [DJTUtility YRIsEmptString:self.model.dynamicSizeList];
            [ self.storeheader sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",BASEURL,[DJTUtility YRIsEmptString:self.model.StoreMessage.store_logo_id]]] placeholderImage: [UIImage imageNamed:@"guide_1"]];
            self.storenamebl.text = [DJTUtility YRIsEmptString:self.model.StoreMessage.store_name];
        }
            break;

        case 4:
        {
            [self SetupMainCollection];
        }
            break;


            
        default:
            break;
    }
    
    
    if (indexPath.section == 2) {
        
          }
    

}


#pragma mark-
#pragma mark- 创建CollectionView
-(void)SetupMainCollection
{
    if (!_mainCollection) {
        UICollectionViewFlowLayout * layout =[[UICollectionViewFlowLayout alloc] init];
        
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
        layout.minimumInteritemSpacing = 10;
        
        layout.minimumLineSpacing = 0 ;
        
        
        _mainCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, SCREEN_HEIGHT) collectionViewLayout:layout];
        
        _mainCollection.backgroundColor = [UIColor whiteColor];
        _mainCollection.delegate = self;
        
        _mainCollection.dataSource = self;
        _mainCollection.showsVerticalScrollIndicator = NO;
        [_mainCollection registerNib:[UINib  nibWithNibName:NSStringFromClass([HPSearGoodsItem class]) bundle: nil]  forCellWithReuseIdentifier:HPSearGoodsItemID];
        //    [_mainCollection registerNib:[UINib  nibWithNibName:NSStringFromClass([HPSearGoodsCell class]) bundle: nil]  forCellWithReuseIdentifier:HPSearGoodsCellID];
        
        
        [self.contentView  addSubview:_mainCollection];
        
    }

    
    [self.mainCollection mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        
        make.top.mas_equalTo(self.title.mas_bottom).offset(0);
        make.bottom.mas_equalTo(self.moreBtn.mas_top).offset(0);
        
    }];
    _mainCollection.scrollEnabled = NO;
    
    
}
#pragma mark-
#pragma mark-  collectionView 代理方法实现
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.model.salesVolume.count;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
            //双排
        HPSearGoodsItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HPSearGoodsItemID forIndexPath:indexPath];
    XWShopsalesVolumeModel *mode =[self.model.salesVolume objectAtIndex:indexPath.row];
     [ cell.headerimageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[DJTUtility YRIsEmptString:mode.pathName]]] placeholderImage: [UIImage imageNamed:@"guide_1"]];
    cell.contentbl.text = [DJTUtility YRIsEmptString:mode.goods_name];
    cell.pricebl.text = [NSString stringWithFormat:@"¥%.2lf",[[DJTUtility YRIsEmptString:mode.store_price] floatValue]];
    cell.peoplesbl.text = [NSString stringWithFormat:@"%@人付款",[DJTUtility YRIsEmptString:mode.sales_volume]];
           return cell;
        
        

    
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击Item");
     XWShopsalesVolumeModel *mode =[self.model.salesVolume objectAtIndex:indexPath.row];
    if ([self.delegate respondsToSelector:@selector(XWShopDetetailsCell:didSelectItemAtIndexPath:withStoreId:)]) {
        [self.delegate XWShopDetetailsCell:self didSelectItemAtIndexPath:indexPath withStoreId:mode.id];
    }

}
// 每个item 上下间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
   
        return 3;
    
    
}
// 每个item中间的间隔
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
           return 3;
    
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, 0.1);
    
    return size;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size;
           size = CGSizeMake((SCREEN_WIDTH-3)/2, (SCREEN_WIDTH-3)/2+80);

    
    return size;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)ClickGotoStaoreButton:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(XWShopDetetailsCell:ClickGotoStaoreButton:)]) {
        [self.delegate XWShopDetetailsCell:self ClickGotoStaoreButton:sender];
    }
}

- (IBAction)ClickallGoodButton:(UIButton *)sender
{}
- (IBAction)ClickcornButton:(UIButton *)sender
{}
- (IBAction)ClickstoreActionButton:(UIButton *)sender
{
}

- (IBAction)ClickMoreGoods:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(XWShopDetetailsCell:ClickMoreGoods:)]) {
        [self.delegate XWShopDetetailsCell:self ClickMoreGoods:sender];
    }
}
@end
