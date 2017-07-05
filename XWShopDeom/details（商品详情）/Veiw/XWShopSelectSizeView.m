//
//  XWShopSelectSizeView.m
//  HPShop
//
//  Created by 李学文 on 2017/3/28.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import "XWShopSelectSizeView.h"
#import "XWShopSelectContentView.h"
#import "XWShopSelectSizeItem.h"
#import "XWShopSelectSizeItem.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "XWShopSelectSizeReusableView.h"
#import "PPNumberButton.h"
#import "UIView+views.h"
#import "UIView+CurrentVc.h"
#import "UIImageView+XXBezierTransform.h"
#import "UIViewController+XX3DFallAndRise.h"
static NSString * XWShopSelectSizeItemID  = @"XWShopSelectSizeItem";
static NSString * XWShopSelectSizeReusableHeaderViewID = @"XWShopSelectSizeReusableHeaderView";

static NSString * XWShopSelectSizeReusableFooterViewID = @"XWShopSelectSizeReusableFooterView";
#define ProgressTime  0.5
#define MainViewH 500
#define GGColors(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
@interface XWShopSelectSizeView ()<UIGestureRecognizerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/*
 *  背景蒙版
 */
@property(strong, nonatomic) UIView * backView;
/*
 *  显示类容
 */
@property(strong, nonatomic) XWShopSelectContentView * contentView;
/*
 * sizeConllection
 */
@property(strong, nonatomic) UICollectionView * mainCollection;
@property (nonatomic, assign) BOOL show3D;

/*
 * 数量
 */
@property (nonatomic, assign) NSInteger goodsCount;
@end
@implementation XWShopSelectSizeView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        [keyWindow addSubview:self];

        NSArray  *arr =@[@"哈比",@"额为规范 我扶额我",@"让法规和规划",@"gassy",@"发出去我刚读完以前的语气我哈傻傻的"]    ;
        
        [self.dataArr addObjectsFromArray:arr];
        _goodsCount=1;
        //[self.dataArr arrayByAddingObjectsFromArray:arr];
        self.backgroundColor = [UIColor clearColor];
        
        [self CreatUI];
         [self.mainCollection reloadData];
    }
    return self;
}
-(void)setGoodsmodel:(XWcommodityMessageModel *)Goodsmodel
{
    _Goodsmodel = Goodsmodel;
    [self.contentView.headerimageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",BASEURL,self.Goodsmodel.pathMainName]] placeholderImage:[UIImage imageNamed: @"gui_1"]];
    self.contentView.pricebl.text = [NSString stringWithFormat:@"%.2lf",[_Goodsmodel.store_price floatValue]];
    
    self.contentView.shopNumber.text = [NSString stringWithFormat:@"%@",@""];
}
-(void)CreatUI
{
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _backView.backgroundColor =[UIColor blackColor];
    _backView.alpha = 0.0;
    UITapGestureRecognizer * tapdismiss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    //tapdismiss.cancelsTouchesInView = NO;
    [_backView addGestureRecognizer:tapdismiss];
    [self addSubview:_backView];
    _contentView =[XWShopSelectContentView viewFromXib];
    _contentView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, MainViewH);
    _contentView.backgroundColor =[UIColor whiteColor];
    
    [self addSubview:_contentView];
     [self SetupMainCollection];

    [_contentView.addShopCar addTarget:self action:@selector(ClickaddShopCarbtn:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView.gobuy addTarget:self action:@selector(Clickgobuybtn:) forControlEvents:UIControlEventTouchUpInside];
    
   
}
-(void)ClickaddShopCarbtn:(UIButton*)sender
{
    if ([self.degate respondsToSelector:@selector(XWShopSelectSizeView:ClickAddCar:)]) {
        
        [self dismiss];
        
        [self.degate XWShopSelectSizeView:self ClickAddCar:sender];
    }
}
-(void)Clickgobuybtn:(UIButton*)sender
{
    if ([self.degate respondsToSelector:@selector(XWShopSelectSizeView:ClickGoBuy:)]) {
         [self dismiss];
        [self.degate XWShopSelectSizeView:self ClickGoBuy:sender];
    }
}
-(void)show
{

    [self showWith3D:self.show3D];
}

- (void)dismiss
{
    [self dismissWith3D:self.show3D];
    
   
     
        if (_blockUpdateBtnTitle) {
            
            NSString *blockstr=@"";
            NSString *blockparam=@"";
            for (int i=0; i<self.dataArr.count; i++) {
                
                
                
        
                 XWShopcatgorylistModel * model = [self.dataArr objectAtIndex:i];
                
                
                 XWShopcatgoryModel *catgory = [model.catgoryList objectAtIndex:model.index];
                
                blockstr = [NSString stringWithFormat:@"%@ %@",[DJTUtility YRIsEmptString:catgory.value],blockstr];
                
                if ([blockparam isEqualToString:@""]) {
                    
                    blockparam = [NSString stringWithFormat:@"%@:%@",model.catgoryName,catgory.value];
                }
                else
                {
                    blockparam =[NSString stringWithFormat:@"%@ %@:%@",blockparam,model.catgoryName,catgory.value];
                }
            }
            
   

            
            _blockUpdateBtnTitle(blockparam,_goodsCount);
        }
    
    
    

    
}

-(void)showWith3D:(BOOL)isYes
{
    self.show3D = isYes;
    
    if (isYes) {
        //controller 3D transform
        [self.currentVc showWithDuration:ProgressTime];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(ProgressTime/2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      
        [UIView animateWithDuration:ProgressTime animations:^{
            self.contentView.y -= MainViewH;
            // self.contentView.y = SCREEN_HEIGHT - 400;
         //   self.backView.backgroundColor =  GGColors(0, 0, 0, 0.5);
               self.backView.alpha = 0.5;
            
        } completion:^(BOOL finished) {
        }];
        
    });

}

- (void)dismissWith3D:(BOOL)isYes
{
    self.show3D = isYes;
    
     self.backView.alpha = 0;
    [UIView animateWithDuration:ProgressTime animations:^{
        self.contentView.y += MainViewH;
        //self.contentView.y = SCREEN_HEIGHT;
       // self.backView.backgroundColor =  GGColors(0, 0, 0, 0);
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(ProgressTime/2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         if (isYes) {
             //controller 3D transform
             [self.currentVc closeWithDuration:ProgressTime];
         }

     });
    
}
#pragma mark-
#pragma mark- 创建CollectionView
-(void)SetupMainCollection
{

    //居左约束
    UICollectionViewLeftAlignedLayout *leftAlignedLayout = [[UICollectionViewLeftAlignedLayout alloc] init];
   // leftAlignedLayout.minimumLineSpacing = 10;                          //最小行间距
   // leftAlignedLayout.minimumInteritemSpacing = 10;                     //最小列间距
    leftAlignedLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);  //网格上左下右间距

    _mainCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64+35, [UIScreen mainScreen].bounds.size.width, 500) collectionViewLayout:leftAlignedLayout];
     [self.contentView  addSubview:_mainCollection];
    [_mainCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        make.top.mas_equalTo(self.contentView.line.mas_bottom).offset(0);
        make.bottom.mas_equalTo(self.contentView.gobuy.mas_top).offset(0);
    }];
    _mainCollection.delegate = self;
    
    _mainCollection.backgroundColor =[UIColor whiteColor];
    // _mainCollection.
    
    
    _mainCollection.dataSource = self;
    
    [_mainCollection registerNib:[UINib  nibWithNibName:NSStringFromClass([XWShopSelectSizeReusableView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:XWShopSelectSizeReusableHeaderViewID];
    
     [_mainCollection registerNib:[UINib  nibWithNibName:NSStringFromClass([XWShopSelectSizeReusableView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:XWShopSelectSizeReusableFooterViewID];

//    
    [_mainCollection registerNib:[UINib  nibWithNibName:NSStringFromClass([XWShopSelectSizeItem class]) bundle: nil]  forCellWithReuseIdentifier:XWShopSelectSizeItemID];
//
    
   
}

#pragma mark-
#pragma mark-  collectionView 代理方法实现
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.dataArr count]+1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if (section==self.dataArr.count) {
        
        return 0;
    }
    
    XWShopcatgorylistModel * model = [self.dataArr objectAtIndex:section];
    
    
    return model.catgoryList.count;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XWShopSelectSizeItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:XWShopSelectSizeItemID forIndexPath:indexPath];
     XWShopcatgorylistModel * model = [self.dataArr objectAtIndex:indexPath.section];
    XWShopcatgoryModel *catgory = [model.catgoryList objectAtIndex:indexPath.row];
    [cell.contentbl setTitle:[DJTUtility YRIsEmptString:catgory.value] forState:UIControlStateNormal];

    if (model.index == indexPath.row) {

        [cell.contentbl setBackgroundImage:[UIImage imageNamed:@"wk_pre"] forState:UIControlStateNormal];

    }else
    {
        [cell.contentbl setBackgroundImage:[UIImage imageNamed:@"wk"] forState:UIControlStateNormal];

        

    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击Item");
    
    XWShopcatgorylistModel * model = [self.dataArr objectAtIndex:indexPath.section];
    
    // 先清除上次选中撞塌
    XWShopcatgoryModel *hasselect = [model.catgoryList objectAtIndex:model.index];
    hasselect.isSelected = @"0";
    
    XWShopcatgoryModel *currentselect = [model.catgoryList objectAtIndex:indexPath.row];

    currentselect.isSelected = @"1";
    
    // 更新选中下标记录
    model.index = indexPath.row;
    
    [self.mainCollection reloadData];
    
}
// 每个item 上下间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
// 每个item中间的间隔
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, 0.1);
    
    if (section==self.dataArr.count) {
        size = CGSizeMake([UIScreen mainScreen].bounds.size.width, 30);

    }
    return size;
}
// 只有 在UICollectionViewScrollDirectionVertical 状态下才有效  上头 —— item ...－下尾 , 左头－item...－右尾
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, 30);
    
    if (section==self.dataArr.count) {
        
         size = CGSizeMake([UIScreen mainScreen].bounds.size.width, 0.01);
    }
    
    return size;
    
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XWShopcatgorylistModel * model = [self.dataArr objectAtIndex:indexPath.section];
    XWShopcatgoryModel *catgory = [model.catgoryList objectAtIndex:indexPath.row];

    CGFloat W = [self widthFromString:[DJTUtility YRIsEmptString:catgory.value] withFont:[UIFont systemFontOfSize:13] constraintToHeight:20]+30;
    CGSize size = CGSizeMake(W, 30);
    if (indexPath.section==self.dataArr.count) {
         size = CGSizeMake(W, 0.001);
    }
    
    return size;
    
}
/**
 *  显示section
 *
 *  @param collectionView collection
 *  @param kind           是头部还是尾部
 *  @param indexPath      位置
 *
 *  @return UICollectionReusableView
 */
- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionReusableView * reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        XWShopSelectSizeReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:XWShopSelectSizeReusableHeaderViewID forIndexPath:indexPath];
        
        if (indexPath.section==self.dataArr.count) {
             headerView.titlebl.text =@"";
           
        }else
        {
            XWShopcatgorylistModel * model = [self.dataArr objectAtIndex:indexPath.section];
            headerView.titlebl.text = model.catgoryName;

           
        }
        
        reusableview = headerView;
    }else if(kind == UICollectionElementKindSectionFooter)
    {
        XWShopSelectSizeReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:XWShopSelectSizeReusableFooterViewID forIndexPath:indexPath];
        
        
        PPNumberButton *numberButton = [PPNumberButton numberButtonWithFrame:CGRectMake(SCREEN_WIDTH-20-110, 0, 110, 30)];
        // 开启抖动动画
        numberButton.shakeAnimation = YES;
        // 设置最小值
        numberButton.minValue = 1;
        // 设置最大值
        numberButton.maxValue = 999;
        // 设置输入框中的字体大小
        numberButton.inputFieldFont = 13;
        
        /** 加按钮背景图片 */
        numberButton.increaseImage =[UIImage imageNamed:@"jia"];
    
        /** 减按钮背景图片 */
       
          numberButton.decreaseImage =[UIImage imageNamed:@"jian"];

        
        __weak XWShopSelectSizeView *weakself = self;
        numberButton.resultBlock = ^(NSInteger number, BOOL increaseStatus){
        
            weakself.goodsCount = number;
            NSLog(@"购买数量为:%ld",number);
        
        }/* 是否为加状态*/;
        
        [headerView addSubview:numberButton];
        
        reusableview = headerView;
    }
    
    return reusableview;
}
#pragma mark-
#pragma mark- 计算文字长度
- (CGFloat)widthFromString:(NSString*)text withFont:(UIFont*)font constraintToHeight:(CGFloat)height
{
    CGRect rect;
    
    float iosVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (iosVersion >= 7.0) {
        rect = [text boundingRectWithSize:CGSizeMake(1000, height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
    }else {
        CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(1000, height) lineBreakMode:NSLineBreakByWordWrapping];
        rect = CGRectMake(0, 0, size.width, size.height);
    }
    return rect.size.width ;
}
-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr =[[NSMutableArray alloc] init];
    }
    return _dataArr;
}
@end
